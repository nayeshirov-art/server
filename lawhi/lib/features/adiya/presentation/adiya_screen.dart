import 'package:flutter/material.dart';
import 'package:lawhi/core/theme/app_theme.dart';

class AdiyaScreen extends StatelessWidget {
  const AdiyaScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {
      'title': 'أدعية قرآنية',
      'icon': Icons.auto_stories_rounded,
      'color': Color(0xFF1B5E20),
      'items': _quranAdiya,
    },
    {
      'title': 'دعاء الكرب',
      'icon': Icons.favorite_rounded,
      'color': Color(0xFF880E4F),
      'items': _karbAdiya,
    },
    {
      'title': 'دعاء الاستخارة',
      'icon': Icons.help_outline_rounded,
      'color': Color(0xFF1A237E),
      'items': _istikharaAdiya,
    },
    {
      'title': 'دعاء السفر',
      'icon': Icons.flight_rounded,
      'color': Color(0xFF4A148C),
      'items': _safarAdiya,
    },
    {
      'title': 'أدعية الصحة',
      'icon': Icons.healing_rounded,
      'color': Color(0xFF004D40),
      'items': _sihhahAdiya,
    },
    {
      'title': 'أدعية متنوعة',
      'icon': Icons.volunteer_activism_rounded,
      'color': Color(0xFFB71C1C),
      'items': _mutanawwiahAdiya,
    },
  ];

  static const List<Map<String, String>> _quranAdiya = [
    {
      'title': 'دعاء الدنيا والآخرة',
      'arabic': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      'source': 'البقرة: ٢٠١',
    },
    {
      'title': 'دعاء ثبات القلب',
      'arabic': 'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً إِنَّكَ أَنتَ الْوَهَّابُ',
      'source': 'آل عمران: ٨',
    },
    {
      'title': 'دعاء شرح الصدر',
      'arabic': 'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي يَفْقَهُوا قَوْلِي',
      'source': 'طه: ٢٥-٢٨',
    },
    {
      'title': 'دعاء التوبة',
      'arabic': 'رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ',
      'source': 'الأعراف: ٢٣',
    },
    {
      'title': 'دعاء الرحمة والمغفرة',
      'arabic': 'رَبِّ اغْفِرْ وَارْحَمْ وَأَنتَ خَيْرُ الرَّاحِمِينَ',
      'source': 'المؤمنون: ١١٨',
    },
  ];

  static const List<Map<String, String>> _karbAdiya = [
    {
      'title': 'دعاء الكرب العظيم',
      'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ الْعَظِيمُ الْحَلِيمُ، لَا إِلَهَ إِلَّا اللَّهُ رَبُّ الْعَرْشِ الْعَظِيمِ، لَا إِلَهَ إِلَّا اللَّهُ رَبُّ السَّمَاوَاتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيمِ',
      'source': 'متفق عليه',
    },
    {
      'title': 'دعاء يونس عليه السلام',
      'arabic': 'لَا إِلَهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
      'source': 'الأنبياء: ٨٧',
    },
    {
      'title': 'حسبنا الله',
      'arabic': 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
      'source': 'آل عمران: ١٧٣',
    },
  ];

  static const List<Map<String, String>> _istikharaAdiya = [
    {
      'title': 'دعاء الاستخارة',
      'arabic': 'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ، فَإِنَّكَ تَقْدِرُ وَلَا أَقْدِرُ، وَتَعْلَمُ وَلَا أَعْلَمُ، وَأَنْتَ عَلَّامُ الْغُيُوبِ',
      'source': 'رواه البخاري',
    },
  ];

  static const List<Map<String, String>> _safarAdiya = [
    {
      'title': 'دعاء ركوب الدابة',
      'arabic': 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنقَلِبُونَ',
      'source': 'الزخرف: ١٣-١٤',
    },
    {
      'title': 'دعاء السفر',
      'arabic': 'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْعَمَلِ مَا تَرْضَى، اللَّهُمَّ هَوِّنْ عَلَيْنَا سَفَرَنَا هَذَا وَاطْوِ عَنَّا بُعْدَهُ',
      'source': 'رواه مسلم',
    },
    {
      'title': 'دعاء دخول البلد',
      'arabic': 'اللَّهُمَّ بَارِكْ لَنَا فِيهَا، اللَّهُمَّ ارْزُقْنَا جَنَاهَا، وَحَبِّبْنَا إِلَى أَهْلِهَا، وَحَبِّبْ صَالِحِي أَهْلِهَا إِلَيْنَا',
      'source': 'رواه الطبراني',
    },
  ];

  static const List<Map<String, String>> _sihhahAdiya = [
    {
      'title': 'دعاء الشفاء',
      'arabic': 'اللَّهُمَّ رَبَّ النَّاسِ، أَذْهِبِ الْبَأْسَ، اشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمَاً',
      'source': 'متفق عليه',
    },
    {
      'title': 'الرقية الشرعية',
      'arabic': 'بِسْمِ اللَّهِ أَرْقِيكَ، مِنْ كُلِّ شَيْءٍ يُؤْذِيكَ، مِنْ شَرِّ كُلِّ نَفْسٍ أَوْ عَيْنٍ حَاسِدٍ، اللَّهُ يَشْفِيكَ، بِسْمِ اللَّهِ أَرْقِيكَ',
      'source': 'رواه مسلم',
    },
  ];

  static const List<Map<String, String>> _mutanawwiahAdiya = [
    {
      'title': 'دعاء دخول المنزل',
      'arabic': 'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ، بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
      'source': 'رواه أبو داود',
    },
    {
      'title': 'دعاء قبل النوم',
      'arabic': 'اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
      'source': 'رواه البخاري',
    },
    {
      'title': 'دعاء الهم والحزن',
      'arabic': 'اللَّهُمَّ إِنِّي عَبْدُكَ، ابْنُ عَبْدِكَ، ابْنُ أَمَتِكَ، نَاصِيَتِي بِيَدِكَ، مَاضٍ فِيَّ حُكْمُكَ، عَدْلٌ فِيَّ قَضَاؤُكَ، أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ',
      'source': 'رواه أحمد',
    },
    {
      'title': 'دعاء قضاء الدين',
      'arabic': 'اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
      'source': 'رواه الترمذي',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدعية',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.9,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final cat = _categories[index];
            return _AdiyaCard(
              title: cat['title'] as String,
              icon: cat['icon'] as IconData,
              color: cat['color'] as Color,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdiyaDetailScreen(
                    title: cat['title'] as String,
                    color: cat['color'] as Color,
                    items: cat['items'] as List<Map<String, String>>,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AdiyaCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AdiyaCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.85), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          boxShadow: [
            BoxShadow(
                color: color.withValues(alpha: 0.45),
                blurRadius: 14,
                offset: const Offset(0, 7)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
                border:
                    Border.all(color: Colors.white.withOpacity(0.2), width: 1),
              ),
              child: Icon(icon, size: 34, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AdiyaDetailScreen extends StatelessWidget {
  final String title;
  final Color color;
  final List<Map<String, String>> items;

  const AdiyaDetailScreen({
    super.key,
    required this.title,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(fontFamily: 'Amiri', fontSize: 22)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['source'] ?? '',
                        style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                            fontFamily: 'Amiri'),
                      ),
                      Text(
                        item['title'] ?? '',
                        style: TextStyle(
                            color: color == const Color(0xFF1B5E20)
                                ? AppTheme.primaryLight
                                : AppTheme.gold,
                            fontSize: 15,
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    item['arabic'] ?? '',
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 20,
                      height: 2.0,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
