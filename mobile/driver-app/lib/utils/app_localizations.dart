class Language {
  final String code;
  final String name;
  const Language(this.code, this.name);
}

class AppLocalizations {
  static const List<Language> supportedLanguages = [
    Language('en', 'English'),
    Language('si', 'සිංහල'),
    Language('ta', 'தமிழ்'),
  ];

  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'copyright': '© 2025 BusTrackLK App. All Rights Reserved.',
      'about_us': 'About Us',
      'about_description':
          'Tired of the endless waiting and uncertainty of bus travel? We are too.\n\nAs daily commuters and software engineering students, we\'re building Lanka Ride Connect—the app we\'ve always wanted. Our mission is to put real-time information in your hands, from live bus tracking and schedules to easy seat booking, making travel in Sri Lanka simple and predictable for our entire community.',
      'version': 'Version',
      'developed_by': 'Developed by',
      'released_date': 'Released Date',
    },
    'si': {
      'copyright': '© 2025 බස්ට්‍රැක්LK යෙදුම. සියලුම හිමිකම් ඇවිරිණි.',
      'about_us': 'අප ගැන',
      'about_description':
          'බස් ගමනේ නිමක් නැති බලා සිටීම සහ අවිනිශ්චිතතාවය ගැන වෙහෙසට පත්ව සිටිනවාද? අපිත් එහෙමයි.\n\nදෛනික මගීන් සහ මෘදුකාංග ඉංජිනේරු සිසුන් ලෙස, අපි ලංකා රයිඩ් කනෙක්ට් ගොඩනඟමු - අප සැමවිටම අපේක්ෂා කළ යෙදුම. අපගේ මෙහෙවර වන්නේ තත්‍ය කාලීන බස් ලුහුබැඳීමේ සිට පහසු ආසන වෙන්කරවා ගැනීම දක්වා තත්‍ය කාලීන තොරතුරු ඔබේ අතට පත් කර, ශ්‍රී ලංකාවේ සංචාරය අපගේ සමස්ත ප්‍රජාවටම සරල සහ අනාවැකි කිව හැකි බවට පත් කිරීමයි.',
      'version': 'අනුවාදය',
      'developed_by': 'සංවර්ධනය කළේ',
      'released_date': 'නිකුත් කළ දිනය',
    },
    'ta': {
      'copyright':
          '© 2025 பஸ்ட்ராக்LK பயன்பாடு. அனைத்து உரிமைகளும் பாதுகாக்கப்பட்டவை.',
      'about_us': 'எங்களைப் பற்றி',
      'about_description':
          'பேருந்து பயணத்தின் முடிவில்லாத காத்திருப்பு மற்றும் நிச்சயமற்ற தன்மையால் சோர்வாக இருக்கிறீர்களா? நாமும் அப்படித்தான்.\n\nதினசரி பயணிகள் மற்றும் மென்பொருள் பொறியியல் மாணவர்களாக, நாங்கள் லங்கா ரைடு கனெக்ட் செயலியை உருவாக்குகிறோம். நிகழ்நேர பேருந்து கண்காணிப்பு மற்றும் அட்டவணைகள் முதல் எளிதான இருக்கை முன்பதிவு வரை நிகழ்நேர தகவல்களை உங்கள் கைகளில் வைப்பதே எங்கள் நோக்கம், இலங்கைப் பயணத்தை எங்கள் முழு சமூகத்திற்கும் எளிமையாகவும் கணிக்கக்கூடியதாகவும் மாற்றுவதாகும்.',
      'version': 'பதிப்பு',
      'developed_by': 'உருவாக்கியவர்',
      'released_date': 'வெளியிடப்பட்ட தேதி',
    },
  };

  static String get(String key, String langCode) {
    return _translations[langCode]?[key] ?? _translations['en']?[key] ?? key;
  }
}
