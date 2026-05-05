import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran/quran.dart' as quran;
import 'package:lawhi/core/theme/app_theme.dart';

class QuranIndexScreen extends StatefulWidget {
  const QuranIndexScreen({super.key});

  @override
  State<QuranIndexScreen> createState() => _QuranIndexScreenState();
}

class _QuranIndexScreenState extends State<QuranIndexScreen>
    with SingleTickerProviderStateMixin {
  String _search = '';
  late TabController _tabController;

  // (surahId, verseId) — début de chaque juz'
  static const List<(int, int)> _juzStart = [
    (1, 1),   (2, 142), (2, 253), (3, 93),  (4, 24),
    (4, 148), (5, 82),  (6, 111), (7, 88),  (8, 41),
    (9, 93),  (11, 6),  (12, 53), (15, 1),  (17, 1),
    (18, 75), (21, 1),  (23, 1),  (25, 21), (27, 56),
    (29, 46), (33, 31), (36, 28), (39, 32), (41, 47),
    (46, 1),  (51, 31), (58, 1),  (67, 1),  (78, 1),
  ];

  // (surahId, verseId) — début de chaque hizb (60 hizb)
  static const List<(int, int)> _hizbStart = [
    (1,  1),  (2,  26),  // Juz 1
    (2, 142), (2, 204),  // Juz 2
    (2, 253), (3,  15),  // Juz 3
    (3,  93), (3, 171),  // Juz 4
    (4,  24), (4,  88),  // Juz 5
    (4, 148), (5,   4),  // Juz 6
    (5,  82), (6,  36),  // Juz 7
    (6, 111), (7,  16),  // Juz 8
    (7,  88), (8,   1),  // Juz 9
    (8,  41), (9,  38),  // Juz 10
    (9,  93), (10, 26),  // Juz 11
    (11,  6), (11, 97),  // Juz 12
    (12, 53), (13, 19),  // Juz 13
    (15,  1), (16, 52),  // Juz 14
    (17,  1), (18, 17),  // Juz 15
    (18, 75), (20,  1),  // Juz 16
    (21,  1), (22, 19),  // Juz 17
    (23,  1), (24, 22),  // Juz 18
    (25, 21), (27,  1),  // Juz 19
    (27, 56), (28, 51),  // Juz 20
    (29, 46), (32,  1),  // Juz 21
    (33, 31), (35,  1),  // Juz 22
    (36, 28), (38,  1),  // Juz 23
    (39, 32), (41,  1),  // Juz 24
    (41, 47), (43, 24),  // Juz 25
    (46,  1), (49,  1),  // Juz 26
    (51, 31), (55,  1),  // Juz 27
    (58,  1), (62,  1),  // Juz 28
    (67,  1), (73,  1),  // Juz 29
    (78,  1), (93,  1),  // Juz 30
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = List.generate(114, (i) => i + 1).where((i) {
      if (_search.isEmpty) return true;
      final name = quran.getSurahName(i);
      final nameEn = quran.getSurahNameEnglish(i);
      return name.contains(_search) ||
          nameEn.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gold,
          indicatorWeight: 3,
          labelColor: AppTheme.gold,
          unselectedLabelColor: AppTheme.textSecondary,
          labelStyle: const TextStyle(fontFamily: 'Amiri', fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Amiri', fontSize: 15),
          tabs: const [Tab(text: 'السور'), Tab(text: 'الأجزاء'), Tab(text: 'الأحزاب')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSurahTab(filtered),
          _buildJuzTab(),
          _buildHizbTab(),
        ],
      ),
    );
  }

  Widget _buildSurahTab(List<int> filtered) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: (v) => setState(() => _search = v),
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'ابحث عن سورة...',
              hintStyle: const TextStyle(fontFamily: 'Amiri'),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppTheme.surfaceCard,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final surahId = filtered[index];
              final name = quran.getSurahName(surahId);
              final nameEn = quran.getSurahNameEnglish(surahId);
              final verseCount = quran.getVerseCount(surahId);
              final type = quran.getPlaceOfRevelation(surahId);
              final isMeccan = type == 'Meccan';

              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: ListTile(
                  onTap: () => context.go('/quran/$surahId'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$surahId',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 20,
                        color: AppTheme.textPrimary),
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    '$nameEn  •  $verseCount آية',
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textSecondary),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isMeccan
                          ? const Color(0xFFFF8F00).withOpacity(0.12)
                          : const Color(0xFF1565C0).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isMeccan
                            ? const Color(0xFFFF8F00).withOpacity(0.35)
                            : const Color(0xFF1565C0).withOpacity(0.35),
                      ),
                    ),
                    child: Text(
                      isMeccan ? 'مكية' : 'مدنية',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Amiri',
                        color: isMeccan
                            ? const Color(0xFFFFB300)
                            : const Color(0xFF64B5F6),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHizbTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: 60,
      itemBuilder: (context, index) {
        final hizbNum = index + 1;
        final (surahId, verseId) = _hizbStart[index];
        final surahName = quran.getSurahName(surahId);
        final surahNameEn = quran.getSurahNameEnglish(surahId);
        final juzNum = (hizbNum / 2).ceil();
        final isSecondHalf = hizbNum.isEven;

        return GestureDetector(
          onTap: () => context.go('/quran/$surahId'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSecondHalf
                    ? AppTheme.gold.withOpacity(0.12)
                    : AppTheme.gold.withOpacity(0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Hizb number circle
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isSecondHalf
                          ? [const Color(0xFF1A3A1C), const Color(0xFF2E5E32)]
                          : [const Color(0xFF0F3314), const Color(0xFF1B5E20)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: isSecondHalf
                          ? AppTheme.gold.withOpacity(0.5)
                          : AppTheme.gold,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$hizbNum',
                      style: TextStyle(
                        color: isSecondHalf
                            ? AppTheme.gold.withOpacity(0.8)
                            : AppTheme.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            isSecondHalf ? 'نصف الجزء $juzNum' : 'الجزء $juzNum',
                            style: TextStyle(
                              color: isSecondHalf
                                  ? AppTheme.textSecondary
                                  : AppTheme.gold,
                              fontSize: 11,
                              fontFamily: 'Amiri',
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'الحزب $hizbNum',
                            style: const TextStyle(
                              color: AppTheme.gold,
                              fontSize: 16,
                              fontFamily: 'Amiri',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'يبدأ من سورة $surahName — آية $verseId',
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontFamily: 'Amiri',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        surahNameEn,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_back_ios_rounded,
                    color: AppTheme.textSecondary, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJuzTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: 30,
      itemBuilder: (context, index) {
        final juzNum = index + 1;
        final (surahId, verseId) = _juzStart[index];
        final surahName = quran.getSurahName(surahId);
        final surahNameEn = quran.getSurahNameEnglish(surahId);

        return GestureDetector(
          onTap: () => context.go('/quran/$surahId'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.gold.withOpacity(0.18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F3314), Color(0xFF1B5E20)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: AppTheme.gold, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      '$juzNum',
                      style: const TextStyle(
                        color: AppTheme.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الجزء $juzNum',
                        style: const TextStyle(
                          color: AppTheme.gold,
                          fontSize: 18,
                          fontFamily: 'Amiri',
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'يبدأ من سورة $surahName — آية $verseId',
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontFamily: 'Amiri',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        surahNameEn,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_back_ios_rounded,
                    color: AppTheme.textSecondary, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
