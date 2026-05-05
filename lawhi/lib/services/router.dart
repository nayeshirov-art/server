import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lawhi/core/constants/routes.dart';
import 'package:lawhi/features/home/home_screen.dart';
import 'package:lawhi/features/quran/presentation/quran_index_screen.dart';
import 'package:lawhi/features/quran/presentation/surah_screen.dart';
import 'package:lawhi/features/adhkar/presentation/adhkar_screen.dart';
import 'package:lawhi/features/qibla/qibla_screen.dart';
import 'package:lawhi/features/adiya/presentation/adiya_screen.dart';
import 'package:lawhi/features/amal/presentation/amal_ummah_screen.dart';
import 'package:lawhi/features/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: Routes.quranIndex,
          builder: (context, state) => const QuranIndexScreen(),
          routes: [
            GoRoute(
              path: ':surahId',
              builder: (context, state) {
                final surahId = int.parse(state.pathParameters['surahId']!);
                return SurahScreen(surahId: surahId);
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.adhkar,
          builder: (context, state) => const AdhkarScreen(),
        ),
        GoRoute(
          path: Routes.adiya,
          builder: (context, state) => const AdiyaScreen(),
        ),
        GoRoute(
          path: Routes.amalUmmah,
          builder: (context, state) => const AmalUmmahScreen(),
        ),
        GoRoute(
          path: Routes.qibla,
          builder: (context, state) => const QiblaScreen(),
        ),
        GoRoute(
          path: Routes.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) => _navigate(context, i),
        elevation: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories_rounded), label: 'القرآن'),
          NavigationDestination(icon: Icon(Icons.self_improvement_outlined), selectedIcon: Icon(Icons.self_improvement_rounded), label: 'الأذكار'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'القبلة'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings_rounded), label: 'الإعدادات'),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith('/quran')) return 1;
    if (location.startsWith('/adhkar')) return 2;
    if (location.startsWith('/qibla')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;
  }

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(Routes.home);
      case 1: context.go(Routes.quranIndex);
      case 2: context.go(Routes.adhkar);
      case 3: context.go(Routes.qibla);
      case 4: context.go(Routes.settings);
    }
  }
}
