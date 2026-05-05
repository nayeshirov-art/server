import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import 'package:lawhi/core/constants/app_constants.dart';
import 'package:lawhi/core/theme/app_theme.dart';

final _selectedReciterProvider = StateProvider<String>((ref) => 'ar.alafasy');

// Precomputed cumulative verse counts — O(1) globalAyah lookup
final List<int> _cumulative = () {
  final r = [0];
  for (int s = 1; s <= 114; s++) r.add(r.last + quran.getVerseCount(s));
  return r;
}();

// ─── Item types for the continuous Quran list ───────────────────────
abstract class _Item { const _Item(); }

class _SurahHeaderItem extends _Item {
  final int surahId;
  const _SurahHeaderItem(this.surahId);
}

class _JuzItem extends _Item {
  final int juzNum;
  const _JuzItem(this.juzNum);
}

class _VerseItem extends _Item {
  final int surahId;
  final int verse;
  const _VerseItem(this.surahId, this.verse);
}

// ─── Screen ─────────────────────────────────────────────────────────
class SurahScreen extends ConsumerStatefulWidget {
  final int surahId;
  const SurahScreen({super.key, required this.surahId});

  @override
  ConsumerState<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends ConsumerState<SurahScreen> {
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _player = AudioPlayer();

  // Flat item list for the continuous Quran book view
  final List<_Item> _items = [];
  // (surahId, verse) → index in _items
  final Map<(int, int), int> _verseIdx = {};
  // surahId → index of its header in _items
  final Map<int, int> _surahIdx = {};
  // item index → GlobalKey (created lazily in itemBuilder)
  final Map<int, GlobalKey> _keys = {};

  // Audio playlist index → (surahId, verse)
  final List<(int, int)> _indexMap = [];

  int _activeSurah = 1;
  int _activeVerse = 1;
  bool _isPlaying = false;
  bool _isLoading = false;

  // Auto-scroll: paused when user manually scrolls, resumes after 4 s
  bool _autoScroll = true;
  Timer? _scrollResumeTimer;

  @override
  void initState() {
    super.initState();
    _activeSurah = widget.surahId;
    _buildItems();

    _player.currentIndexStream.listen((idx) {
      if (!mounted || idx == null || idx >= _indexMap.length) return;
      final (surah, verse) = _indexMap[idx];
      setState(() {
        _activeSurah = surah;
        _activeVerse = verse;
      });
      _scrollToActive();
    });

    _player.playingStream.listen((p) {
      if (mounted) setState(() => _isPlaying = p);
    });

    _player.processingStateStream.listen((s) {
      if (!mounted) return;
      if (s == ProcessingState.completed) {
        if (_activeSurah < 114) {
          _loadAndPlay(fromSurah: _activeSurah + 1);
        } else {
          setState(() => _isPlaying = false);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndPlay());
  }

  @override
  void dispose() {
    _scrollResumeTimer?.cancel();
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ─── Build the continuous item list ──────────────────────────────
  void _buildItems() {
    _items.clear();
    _verseIdx.clear();
    _surahIdx.clear();
    int prevJuz = -1;

    for (int s = widget.surahId; s <= 114; s++) {
      _surahIdx[s] = _items.length;
      _items.add(_SurahHeaderItem(s));

      final count = quran.getVerseCount(s);
      for (int v = 1; v <= count; v++) {
        final juz = quran.getJuzNumber(s, v);
        if (juz != prevJuz) {
          // Don't show juz marker at the very first verse
          if (!(s == widget.surahId && v == 1)) {
            _items.add(_JuzItem(juz));
          }
          prevJuz = juz;
        }
        _verseIdx[(s, v)] = _items.length;
        _items.add(_VerseItem(s, v));
      }
    }
  }

  // ─── Audio ───────────────────────────────────────────────────────
  int _globalAyah(int surah, int verse) => _cumulative[surah - 1] + verse;

  Future<void> _loadAndPlay({int? fromSurah}) async {
    final surahToPlay = fromSurah ?? widget.surahId;
    if (surahToPlay > 114) return;
    final reciter = ref.read(_selectedReciterProvider);
    setState(() => _isLoading = true);

    _indexMap.clear();
    final sources = <AudioSource>[];
    final count = quran.getVerseCount(surahToPlay);

    for (int v = 1; v <= count; v++) {
      _indexMap.add((surahToPlay, v));
      sources.add(AudioSource.uri(Uri.parse(
        '${AppConstants.audioBaseUrl}/$reciter/${_globalAyah(surahToPlay, v)}.mp3',
      )));
    }

    try {
      await _player.setAudioSource(
        ConcatenatingAudioSource(useLazyPreparation: true, children: sources),
        initialIndex: 0,
        initialPosition: Duration.zero,
      );
      setState(() {
        _isLoading = false;
        _activeSurah = surahToPlay;
        _activeVerse = 1;
      });
      await _player.play();
    } catch (e) {
      debugPrint('Audio error: $e');
      setState(() => _isLoading = false);
    }
  }

  // ─── Scroll ──────────────────────────────────────────────────────
  void _scrollToActive() {
    if (!_autoScroll) return;
    final i = _verseIdx[(_activeSurah, _activeVerse)];
    if (i == null) return;
    final key = _keys[i];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
  }

  void _onUserScrollStart() {
    _autoScroll = false;
    _scrollResumeTimer?.cancel();
    _scrollResumeTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _autoScroll = true);
    });
  }

  // ─── Controls ────────────────────────────────────────────────────
  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      if (_player.processingState == ProcessingState.completed) {
        await _player.seek(Duration.zero, index: 0);
      }
      await _player.play();
    }
  }

