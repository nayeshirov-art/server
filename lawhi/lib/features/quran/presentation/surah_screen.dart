import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import 'package:lawhi/core/constants/app_constants.dart';
import 'package:lawhi/core/theme/app_theme.dart';

final _selectedReciterProvider = StateProvider<String>((ref) => 'ar.alafasy');

class SurahScreen extends ConsumerStatefulWidget {
  final int surahId;
  const SurahScreen({super.key, required this.surahId});

  @override
  ConsumerState<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends ConsumerState<SurahScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _verseKeys = {};
  final AudioPlayer _player = AudioPlayer();

  // playlist index → (surahId, verseNumber)
  final List<(int, int)> _indexMap = [];

  int _displaySurah = 1;
  int _displayVerse = 1;
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _displaySurah = widget.surahId;

    _player.currentIndexStream.listen((idx) {
      if (!mounted || idx == null || idx >= _indexMap.length) return;
      final (surah, verse) = _indexMap[idx];
      if (surah != _displaySurah) {
        // New surah — refresh the list and scroll to top
        setState(() {
          _displaySurah = surah;
          _displayVerse = verse;
          _verseKeys.clear();
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut);
          }
        });
      } else {
        setState(() => _displayVerse = verse);
        _scrollToVerse(verse);
      }
    });

    _player.playingStream.listen((p) {
      if (mounted) setState(() => _isPlaying = p);
    });

    _player.processingStateStream.listen((s) {
      if (mounted && s == ProcessingState.completed) {
        setState(() => _isPlaying = false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndPlay());
  }

  @override
  void dispose() {
    _player.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ─── build full-Quran playlist from starting surah ───

  int _globalAyah(int surah, int verse) {
    int n = 0;
    for (int s = 1; s < surah; s++) n += quran.getVerseCount(s);
    return n + verse;
  }

  Future<void> _loadAndPlay({int? fromSurah}) async {
    final start = fromSurah ?? widget.surahId;
    final reciter = ref.read(_selectedReciterProvider);
    setState(() => _isLoading = true);

    _indexMap.clear();
    final sources = <AudioSource>[];

    for (int s = start; s <= 114; s++) {
      final count = quran.getVerseCount(s);
      for (int v = 1; v <= count; v++) {
        _indexMap.add((s, v));
        sources.add(AudioSource.uri(
          Uri.parse(
              '${AppConstants.audioBaseUrl}/$reciter/${_globalAyah(s, v)}.mp3'),
        ));
      }
    }

    try {
      await _player.setAudioSource(
        ConcatenatingAudioSource(children: sources),
        initialIndex: 0,
        initialPosition: Duration.zero,
      );
      setState(() {
        _isLoading = false;
        _displaySurah = start;
        _displayVerse = 1;
      });
      await _player.play();
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  void _scrollToVerse(int verse) {
    final key = _verseKeys[verse];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(key!.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.3);
    }
  }

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

  // Jump to a specific surah from the index list
  Future<void> _jumpToSurah(int surahId) async {
    final idx = _indexMap.indexWhere((e) => e.$1 == surahId);
    if (idx >= 0) {
      await _player.seek(Duration.zero, index: idx);
      if (!_isPlaying) await _player.play();
    }
  }

  // Jump to a specific verse in current surah
  Future<void> _jumpToVerse(int verse) async {
    final idx = _indexMap.indexWhere(
        (e) => e.$1 == _displaySurah && e.$2 == verse);
    if (idx >= 0) {
      await _player.seek(Duration.zero, index: idx);
      if (!_isPlaying) await _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reciter = ref.watch(_selectedReciterProvider);
    final verseCount = quran.getVerseCount(_displaySurah);
    final surahName = quran.getSurahName(_displaySurah);
    final surahNameEn = quran.getSurahNameEnglish(_displaySurah);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(surahName,
                style: const TextStyle(fontFamily: 'Amiri', fontSize: 22)),
            Text('$surahNameEn  •  سورة $_displaySurah',
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
        actions: [
          // Surah picker
          IconButton(
            icon: const Icon(Icons.format_list_numbered_rounded),
            tooltip: 'انتقل إلى سورة',
            onPressed: () async {
              final picked = await showDialog<int>(
                context: context,
                builder: (_) => _SurahPickerDialog(currentSurah: _displaySurah),
              );
              if (picked != null) await _jumpToSurah(picked);
            },
          ),
          // Reciter picker
          PopupMenuButton<String>(
            icon: const Icon(Icons.mic_rounded),
            tooltip: 'اختر القارئ',
            initialValue: reciter,
            constraints: const BoxConstraints(maxHeight: 420),
            onSelected: (v) async {
              ref.read(_selectedReciterProvider.notifier).state = v;
              await _player.stop();
              setState(() {
                _displaySurah = widget.surahId;
                _displayVerse = 1;
                _isPlaying = false;
                _verseKeys.clear();
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
                                    color: Colors.white.withOpacity(0.5)),
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
          // Reciter bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: AppTheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الآية $_displayVerse / $verseCount',
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
                              color: Colors.white.withOpacity(0.45))),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.mic_rounded,
                      color: AppTheme.gold, size: 16),
                ]),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.gold))
                : ListView.builder(
                    key: ValueKey(_displaySurah),
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    itemCount: verseCount + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _SurahHeader(
                          surahId: _displaySurah,
                          surahName: surahName,
                        );
                      }
                      final verseNum = index;
                      _verseKeys[verseNum] ??= GlobalKey();
                      final isActive = _displayVerse == verseNum;
                      final verseText = quran.getVerse(
                          _displaySurah, verseNum,
                          verseEndSymbol: true);

                      return _VerseCard(
                        key: _verseKeys[verseNum],
                        verseNumber: verseNum,
                        verseText: verseText,
                        isActive: isActive,
                        isPlaying: isActive && _isPlaying,
                        onTap: () => _jumpToVerse(verseNum),
                      );
                    },
                  ),
          ),

          // Player bar
          _PlayerBar(
            surahName: surahName,
            verseNumber: _displayVerse,
            totalVerses: verseCount,
            surahNumber: _displaySurah,
            isPlaying: _isPlaying,
            onPlayPause: _togglePlayPause,
            onPrev: _prevVerse,
            onNext: _nextVerse,
          ),
        ],
      ),
    );
  }
}

