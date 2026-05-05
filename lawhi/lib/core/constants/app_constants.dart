class AppConstants {
  static const String appName = 'لوحي';
  static const String appNameLatin = 'Lawhi';
  static const int totalSurahs = 114;
  static const int totalVerses = 6236;

  static const String supabaseUrl = 'https://wbuqjgrgqxktcpfoiure.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_myWZf6USQaY5DnB7ciOy8g_RrSXxjro';

  // Islamic Network CDN — per-verse, URL: $audioBaseUrl/$edition/$globalAyah.mp3
  static const String audioBaseUrl = 'https://cdn.islamic.network/quran/audio/128';

  // Only confirmed-working editions on this CDN
  static const Map<String, String> reciters = {
    'ar.alafasy':            'مشاري العفاسي',
    'ar.mahermuaiqly':       'ماهر المعيقلي',
    'ar.abdurrahmaansudais': 'عبدالرحمن السديس',
    'ar.saoodshuraym':       'سعود الشريم',
    'ar.husary':             'محمود خليل الحصري',
    'ar.husarymujawwad':     'الحصري — مجوّد',
    'ar.minshawi':           'محمد صديق المنشاوي',
    'ar.minshawimujawwad':   'المنشاوي — مجوّد',
    'ar.muhammadayyoub':     'محمد أيوب',
    'ar.abdullahbasfar':     'عبدالله بصفر',
    'ar.shaatree':           'أبو بكر الشاطري',
    'ar.ibrahimakhdar':      'إبراهيم الأخضر',
    'ar.hanirifai':          'هاني الرفاعي',
    'ar.aymanswoaid':        'أيمن سويد',
    'ar.walk':               'عبد الباسط عبد الصمد',
    'ar.ahmedajamy':         'أحمد العجمي',
  };

  static const Map<String, String> recitersFr = {
    'ar.alafasy':            'Mishary Rachid Al-Afasy',
    'ar.mahermuaiqly':       'Maher Al-Muaiqly',
    'ar.abdurrahmaansudais': 'Abdurrahman Al-Soudais',
    'ar.saoodshuraym':       'Saoud Al-Churaim',
    'ar.husary':             'Mahmoud Khalil Al-Housary',
    'ar.husarymujawwad':     'Al-Housary — Moujawwad',
    'ar.minshawi':           'Mohamed Seddiq Al-Minchawi',
    'ar.minshawimujawwad':   'Al-Minchawi — Moujawwad',
    'ar.muhammadayyoub':     'Muhammad Ayyoub',
    'ar.abdullahbasfar':     'Abdullah Basfar',
    'ar.shaatree':           'Abou Bakr Al-Chatri',
    'ar.ibrahimakhdar':      'Ibrahim Al-Akhdar',
    'ar.hanirifai':          'Hani Ar-Rifai',
    'ar.aymanswoaid':        'Ayman Al-Souyid',
    'ar.walk':               'Abdul Basit Abdul Samad',
    'ar.ahmedajamy':         'Ahmad Al-Ajami',
  };
}
