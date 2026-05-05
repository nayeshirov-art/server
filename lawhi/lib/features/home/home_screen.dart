import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lawhi/core/constants/routes.dart';
import 'package:lawhi/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildGrid(context),
              const SizedBox(height: 16),
              _buildAmalCard(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmalCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => context.go(Routes.amalUmmah),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5C3000), Color(0xFFB8860B), Color(0xFFD4AF37)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFD4AF37).withOpacity(0.4),
                blurRadius: 18,
                offset: const Offset(0, 8),
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
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.5),
                ),
                child: const Icon(Icons.favorite_rounded, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'أمل الأمة',
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'تصدَّق وابتغِ وجه الله',
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.75),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF071209), Color(0xFF0D2B10), Color(0xFF1A5C1E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: Stack(
        children: [
          // Cercle décoratif gauche
          Positioned(
            top: -10,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.gold.withOpacity(0.06),
              ),
            ),
          ),
          // Cercle décoratif droite
          Positioned(
            bottom: -10,
            right: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Column(
            children: [
              // Bismillah
              Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 16,
                  color: AppTheme.gold.withOpacity(0.8),
                  letterSpacing: 0.5,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              // Logo
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.gold, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gold.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/lawhi.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Nom app
              const Text(
                'لوحي',
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 38,
                  color: AppTheme.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'رفيقك الإسلامي اليومي',
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final items = [
      _MenuItem(
        icon: Icons.import_contacts_rounded,
        label: 'القرآن الكريم',
        subtitle: 'اقرأ وتدبر',
        decorText: 'قرآن',
        gradientColors: const [Color(0xFF004D2C), Color(0xFF00875A)],
        shadowColor: const Color(0xFF00875A),
        route: Routes.quranIndex,
      ),
      _MenuItem(
        icon: Icons.local_florist_rounded,
        label: 'الأذكار',
        subtitle: 'صباح ومساء',
        decorText: 'ذكر',
        gradientColors: const [Color(0xFF00306E), Color(0xFF1565C0)],
        shadowColor: const Color(0xFF1565C0),
        route: Routes.adhkar,
      ),
      _MenuItem(
        icon: Icons.navigation_rounded,
        label: 'القبلة',
        subtitle: 'اتجاه الكعبة',
        decorText: 'قبلة',
        gradientColors: const [Color(0xFF3A006F), Color(0xFF7B1FA2)],
        shadowColor: const Color(0xFF7B1FA2),
        route: Routes.qibla,
      ),
      _MenuItem(
        icon: Icons.front_hand_rounded,
        twoHands: true,
        label: 'الأدعية',
        subtitle: 'ادعُ ربك',
        decorText: 'دعاء',
        gradientColors: const [Color(0xFF7A0010), Color(0xFFD32F2F)],
        shadowColor: const Color(0xFFD32F2F),
        route: Routes.adiya,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.88,
        ),
        itemBuilder: (context, index) => _MenuCard(item: items[index]),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final bool twoHands;
  final String label;
  final String subtitle;
  final String decorText;
  final List<Color> gradientColors;
  final Color shadowColor;
  final String route;

  const _MenuItem({
    required this.icon,
    this.twoHands = false,
    required this.label,
    required this.subtitle,
    required this.decorText,
    required this.gradientColors,
    required this.shadowColor,
    required this.route,
  });
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(item.route),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: item.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: item.shadowColor.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Texte arabe décoratif en fond
            Positioned(
              bottom: -8,
              left: -4,
              child: Text(
                item.decorText,
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.07),
                  height: 1,
                ),
              ),
            ),
            // Contenu
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Icône
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.35), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: item.twoHands
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..scale(-1.0, 1.0),
                                child: const Icon(Icons.front_hand_rounded,
                                    size: 28, color: Colors.white),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.front_hand_rounded,
                                  size: 28, color: Colors.white),
                            ],
                          )
                        : Icon(item.icon, size: 42, color: Colors.white),
                  ),
                  const Spacer(),
                  // Titre
                  Text(
                    item.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 3),
                  // Sous-titre
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 12,
                      fontFamily: 'Amiri',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