// ──────────────────────── Surah Picker Dialog ────────────────────────

class _SurahPickerDialog extends StatelessWidget {
  final int currentSurah;
  const _SurahPickerDialog({required this.currentSurah});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        ? AppTheme.primary.withOpacity(0.2)
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
                    subtitle: Text(
                        '${quran.getVerseCount(s)} آية',
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

// ──────────────────────────── Surah header ────────────────────────────

class _SurahHeader extends StatelessWidget {
  final int surahId;
  final String surahName;
  const _SurahHeader({required this.surahId, required this.surahName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Surah name banner
        Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: AppTheme.primary.withOpacity(0.4),
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
        // Bismillah (except Al-Fatiha and At-Tawbah)
        if (surahId != 1 && surahId != 9)
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            padding: const EdgeInsets.symmetric(vertical: 12),
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

// ──────────────────────────── Player bar ────────────────────────────

class _PlayerBar extends StatelessWidget {
  final String surahName;
  final int verseNumber;
  final int totalVerses;
  final int surahNumber;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _PlayerBar({
    required this.surahName,
    required this.verseNumber,
    required this.totalVerses,
    required this.surahNumber,
    required this.isPlaying,
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
        border: const Border(top: BorderSide(color: AppTheme.gold, width: 1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
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
                Text('الآية $verseNumber / $totalVerses  •  س$surahNumber',
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.textSecondary),
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
                  child: Icon(
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

// ──────────────────────────── Verse card ────────────────────────────

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
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withOpacity(0.18)
              : AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                isActive ? AppTheme.gold : Colors.white.withOpacity(0.06),
            width: isActive ? 1.8 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                      color: AppTheme.gold.withOpacity(0.15),
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
                        ? AppTheme.gold.withOpacity(0.15)
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
                  color: isActive ? Colors.white : AppTheme.textPrimary,
                  fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
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
        vsync: this, duration: const Duration(milliseconds: 900))
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
                color: AppTheme.gold.withOpacity(0.7 + 0.3 * scale),
                shape: BoxShape.circle),
          );
        }),
      ),
    );
  }
}
