class AppConstants {
  static const String appName = 'لوحي';
  static const String appNameLatin = 'Lawhi';
  static const int totalSurahs = 114;
  static const int totalVerses = 6236;

  static const String supabaseUrl = 'https://wbuqjgrgqxktcpfoiure.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_myWZf6USQaY5DnB7ciOy8g_RrSXxjro';

  // EveryAyah CDN — per-verse audio, URL format: $audioBaseUrl/$reciterFolder/$SSSVVV.mp3
  static const String audioBaseUrl = 'https://everyayah.com/data';

  // Keys = EveryAyah folder name, Values = Arabic name
  static const Map<String, String> reciters = {
    'Alafasy_128kbps':                  'مشاري العفاسي',
    'Maher_Al_Muaiqly_128kbps':         'ماهر المعيقلي',
    'Abdurrahmaan_As-Sudais_192kbps':   'عبدالرحمن السديس',
    'Saood_ash-Shuraym_128kbps':        'سعود الشريم',
    'Yasser_Ad-Dossari_128kbps':        'ياسر الدوسري',
    'Husary_128kbps':                   'محمود خليل الحصري',
    'Menshawi_128kbps':                 'محمد صديق المنشاوي',
    'Muhammad_Ayyoob_128kbps':          'محمد أيوب',
    'Abu_Bakr_Ash-Shaatree_128kbps':    'أبو بكر الشاطري',
    'Abdullah_Basfar_192kbps':          'عبدالله بصفر',
    'Ahmed_ibn_Ali_al-Ajamy_128kbps':   'أحمد العجمي',
    'Hani_Rifai_192kbps':              'هاني الرفاعي',
    'Ibrahim_Al-Akhdar_128kbps':        'إبراهيم الأخضر',
    'Muhammad_Jibreel_128kbps':         'محمد جبريل',
    'Nasser_Alqatami_128kbps':          'ناصر القطامي',
    'Abdul_Basit_Murattal_64kbps':      'عبد الباسط — مرتل',
    'Abdul_Basit_Mujawwad_128kbps':     'عبد الباسط — مجوّد',
    'Ayman_Sowaid_64kbps':              'أيمن سويد',
  };

  static const Map<String, String> recitersFr = {
    'Alafasy_128kbps':                  'Mishary Rachid Al-Afasy',
    'Maher_Al_Muaiqly_128kbps':         'Maher Al-Muaiqly',
    'Abdurrahmaan_As-Sudais_192kbps':   'Abdurrahman Al-Soudais',
    'Saood_ash-Shuraym_128kbps':        'Saoud Al-Churaim',
    'Yasser_Ad-Dossari_128kbps':        'Yasser Al-Dossari',
    'Husary_128kbps':                   'Mahmoud Khalil Al-Housary',
    'Menshawi_128kbps':                 'Mohamed Seddiq Al-Minchawi',
    'Muhammad_Ayyoob_128kbps':          'Muhammad Ayyoub',
    'Abu_Bakr_Ash-Shaatree_128kbps':    'Abou Bakr Al-Chatri',
    'Abdullah_Basfar_192kbps':          'Abdullah Basfar',
    'Ahmed_ibn_Ali_al-Ajamy_128kbps':   'Ahmad Al-Ajami',
    'Hani_Rifai_192kbps':              'Hani Ar-Rifai',
    'Ibrahim_Al-Akhdar_128kbps':        'Ibrahim Al-Akhdar',
    'Muhammad_Jibreel_128kbps':         'Muhammad Jibreel',
    'Nasser_Alqatami_128kbps':          'Nasser Al-Qatami',
    'Abdul_Basit_Murattal_64kbps':      'Abdul Basit — Murattal',
    'Abdul_Basit_Mujawwad_128kbps':     'Abdul Basit — Moujawwad',
    'Ayman_Sowaid_64kbps':              'Ayman Al-Souyid',
  };
}
