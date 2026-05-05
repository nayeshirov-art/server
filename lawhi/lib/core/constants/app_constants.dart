enum ReciterCdn { islamicNetwork, everyAyah }

class ReciterInfo {
  final String arabic;
  final String french;
  final String cdnKey;
  final ReciterCdn cdn;

  const ReciterInfo({
    required this.arabic,
    required this.french,
    required this.cdnKey,
    this.cdn = ReciterCdn.islamicNetwork,
  });

  String url(int globalAyah, int surah, int verse) {
    if (cdn == ReciterCdn.everyAyah) {
      final s = surah.toString().padLeft(3, '0');
      final v = verse.toString().padLeft(3, '0');
      return 'https://everyayah.com/data/$cdnKey/$s$v.mp3';
    }
    return 'https://cdn.islamic.network/quran/audio/128/$cdnKey/$globalAyah.mp3';
  }
}

class AppConstants {
  static const String appName = 'لوحي';
  static const String appNameLatin = 'Lawhi';
  static const int totalSurahs = 114;
  static const int totalVerses = 6236;

  static const String supabaseUrl = 'https://wbuqjgrgqxktcpfoiure.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_myWZf6USQaY5DnB7ciOy8g_RrSXxjro';

  static const Map<String, ReciterInfo> recitersMap = {
    // ── Islamic Network CDN (confirmed working) ──────────────────
    'ar.alafasy': ReciterInfo(
      arabic: 'مشاري العفاسي', french: 'Mishary Rachid Al-Afasy',
      cdnKey: 'ar.alafasy'),
    'ar.mahermuaiqly': ReciterInfo(
      arabic: 'ماهر المعيقلي', french: 'Maher Al-Muaiqly',
      cdnKey: 'ar.mahermuaiqly'),
    'ar.abdurrahmaansudais': ReciterInfo(
      arabic: 'عبدالرحمن السديس', french: 'Abdurrahman Al-Soudais',
      cdnKey: 'ar.abdurrahmaansudais'),
    'ar.saoodshuraym': ReciterInfo(
      arabic: 'سعود الشريم', french: 'Saoud Al-Churaim',
      cdnKey: 'ar.saoodshuraym'),
    'ar.husary': ReciterInfo(
      arabic: 'محمود خليل الحصري', french: 'Mahmoud Khalil Al-Housary',
      cdnKey: 'ar.husary'),
    'ar.husarymujawwad': ReciterInfo(
      arabic: 'الحصري — مجوّد', french: 'Al-Housary — Moujawwad',
      cdnKey: 'ar.husarymujawwad'),
    'ar.minshawi': ReciterInfo(
      arabic: 'محمد صديق المنشاوي', french: 'Mohamed Seddiq Al-Minchawi',
      cdnKey: 'ar.minshawi'),
    'ar.minshawimujawwad': ReciterInfo(
      arabic: 'المنشاوي — مجوّد', french: 'Al-Minchawi — Moujawwad',
      cdnKey: 'ar.minshawimujawwad'),
    'ar.muhammadayyoub': ReciterInfo(
      arabic: 'محمد أيوب', french: 'Muhammad Ayyoub',
      cdnKey: 'ar.muhammadayyoub'),
    'ar.abdullahbasfar': ReciterInfo(
      arabic: 'عبدالله بصفر', french: 'Abdullah Basfar',
      cdnKey: 'ar.abdullahbasfar'),
    'ar.shaatree': ReciterInfo(
      arabic: 'أبو بكر الشاطري', french: 'Abou Bakr Al-Chatri',
      cdnKey: 'ar.shaatree'),
    'ar.ibrahimakhdar': ReciterInfo(
      arabic: 'إبراهيم الأخضر', french: 'Ibrahim Al-Akhdar',
      cdnKey: 'ar.ibrahimakhdar'),
    'ar.hanirifai': ReciterInfo(
      arabic: 'هاني الرفاعي', french: 'Hani Ar-Rifai',
      cdnKey: 'ar.hanirifai'),
    'ar.aymanswoaid': ReciterInfo(
      arabic: 'أيمن سويد', french: 'Ayman Al-Souyid',
      cdnKey: 'ar.aymanswoaid'),
    'ar.walk': ReciterInfo(
      arabic: 'عبد الباسط عبد الصمد', french: 'Abdul Basit Abdul Samad',
      cdnKey: 'ar.walk'),
    'ar.ahmedajamy': ReciterInfo(
      arabic: 'أحمد العجمي', french: 'Ahmad Al-Ajami',
      cdnKey: 'ar.ahmedajamy'),

    // ── EveryAyah CDN (additional reciters) ─────────────────────
    'ea.nasser': ReciterInfo(
      arabic: 'ناصر القطامي', french: 'Nasser Al-Qatami',
      cdnKey: 'Nasser_Alqatami_128kbps',
      cdn: ReciterCdn.everyAyah),
    'ea.yasser': ReciterInfo(
      arabic: 'ياسر الدوسري', french: 'Yasser Al-Dossari',
      cdnKey: 'Yasser_Ad-Dossari_128kbps',
      cdn: ReciterCdn.everyAyah),
  };
}
