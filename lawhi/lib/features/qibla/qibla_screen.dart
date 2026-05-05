import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:lawhi/core/theme/app_theme.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  bool _loading = true;
  bool _locationAllowed = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final permission = await Geolocator.requestPermission();
    setState(() {
      _locationAllowed = permission == LocationPermission.always || permission == LocationPermission.whileInUse;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اتجاه القبلة', style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : !_locationAllowed
              ? _LocationDenied(onRetry: _checkPermission)
              : const _QiblaCompass(),
    );
  }
}

class _LocationDenied extends StatelessWidget {
  final VoidCallback onRetry;
  const _LocationDenied({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 80, color: AppTheme.textSecondary),
          const SizedBox(height: 16),
          const Text('يحتاج تطبيق لوحي إلى الوصول للموقع لتحديد اتجاه القبلة',
              style: TextStyle(fontFamily: 'Amiri', fontSize: 18), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onRetry, child: const Text('السماح بالوصول')),
        ],
      ),
    );
  }
}

class _QiblaCompass extends StatelessWidget {
  const _QiblaCompass();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final qiblah = snapshot.data!;
        final direction = (qiblah.qiblah * (math.pi / 180) * -1);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${qiblah.direction.toStringAsFixed(1)}°',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.gold),
            ),
            const SizedBox(height: 8),
            const Text('اتجاه القبلة', style: TextStyle(fontFamily: 'Amiri', fontSize: 20)),
            const SizedBox(height: 48),
            SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.gold, width: 3),
                      color: AppTheme.surface,
                    ),
                  ),
                  const Text('N', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Transform.rotate(
                    angle: direction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.navigation, size: 80, color: AppTheme.gold),
                        const SizedBox(height: 4),
                        Container(width: 2, height: 60, color: AppTheme.gold.withValues(alpha:0.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '﴿ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ﴾',
              style: TextStyle(fontFamily: 'Amiri', fontSize: 18, color: AppTheme.gold),
              textDirection: TextDirection.rtl,
            ),
          ],
        );
      },
    );
  }
}
