import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lawhi/core/theme/app_theme.dart';

// ─────────────────────────── Model ───────────────────────────

class Dhikr {
  final String text;
  final int repeat;
  final String source;
  final String? virtue;

  const Dhikr({
    required this.text,
    required this.repeat,
    required this.source,
    this.virtue,
  });
}

// ─────────────────────────── Data ────────────────────────────

const _sabah = [
  Dhikr(
    text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.\nرَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ.',
    repeat: 1,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ.',
    repeat: 1,
    source: 'سنن الترمذي',
  ),
  Dhikr(
    text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي، فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ.',
    repeat: 1,
    source: 'صحيح البخاري',
    virtue: 'سيد الاستغفار — من قاله موقناً فمات من يومه دخل الجنة',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ.',
    repeat: 4,
    source: 'سنن أبي داود',
    virtue: 'أعتقه الله من النار',
  ),
  Dhikr(
    text: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ.',
    repeat: 3,
    source: 'سنن أبي داود',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ.',
    repeat: 3,
    source: 'سنن أبي داود',
  ),
  Dhikr(
    text: 'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا.',
    repeat: 3,
    source: 'سنن أبي داود',
    virtue: 'حق على الله أن يرضيه يوم القيامة',
  ),
  Dhikr(
    text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
    repeat: 3,
    source: 'سنن أبي داود',
    virtue: 'لن يضره شيء',
  ),
  Dhikr(
    text: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ، عَلَيْهِ تَوَكَّلْتُ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.',
    repeat: 7,
    source: 'سنن أبي داود',
    virtue: 'كفاه الله ما أهمه',
  ),
  Dhikr(
    text: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ.',
    repeat: 1,
    source: 'السلسلة الصحيحة',
  ),
  Dhikr(
    text: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ.',
    repeat: 3,
    source: 'صحيح مسلم',
    virtue: 'لم يضره سم ولا حيوان',
  ),
  Dhikr(
    text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ.',
    repeat: 10,
    source: 'صحيح الترغيب',
    virtue: 'كُفي هموم الدنيا والآخرة',
  ),
  Dhikr(
    text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
    repeat: 10,
    source: 'صحيح البخاري',
    virtue: 'كُتبت له عشر حسنات وعُدلت عشر سيئات',
  ),
  Dhikr(
    text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
    repeat: 100,
    source: 'صحيح البخاري',
    virtue: 'حُطت خطاياه وإن كانت مثل زبد البحر',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي.',
    repeat: 1,
    source: 'سنن ابن ماجه',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'آيَةُ الْكُرْسِيِّ:\nاللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
    repeat: 1,
    source: 'البقرة: 255',
    virtue: 'من قرأها صباحاً كان في ذمة الله حتى المساء',
  ),
  Dhikr(
    text: 'قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ\n(سورة الإخلاص)',
    repeat: 3,
    source: 'سنن النسائي',
    virtue: 'كافية من كل شيء',
  ),
  Dhikr(
    text: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ\n(سورة الفلق)',
    repeat: 3,
    source: 'سنن النسائي',
  ),
  Dhikr(
    text: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلَٰهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ\n(سورة الناس)',
    repeat: 3,
    source: 'سنن النسائي',
  ),
];

