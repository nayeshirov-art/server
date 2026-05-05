class AppConstants {
  static const String appName = 'لوحي';
  static const String appNameLatin = 'Lawhi';
  static const int totalSurahs = 114;
  static const int totalVerses = 6236;

  // Supabase
  static const String supabaseUrl = 'https://wbuqjgrgqxktcpfoiure.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_myWZf6USQaY5DnB7ciOy8g_RrSXxjro';

  // Audio base URL (évolutif)
  static const String audioBaseUrl =
      'https://cdn.islamic.network/quran/audio/128';

  // Reciters — Arabic names
  static const Map<String, String> reciters = {
    'ar.alafasy':             'مشاري العفاسي',
    'ar.mahermuaiqly':        'ماهر المعيقلي',
    'ar.abdurrahmaansudais':  'عبدالرحمن السديس',
    'ar.saoodshuraym':        'سعود الشريم',
    'ar.husary':              'محمود خليل الحصري',
    'ar.minshawi':            'محمد صديق المنشاوي',
    'ar.muhammadayyoub':      'محمد أيوب',
    'ar.abdullahbasfar':      'عبدالله بصفر',
    'ar.shaatree':            'أبو بكر الشاطري',
    'ar.ibrahimakhdar':       'إبراهيم الأخضر',
    'ar.hanirifai':           'هاني الرفاعي',
    'ar.khalifatunaija':      'خليفة الطنيجي',
    'ar.aymanswoaid':         'أيمن سويد',
    'ar.abdulbasitmurattal':  'عبد الباسط - مرتل',
    'ar.abdulbaset':          'عبد الباسط - مجود',
    'ar.bandar':              'بندر بليلة',
    'ar.hamdanihijazy':       'أحمد الحواشي',
    'ar.muhammadjibreel':     'محمد جبريل',
    'ar.nasser_alqatami':     'ناصر القطامي',
    'ar.farsitabriz':         'سيد متولي عبد العال',
  };

  // Reciters — French names
  static const Map<String, String> recitersFr = {
    'ar.alafasy':             'Mishary Rachid Al-Afasy',
    'ar.mahermuaiqly':        'Maher Al-Muaiqly',
    'ar.abdurrahmaansudais':  'Abdurrahman Al-Soudais',
    'ar.saoodshuraym':        'Saoud Al-Churaim',
    'ar.husary':              'Mahmoud Khalil Al-Housary',
    'ar.minshawi':            'Mohamed Seddiq Al-Minchawi',
    'ar.muhammadayyoub':      'Muhammad Ayyoub',
    'ar.abdullahbasfar':      'Abdullah Basfar',
    'ar.shaatree':            'Abou Bakr Al-Chatri',
    'ar.ibrahimakhdar':       'Ibrahim Al-Akhdar',
    'ar.hanirifai':           'Hani Ar-Rifai',
    'ar.khalifatunaija':      'Khalifa Al-Tounaiji',
    'ar.aymanswoaid':         'Ayman Al-Souyid',
    'ar.abdulbasitmurattal':  'Abdul Basit — Murattal',
    'ar.abdulbaset':          'Abdul Basit — Moujawwad',
    'ar.bandar':              'Bandar Baleelah',
    'ar.hamdanihijazy':       'Ahmad Al-Hawachi',
    'ar.muhammadjibreel':     'Muhammad Jibreel',
    'ar.nasser_alqatami':     'Nasser Al-Qatami',
    'ar.farsitabriz':         'Sayyid Mutawalli Abd Al-Aal',
  };
}