  Future<void> _prevVerse() async {
    if (_player.hasPrevious) await _player.seekToPrevious();
  }

  Future<void> _nextVerse() async {
    if (_player.hasNext) await _player.seekToNext();
  }

  Future<void> _jumpToSurah(int surahId) async {
    await _player.stop();
    setState(() {
      _activeSurah = surahId;
      _activeVerse = 1;
      _autoScroll = true;
    });
    // Scroll to surah header in the continuous list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final i = _surahIdx[surahId];
      if (i == null) return;
      final key = _keys[i];
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
    await _loadAndPlay(fromSurah: surahId);
  }

  Future<void> _jumpToVerse(int surah, int verse) async {
    if (surah != _activeSurah) {
      await _player.stop();
      await _loadAndPlay(fromSurah: surah);
    } else {
      final idx = _indexMap.indexWhere((e) => e.$1 == surah && e.$2 == verse);
      if (idx >= 0) {
        await _player.seek(Duration.zero, index: idx);
        if (!_isPlaying) await _player.play();
      }
    }
  }

  // ─── Build ───────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final reciter = ref.watch(_selectedReciterProvider);
    final surahName = quran.getSurahName(_activeSurah);
    final surahNameEn = quran.getSurahNameEnglish(_activeSurah);
    final verseCount = quran.getVerseCount(_activeSurah);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(surahName,
                style: const TextStyle(fontFamily: 'Amiri', fontSize: 22)),
            Text('$surahNameEn  •  سورة $_activeSurah',
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_list_numbered_rounded),
            tooltip: 'انتقل إلى سورة',
            onPressed: () async {
              final picked = await showDialog<int>(
                context: context,
                builder: (_) => _SurahPickerDialog(currentSurah: _activeSurah),
              );
              if (picked != null) await _jumpToSurah(picked);
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.mic_rounded),
            tooltip: 'اختر القارئ',
            initialValue: reciter,
            constraints: const BoxConstraints(maxHeight: 440),
            onSelected: (v) async {
              ref.read(_selectedReciterProvider.notifier).state = v;
              await _player.stop();
              setState(() {
                _activeSurah = widget.surahId;
                _activeVerse = 1;
                _isPlaying = false;
              });
              await _loadAndPlay();
            },
            itemBuilder: (_) => AppConstants.reciters.entries
                .map((e) => PopupMenuItem(
                      value: e.key,
                      child: Row(children: [
                        if (e.key == reciter)
                          const Icon(Icons.check,
                              color: AppTheme.gold, size: 18)
                        else
                          const SizedBox(width: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(e.value,
                                  style: const TextStyle(
                                      fontFamily: 'Amiri', fontSize: 15),
                                  textDirection: TextDirection.rtl),
                              Text(
                                AppConstants.recitersFr[e.key] ?? '',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.5)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Current reciter + verse indicator
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: AppTheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الآية $_activeVerse / $verseCount',
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.textSecondary),
                ),
                Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppConstants.reciters[reciter] ?? '',
                          style: const TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 13,
                              color: AppTheme.gold)),
                      Text(AppConstants.recitersFr[reciter] ?? '',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withValues(alpha: 0.45))),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.mic_rounded,
                      color: AppTheme.gold, size: 16),
                ]),
              ],
            ),
          ),

          // Continuous Quran book
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (n) {
                if (n is ScrollStartNotification &&
                    n.dragDetails != null) {
                  _onUserScrollStart();
                }
                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.fromLTRB(8, 4, 8, 8),
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  final item = _items[i];

                  if (item is _SurahHeaderItem) {
                    final key = _keys[i] ??= GlobalKey();
                    return _SurahHeader(
                      key: key,
                      surahId: item.surahId,
                      surahName: quran.getSurahName(item.surahId),
                    );
                  }

                  if (item is _JuzItem) {
                    return _JuzDivider(juzNum: item.juzNum);
                  }

                  if (item is _VerseItem) {
                    final key = _keys[i] ??= GlobalKey();
                    final isActive = item.surahId == _activeSurah &&
                        item.verse == _activeVerse;
                    return _VerseCard(
                      key: key,
                      verseNumber: item.verse,
                      verseText: quran.getVerse(
                          item.surahId, item.verse,
                          verseEndSymbol: true),
                      isActive: isActive,
                      isPlaying: isActive && _isPlaying,
                      onTap: () =>
                          _jumpToVerse(item.surahId, item.verse),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          // Player bar
          _PlayerBar(
            surahName: surahName,
            verseNumber: _activeVerse,
            totalVerses: verseCount,
            surahNumber: _activeSurah,
            isPlaying: _isPlaying,
            isLoading: _isLoading,
            onPlayPause: _togglePlayPause,
            onPrev: _prevVerse,
            onNext: _nextVerse,
          ),
        ],
      ),
    );
  }
}

