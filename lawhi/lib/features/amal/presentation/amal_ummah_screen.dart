import 'package:flutter/material.dart';
import 'package:lawhi/core/theme/app_theme.dart';
import 'package:lawhi/features/amal/presentation/payment_screen.dart';

class AmalUmmahScreen extends StatefulWidget {
  const AmalUmmahScreen({super.key});

  @override
  State<AmalUmmahScreen> createState() => _AmalUmmahScreenState();
}

class _AmalUmmahScreenState extends State<AmalUmmahScreen> {
  int _collected = 1_250_000;
  final int _goal = 5_000_000;

  static const List<Map<String, dynamic>> _causes = [
    {
      'title': 'كفالة يتيم',
      'desc': 'كن سببًا في سعادة طفل يتيم وتعليمه',
      'icon': Icons.child_care_rounded,
      'color': Color(0xFF1B5E20),
      'amount': '500 دج / شهر',
    },
    {
      'title': 'إطعام مسكين',
      'desc': 'وجبة دافئة لعائلة محتاجة كل يوم',
      'icon': Icons.restaurant_rounded,
      'color': Color(0xFF0D47A1),
      'amount': '200 دج / وجبة',
    },
    {
      'title': 'تعليم قرآن',
      'desc': 'ساعد في تحفيظ كتاب الله للأطفال',
      'icon': Icons.auto_stories_rounded,
      'color': Color(0xFFE65100),
      'amount': '300 دج / شهر',
    },
    {
      'title': 'علاج مريض',
      'desc': 'أسهم في علاج من لا يستطيع الدفع',
      'icon': Icons.healing_rounded,
      'color': Color(0xFFB71C1C),
      'amount': 'حسب الحاجة',
    },
    {
      'title': 'صندوق الزكاة',
      'desc': 'أخرج زكاتك وطهّر مالك',
      'icon': Icons.monetization_on_rounded,
      'color': Color(0xFF004D40),
      'amount': '2.5% من المال',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final progress = (_collected / _goal).clamp(0.0, 1.0);
    final percent = (progress * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أمل الأمة',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---- مشروع المسجد المميز ----
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A0A3E), Color(0xFF3A1278), Color(0xFF6A1B9A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.gold.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6A1B9A).withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Badge مشروع مميز
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.gold,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '⭐ مشروع مميز',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Icon(Icons.mosque_rounded,
                                color: AppTheme.gold, size: 36),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Titre
                        const Text(
                          'مشروع بناء المسجد',
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'صدقة جارية — أجرها يجري بعد وفاتك',
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.75),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 20),
                        // Barre de progression
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$percent%',
                              style: const TextStyle(
                                  color: AppTheme.gold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              'الهدف: ${_formatAmount(_goal)} دج',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                                fontFamily: 'Amiri',
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.gold),
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تم جمع ${_formatAmount(_collected)} دج',
                          style: const TextStyle(
                            color: AppTheme.gold,
                            fontFamily: 'Amiri',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 16),
                        // Bouton
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gold,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
                            icon: const Icon(Icons.favorite_rounded, size: 20),
                            label: const Text(
                              'تبرع لبناء المسجد',
                              style: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Verset
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.gold.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Text(
                    '﴿ إِنَّمَا يَعْمُرُ مَسَاجِدَ اللَّهِ مَنْ آمَنَ بِاللَّهِ وَالْيَوْمِ الْآخِرِ ﴾',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 16,
                      color: AppTheme.gold,
                      height: 1.8,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'التوبة: ١٨',
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // وسائل الدفع
            const Text(
              'وسائل الدفع',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 20,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),
            _buildPaymentMethods(),
            const SizedBox(height: 24),
            // Titre autres causes
            const Text(
              'وجوه الخير الأخرى',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 20,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _causes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) =>
                  _CauseCard(cause: _causes[index]),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Bankily', 'logo': 'assets/images/bankily.png'},
    {'name': 'Masrivi', 'logo': 'assets/images/masrivi.png'},
    {'name': 'Bimbank', 'logo': 'assets/images/bimbank.jfif'},
    {'name': 'Click', 'logo': 'assets/images/click.png'},
    {'name': 'Sedad', 'logo': 'assets/images/sedad.png'},
    {'name': 'Bamis Digital', 'logo': 'assets/images/bamis digital.png'},
    {'name': 'BCI Pay', 'logo': 'assets/images/bci.jfif'},
  ];

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'رقم الدفع: 34998370',
            style: const TextStyle(
              fontFamily: 'Amiri',
              fontSize: 16,
              color: AppTheme.gold,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: _paymentMethods.map((m) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                ),
                child: Container(
                  width: 76,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      m['logo'] as String,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          m['name'] as String,
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatAmount(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)} م';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)} ألف';
    }
    return '$amount';
  }

  void _showMosqueDonateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'مشروع بناء المسجد',
          style: TextStyle(
              fontFamily: 'Amiri', fontSize: 22, color: AppTheme.gold),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mosque_rounded, color: AppTheme.gold, size: 48),
            const SizedBox(height: 12),
            const Text(
              'ساهم في بناء بيت من بيوت الله\nصدقة جارية تدوم بعد وفاتك',
              style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                  height: 1.6),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.gold,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              setState(() => _collected += 1000);
              Navigator.pop(context);
            },
            child: const Text('تبرع الآن',
                style: TextStyle(
                    fontFamily: 'Amiri', fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _CauseCard extends StatelessWidget {
  final Map<String, dynamic> cause;
  const _CauseCard({required this.cause});

  @override
  Widget build(BuildContext context) {
    final color = cause['color'] as Color;
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.85), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.18),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: Icon(cause['icon'] as IconData,
                    size: 32, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                cause['title'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                cause['amount'] as String,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                  fontFamily: 'Amiri',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final color = cause['color'] as Color;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          cause['title'] as String,
          style: const TextStyle(
              fontFamily: 'Amiri', fontSize: 22, color: AppTheme.gold),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cause['desc'] as String,
              style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 15,
                  color: AppTheme.textPrimary),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
              ),
              child: Text(
                cause['amount'] as String,
                style: const TextStyle(
                    color: AppTheme.gold,
                    fontFamily: 'Amiri',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('تبرع الآن',
                style: TextStyle(
                    fontFamily: 'Amiri', fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