const _masaa = [
  Dhikr(
    text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.\nرَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا.',
    repeat: 1,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ.',
    repeat: 1,
    source: 'سنن الترمذي',
  ),
  Dhikr(
    text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي، فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ.',
    repeat: 1,
    source: 'صحيح البخاري',
    virtue: 'سيد الاستغفار — من قاله موقناً فمات من ليلته دخل الجنة',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ.',
    repeat: 4,
    source: 'سنن أبي داود',
    virtue: 'أعتقه الله من النار',
  ),
  Dhikr(
    text: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ.',
    repeat: 3,
    source: 'سنن أبي داود',
  ),
  Dhikr(
    text: 'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا.',
    repeat: 3,
    source: 'سنن أبي داود',
    virtue: 'حق على الله أن يرضيه يوم القيامة',
  ),
  Dhikr(
    text: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
    repeat: 3,
    source: 'سنن أبي داود',
    virtue: 'لن يضره شيء',
  ),
  Dhikr(
    text: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ.',
    repeat: 3,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ، عَلَيْهِ تَوَكَّلْتُ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.',
    repeat: 7,
    source: 'سنن أبي داود',
    virtue: 'كفاه الله ما أهمه',
  ),
  Dhikr(
    text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ.',
    repeat: 10,
    source: 'صحيح الترغيب',
  ),
  Dhikr(
    text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
    repeat: 10,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
    repeat: 100,
    source: 'صحيح البخاري',
    virtue: 'حُطت خطاياه وإن كانت مثل زبد البحر',
  ),
  Dhikr(
    text: 'آيَةُ الْكُرْسِيِّ:\nاللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ...',
    repeat: 1,
    source: 'البقرة: 255',
    virtue: 'من قرأها مساءً كان في ذمة الله حتى الصباح',
  ),
  Dhikr(
    text: 'قُلْ هُوَ اللَّهُ أَحَدٌ — وَالْمُعَوِّذَتَيْنِ\n(الإخلاص والفلق والناس)',
    repeat: 3,
    source: 'سنن النسائي',
    virtue: 'كافية من كل شيء',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ.',
    repeat: 1,
    source: 'سنن ابن ماجه',
  ),
  Dhikr(
    text: 'اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ، فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ.',
    repeat: 1,
    source: 'سنن أبي داود',
    virtue: 'أدّى شكر ليلته',
  ),
];