// ─── Surah Picker Dialog ─────────────────────────────────────────────
class _SurahPickerDialog extends StatelessWidget {
  final int currentSurah;
  const _SurahPickerDialog({required this.currentSurah});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.surface,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('اختر سورة',
                  style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      color: AppTheme.gold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 114,
                itemBuilder: (_, i) {
                  final s = i + 1;
                  final name = quran.getSurahName(s);
                  final isSelected = s == currentSurah;
                  return ListTile(
                    onTap: () => Navigator.pop(context, s),
                    tileColor: isSelected
                        ? AppTheme.primary.withValues(alpha: 0.2)
                        : null,
                    leading: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isSelected
                                ? AppTheme.gold
                                : AppTheme.primary,
                            width: 1.5),
                      ),
                      child: Center(
                        child: Text('$s',
                            style: TextStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? AppTheme.gold
                                    : AppTheme.primaryLight)),
                      ),
                    ),
                    title: Text(name,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18,
                            color: isSelected
                                ? AppTheme.gold
                                : AppTheme.textPrimary)),
                    subtitle: Text('${quran.getVerseCount(s)} آية',
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary)),
                    trailing: isSelected
                        ? const Icon(Icons.volume_up_rounded,
                            color: AppTheme.gold, size: 18)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Surah header ────────────────────────────────────────────────────
