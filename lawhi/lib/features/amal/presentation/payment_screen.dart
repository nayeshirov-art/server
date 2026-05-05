import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lawhi/core/theme/app_theme.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  static const List<Map<String, dynamic>> _methods = [
    {
      'name': 'Bankily',
      'logo': 'assets/images/bankily.png',
      'number': '34998370',
      'color': Color(0xFF006633),
    },
    {
      'name': 'Masrivi',
      'logo': 'assets/images/masrivi.png',
      'number': '34998370',
      'color': Color(0xFF0055A5),
    },
    {
      'name': 'Bimbank',
      'logo': 'assets/images/bimbank.jfif',
      'number': '34998370',
      'color': Color(0xFF1A237E),
    },
    {
      'name': 'Click',
      'logo': 'assets/images/click.png',
      'number': '34998370',
      'color': Color(0xFF00897B),
    },
    {
      'name': 'Sedad',
      'logo': 'assets/images/sedad.png',
      'number': '34998370',
      'color': Color(0xFFB71C1C),
    },
    {
      'name': 'Bamis Digital',
      'logo': 'assets/images/bamis digital.png',
      'number': '34998370',
      'color': Color(0xFF4A148C),
    },
    {
      'name': 'BCI Pay',
      'logo': 'assets/images/bci.jfif',
      'number': '34998370',
      'color': Color(0xFF0D47A1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر طريقة الدفع',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 20)),
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.mosque_rounded,
                    color: AppTheme.gold, size: 32),
                const SizedBox(height: 8),
                const Text(
                  'التبرع لمشروع بناء المسجد',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 17,
                    color: AppTheme.gold,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  'اختر وسيلة الدفع المناسبة لك',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Liste des méthodes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _methods.length,
              itemBuilder: (context, index) {
                final method = _methods[index];
                return _PaymentMethodCard(method: method);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final Map<String, dynamic> method;
  const _PaymentMethodCard({required this.method});

  @override
  Widget build(BuildContext context) {
    final hasNumber = (method['number'] as String).isNotEmpty;
    return GestureDetector(
      onTap: hasNumber ? () => _showPaymentDetail(context) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasNumber
                ? (method['color'] as Color).withOpacity(0.4)
                : Colors.white.withOpacity(0.07),
          ),
        ),
        child: Row(
          children: [
            // Arrow
            Icon(
              Icons.arrow_back_ios_rounded,
              color: hasNumber ? AppTheme.gold : AppTheme.textSecondary,
              size: 16,
            ),
            const SizedBox(width: 10),
            // Nom
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    method['name'] as String,
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 17,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  if (!hasNumber)
                    Text(
                      'قريباً',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontFamily: 'Amiri',
                      ),
                    ),
                  if (hasNumber)
                    Text(
                      method['number'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.gold,
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Logo
            Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  method['logo'] as String,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(
                    child: Text(
                      method['name'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: method['color'] as Color,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.surfaceCard,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          method['name'] as String,
          style: const TextStyle(
              fontFamily: 'Amiri', fontSize: 22, color: AppTheme.gold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  method['logo'] as String,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'رقم الدفع:',
              style: TextStyle(
                  color: AppTheme.textSecondary, fontFamily: 'Amiri'),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: method['number'] as String));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم نسخ الرقم',
                        style: TextStyle(fontFamily: 'Amiri')),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppTheme.gold.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.copy_rounded,
                        color: AppTheme.gold, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      method['number'] as String,
                      style: const TextStyle(
                        color: AppTheme.gold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'اضغط على الرقم لنسخه',
              style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontFamily: 'Amiri'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
        ],
      ),
    );
  }
}