const _nawm = [
  Dhikr(
    text: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ.',
    repeat: 3,
    source: 'سنن أبي داود',
  ),
  Dhikr(
    text: 'آيَةُ الْكُرْسِيِّ:\nاللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
    repeat: 1,
    source: 'صحيح البخاري',
    virtue: 'لا يزال عليك من الله حافظ ولا يقربك شيطان حتى تصبح',
  ),
  Dhikr(
    text: 'قُلْ هُوَ اللَّهُ أَحَدٌ — الفَلَق — النَّاس\nتُقرأ ثلاثاً وينفث في الكفين ويمسح بهما الجسد.',
    repeat: 3,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'سُبْحَانَ اللَّهِ، الْحَمْدُ لِلَّهِ، اللَّهُ أَكْبَرُ.',
    repeat: 33,
    source: 'صحيح البخاري',
    virtue: 'خير لك مما سألت — أمر به النبي ﷺ فاطمة عند النوم',
  ),
  Dhikr(
    text: 'الآيتان الأخيرتان من سورة البقرة:\nآمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ... لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا.',
    repeat: 1,
    source: 'صحيح البخاري',
    virtue: 'كفتاه',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنَّكَ خَلَقْتَ نَفْسِي وَأَنْتَ تَتَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْيَاهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ.',
    repeat: 1,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'اللَّهُمَّ رَبَّ السَّمَاوَاتِ وَرَبَّ الْأَرْضِ وَرَبَّ الْعَرْشِ الْعَظِيمِ، رَبَّنَا وَرَبَّ كُلِّ شَيْءٍ، فَالِقَ الْحَبِّ وَالنَّوَى، وَمُنَزِّلَ التَّوْرَاةِ وَالْإِنْجِيلِ وَالْقُرْآنِ، أَعُوذُ بِكَ مِنْ شَرِّ كُلِّ شَيْءٍ أَنْتَ آخِذٌ بِنَاصِيَتِهِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ\n(سورة الفلق كاملة)',
    repeat: 1,
    source: 'القرآن الكريم',
  ),
  Dhikr(
    text: 'باسمك ربي وضعت جنبي، وبك أرفعه، فإن أمسكت نفسي فارحمها، وإن أرسلتها فاحفظها بما تحفظ به عبادك الصالحين.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
];

const _baadSalah = [
  Dhikr(
    text: 'أَسْتَغْفِرُ اللَّهَ.',
    repeat: 3,
    source: 'صحيح مسلم',
    virtue: 'من أسباب المغفرة',
  ),
  Dhikr(
    text: 'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ ذَا الْجَلَالِ وَالْإِكْرَامِ.',
    repeat: 1,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لَا مَانِعَ لِمَا أَعْطَيْتَ، وَلَا مُعْطِيَ لِمَا مَنَعْتَ، وَلَا يَنْفَعُ ذَا الْجَدِّ مِنْكَ الْجَدُّ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
    repeat: 10,
    source: 'سنن النسائي',
    virtue: 'كُتبت له عشر حسنات ومُحيت عنه عشر سيئات',
  ),
  Dhikr(
    text: 'سُبْحَانَ اللَّهِ.',
    repeat: 33,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'الْحَمْدُ لِلَّهِ.',
    repeat: 33,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'اللَّهُ أَكْبَرُ.',
    repeat: 33,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.',
    repeat: 1,
    source: 'صحيح مسلم',
    virtue: 'تكملة المئة — غُفرت خطاياه وإن كانت مثل زبد البحر',
  ),
  Dhikr(
    text: 'آيَةُ الْكُرْسِيِّ بعد كل صلاة:\nاللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ...',
    repeat: 1,
    source: 'السلسلة الصحيحة',
    virtue: 'لم يمنعه من دخول الجنة إلا الموت',
  ),
  Dhikr(
    text: 'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ.',
    repeat: 1,
    source: 'سنن أبي داود',
    virtue: 'أوصى به النبي ﷺ معاذاً أن يقوله دبر كل صلاة',
  ),
  Dhikr(
    text: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْجُبْنِ، وَأَعُوذُ بِكَ مِنَ الْبُخْلِ، وَأَعُوذُ بِكَ مِنْ أَرْذَلِ الْعُمُرِ، وَأَعُوذُ بِكَ مِنْ فِتْنَةِ الدُّنْيَا وَعَذَابِ الْقَبْرِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'سورة الإخلاص والمعوذتان (بعد الفجر والمغرب):\nقُلْ هُوَ اللَّهُ أَحَدٌ — الفَلَق — النَّاس.',
    repeat: 3,
    source: 'سنن النسائي',
    virtue: 'كافية من كل شيء',
  ),
];

const _salah = [
  Dhikr(
    text: 'دُعَاء الاسْتِفْتَاح:\nاللَّهُمَّ بَاعِدْ بَيْنِي وَبَيْنَ خَطَايَايَ كَمَا بَاعَدْتَ بَيْنَ الْمَشْرِقِ وَالْمَغْرِبِ، اللَّهُمَّ نَقِّنِي مِنَ الْخَطَايَا كَمَا يُنَقَّى الثَّوْبُ الْأَبْيَضُ مِنَ الدَّنَسِ، اللَّهُمَّ اغْسِلْ خَطَايَايَ بِالْمَاءِ وَالثَّلْجِ وَالْبَرَدِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'ذِكر الرُّكوع:\nسُبْحَانَ رَبِّيَ الْعَظِيمِ.',
    repeat: 3,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'عِنْد الرَّفع من الرُّكوع:\nسَمِعَ اللَّهُ لِمَنْ حَمِدَهُ، رَبَّنَا وَلَكَ الْحَمْدُ، حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'ذِكر السُّجود:\nسُبْحَانَ رَبِّيَ الْأَعْلَى.',
    repeat: 3,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'دُعَاء بَيْن السَّجدتين:\nرَبِّ اغْفِرْ لِي، رَبِّ اغْفِرْ لِي.',
    repeat: 1,
    source: 'سنن أبي داود',
  ),
  Dhikr(
    text: 'دُعَاء السُّجود:\nاللَّهُمَّ اغْفِرْ لِي ذَنْبِي كُلَّهُ دِقَّهُ وَجِلَّهُ وَأَوَّلَهُ وَآخِرَهُ وَعَلَانِيَتَهُ وَسِرَّهُ.',
    repeat: 1,
    source: 'صحيح مسلم',
  ),
  Dhikr(
    text: 'التَّشهد:\nالتَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'الصَّلاة الإبراهيمية:\nاللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ، اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
  Dhikr(
    text: 'دُعَاء قبل التَّسليم:\nاللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ وَمِنْ عَذَابِ النَّارِ وَمِنْ فِتْنَةِ الْمَحْيَا وَالْمَمَاتِ وَمِنْ فِتْنَةِ الْمَسِيحِ الدَّجَّالِ.',
    repeat: 1,
    source: 'صحيح البخاري',
  ),
];

final Map<String, List<Dhikr>> _data = {
  'أذكار الصباح': _sabah,
  'أذكار المساء': _masaa,
  'أذكار النوم': _nawm,
  'أذكار الصلاة': _salah,
  'أذكار بعد الصلاة': _baadSalah,
};

// ─────────────────────────── Screens ─────────────────────────────

class AdhkarScreen extends StatelessWidget {
  const AdhkarScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'title': 'أذكار الصباح',    'icon': Icons.wb_sunny_rounded,          'color': Color(0xFFE65100)},
    {'title': 'أذكار المساء',    'icon': Icons.nights_stay_rounded,        'color': Color(0xFF0D47A1)},
    {'title': 'أذكار النوم',     'icon': Icons.bedtime_rounded,            'color': Color(0xFF4A148C)},
    {'title': 'أذكار الصلاة',   'icon': Icons.mosque_rounded,             'color': Color(0xFF1B5E20)},
    {'title': 'أذكار بعد الصلاة','icon': Icons.brightness_5_rounded,      'color': Color(0xFF1A237E)},
    {'title': 'التسبيح',         'icon': Icons.radio_button_checked_rounded,'color': Color(0xFF004D40)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار', style: TextStyle(fontFamily: 'Amiri', fontSize: 22)),
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
            final title = cat['title'] as String;
            final count = _data[title]?.length ?? 0;
            return _CategoryCard(
              title: title,
              icon: cat['icon'] as IconData,
              color: cat['color'] as Color,
              count: count,
              onTap: () {
                if (title == 'التسبيح') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const TasbihScreen()));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdhkarDetailScreen(
                        title: title,
                        color: cat['color'] as Color,
                        adhkar: _data[title] ?? [],
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────── Category card ───────────────────────

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.85), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.45),
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
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1),
              ),
              child: Icon(icon, size: 34, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Amiri',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            if (count > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('$count ذكر',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12)),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────── Detail screen ───────────────────────

class AdhkarDetailScreen extends StatefulWidget {
  final String title;
  final Color color;
  final List<Dhikr> adhkar;

  const AdhkarDetailScreen({
    super.key,
    required this.title,
    required this.color,
    required this.adhkar,
  });

  @override
  State<AdhkarDetailScreen> createState() => _AdhkarDetailScreenState();
}

class _AdhkarDetailScreenState extends State<AdhkarDetailScreen> {
  late final List<int> _counts;

  @override
  void initState() {
    super.initState();
    _counts = List.filled(widget.adhkar.length, 0);
  }

  void _increment(int i) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_counts[i] < widget.adhkar[i].repeat) _counts[i]++;
    });
  }

  void _resetAll() {
    setState(() {
      for (int i = 0; i < _counts.length; i++) _counts[i] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int completed = 0;
    for (int i = 0; i < _counts.length; i++) {
      if (_counts[i] >= widget.adhkar[i].repeat) completed++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontFamily: 'Amiri', fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'إعادة تعيين',
            onPressed: _resetAll,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppTheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$completed / ${widget.adhkar.length} مكتمل',
                    style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 13,
                        color: AppTheme.textSecondary)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: widget.adhkar.isEmpty
                        ? 0
                        : completed / widget.adhkar.length,
                    minHeight: 6,
                    backgroundColor: AppTheme.surfaceCard,
                    valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.adhkar.length,
              itemBuilder: (context, i) {
                final dhikr = widget.adhkar[i];
                final count = _counts[i];
                final isDone = count >= dhikr.repeat;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isDone
                        ? widget.color.withOpacity(0.12)
                        : AppTheme.surfaceCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDone
                          ? widget.color.withOpacity(0.5)
                          : Colors.white.withOpacity(0.06),
                      width: isDone ? 1.5 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Index + done badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (isDone)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: widget.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check_circle_rounded,
                                        color: widget.color, size: 14),
                                    const SizedBox(width: 4),
                                    Text('مكتمل',
                                        style: TextStyle(
                                            color: widget.color,
                                            fontSize: 12,
                                            fontFamily: 'Amiri')),
                                  ],
                                ),
                              )
                            else
                              const SizedBox(),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: widget.color.withOpacity(0.6),
                                    width: 1.5),
                              ),
                              child: Center(
                                child: Text('${i + 1}',
                                    style: TextStyle(
                                        color: widget.color,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Dhikr text
                        Text(
                          dhikr.text,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 20,
                            height: 2.0,
                            color: isDone
                                ? AppTheme.textPrimary.withOpacity(0.6)
                                : AppTheme.textPrimary,
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 10),
                        // Source + virtue
                        if (dhikr.virtue != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '✦ ${dhikr.virtue}',
                              style: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 13,
                                  color: widget.color.withOpacity(0.85),
                                  fontStyle: FontStyle.italic),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Counter button
                            if (!isDone)
                              GestureDetector(
                                onTap: () => _increment(i),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: widget.color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '$count / ${dhikr.repeat}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(Icons.add_circle_outline,
                                          color: Colors.white, size: 18),
                                    ],
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                            // Source
                            Text(
                              dhikr.source,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textSecondary,
                                  fontFamily: 'Amiri'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Tasbih ──────────────────────────────

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _target = 33;
  int _selectedDhikr = 0;

  static const List<Map<String, dynamic>> _dhikrList = [
    {'text': 'سُبْحَانَ اللَّهِ',          'target': 33},
    {'text': 'الْحَمْدُ لِلَّهِ',           'target': 33},
    {'text': 'اللَّهُ أَكْبَرُ',            'target': 34},
    {'text': 'لَا إِلَهَ إِلَّا اللَّهُ',  'target': 100},
    {'text': 'أَسْتَغْفِرُ اللَّهَ',       'target': 100},
    {'text': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', 'target': 100},
    {'text': 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ', 'target': 100},
  ];

  @override
  Widget build(BuildContext context) {
    final progress = _target > 0 ? (_count % _target) / _target : 0.0;
    final laps = _count ~/ _target;

    return Scaffold(
      appBar: AppBar(
          title: const Text('التسبيح',
              style: TextStyle(fontFamily: 'Amiri', fontSize: 22))),
      body: Column(
        children: [
          // Dhikr selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: List.generate(_dhikrList.length, (i) {
                final selected = i == _selectedDhikr;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedDhikr = i;
                    _count = 0;
                    _target = _dhikrList[i]['target'] as int;
                  }),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.primary : AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: selected
                              ? AppTheme.gold
                              : Colors.white.withOpacity(0.1)),
                    ),
                    child: Text(_dhikrList[i]['text'] as String,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 15,
                            color: selected ? Colors.white : AppTheme.textSecondary)),
                  ),
                );
              }),
            ),
          ),
          // Counter
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() => _count++);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 14,
                      backgroundColor: AppTheme.surface,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.gold),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$_count',
                          style: const TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gold)),
                      Text(_dhikrList[_selectedDhikr]['text'] as String,
                          style: const TextStyle(
                              fontFamily: 'Amiri', fontSize: 18),
                          textDirection: TextDirection.rtl),
                      const SizedBox(height: 4),
                      Text('الهدف: $_target  •  جولات: $laps',
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => setState(() => _count = 0),
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة'),
                ),
                const Text('اضغط للتسبيح',
                    style: TextStyle(
                        color: AppTheme.textSecondary, fontFamily: 'Amiri')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