class _SurahHeader extends StatelessWidget {
  final int surahId;
  final String surahName;
  const _SurahHeader(
      {super.key, required this.surahId, required this.surahName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12, 16, 12, 6),
          padding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Center(
            child: Text(surahName,
                style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl),
          ),
        ),
        if (surahId != 1 && surahId != 9)
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 6),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
                style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 20,
                    color: AppTheme.gold),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Juz divider ─────────────────────────────────────────────────────
class _JuzDivider extends StatelessWidget {
  final int juzNum;
  const _JuzDivider({required this.juzNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Expanded(
              child: Divider(
                  color: AppTheme.gold.withValues(alpha: 0.4),
                  thickness: 1)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.gold.withValues(alpha: 0.4)),
            ),
            child: Text(
              'الجزء $juzNum',
              style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 14,
                  color: AppTheme.gold),
            ),
          ),
          Expanded(
              child: Divider(
                  color: AppTheme.gold.withValues(alpha: 0.4),
                  thickness: 1)),
        ],
      ),
    );
  }
}

// ─── Player bar ──────────────────────────────────────────────────────
class _PlayerBar extends StatelessWidget {
  final String surahName;
  final int verseNumber;
  final int totalVerses;
  final int surahNumber;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onPlayPause;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _PlayerBar({
    required this.surahName,
    required this.verseNumber,
    required this.totalVerses,
    required this.surahNumber,
    required this.isPlaying,
    required this.isLoading,
    required this.onPlayPause,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2B0E), AppTheme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border:
            const Border(top: BorderSide(color: AppTheme.gold, width: 1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, -4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(surahName,
                    style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 16,
                        color: AppTheme.gold,
                        fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl),
                Text(
                    'الآية $verseNumber / $totalVerses  •  س$surahNumber',
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary),
                    textDirection: TextDirection.rtl),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_next_rounded,
                    color: Colors.white, size: 26),
                onPressed: onNext,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onPlayPause,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      color: AppTheme.gold, shape: BoxShape.circle),
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 2),
                        )
                      : Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded,
                    color: Colors.white, size: 26),
                onPressed: onPrev,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Verse card ──────────────────────────────────────────────────────
class _VerseCard extends StatelessWidget {
  final int verseNumber;
  final String verseText;
  final bool isActive;
  final bool isPlaying;
  final VoidCallback onTap;

  const _VerseCard({
    super.key,
    required this.verseNumber,
    required this.verseText,
    required this.isActive,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.18)
              : AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive
                ? AppTheme.gold
                : Colors.white.withValues(alpha: 0.06),
            width: isActive ? 1.8 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                      color: AppTheme.gold.withValues(alpha: 0.15),
                      blurRadius: 14,
                      spreadRadius: 1)
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            isActive ? AppTheme.gold : AppTheme.primary,
                        width: 1.5),
                    color: isActive
                        ? AppTheme.gold.withValues(alpha: 0.15)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text('$verseNumber',
                        style: TextStyle(
                            color: isActive
                                ? AppTheme.gold
                                : AppTheme.primaryLight,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: isActive ? 25 : 22,
                  height: 2.1,
                  color:
                      isActive ? Colors.white : AppTheme.textPrimary,
                  fontWeight: isActive
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                child: Text(verseText,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right),
              ),
              if (isActive && isPlaying) ...[
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _PlayingDots(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayingDots extends StatefulWidget {
  @override
  State<_PlayingDots> createState() => _PlayingDotsState();
}

class _PlayingDotsState extends State<_PlayingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final t = (_ctrl.value - i * 0.2).clamp(0.0, 1.0);
          final scale = 0.6 + 0.4 * (1 - (2 * t - 1).abs());
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6 * scale,
            height: 6 * scale,
            decoration: BoxDecoration(
                color: AppTheme.gold.withValues(alpha: 0.7 + 0.3 * scale),
                shape: BoxShape.circle),
          );
        }),
      ),
    );
  }
}
