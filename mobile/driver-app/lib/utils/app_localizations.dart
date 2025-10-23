import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  // Helper method to get the localizations object
  static AppLocalizations of(BuildContext context) {
    // This 'watches' the provider. When the language changes,
    // any widget using 'AppLocalizations.of(context)' will rebuild.
    final language = context.watch<LanguageProvider>().currentLanguage;
    return AppLocalizations(language);
  }

  // This is your translation database
  static final Map<String, Map<String, String>> _localizedValues = {
    'English': {
      'appSubtitle': 'The All-in-One Bus Travel Companion',
      'register': 'Register',
      'login': 'Login',
      'username': 'Username',
      'password': 'Password',
      'phoneNo': 'Phone No',
      'nic': 'NIC',
      'busNo': 'Bus No',
      'routeNo': 'Route No',
      'forgotPassword': 'Forgot Password?',
      'registrationSuccess': 'Registration Success',
      'ok': 'OK',
      'startLocation': 'Start Location',
      'endLocation': 'End Location',
      'startJourney': 'Start Journey',
      'started': 'Started',
      'profile': 'Profile',
      'profileSubtitle': 'Your account details',
      'about': 'About',
      'aboutSubtitle': 'Learn more about us',
      'logout': 'Logout',
      'aboutUs': 'About Us',
      'aboutBody1':
      'Tired of the endless waiting and uncertainty of bus travel? We are too.',
      'aboutBody2':
      "As daily commuters and software engineering students, we're building Lanka Ride Connect—the app we've always wanted. Our mission is to put real-time information in your hands, from live bus tracking and schedules to easy seat booking, making travel in Sri Lanka simple and predictable for our entire community.",
      'version': 'Version',
      'developedBy': 'Developed by',
      'releasedDate': 'Released Date',
      'creditScore': 'Credit Score', // <-- 1. ADD THIS LINE (ENGLISH)
    },
    'Sinhala': {
      'appSubtitle': 'ඔබගේ සියලුම බස් ගමන් සහකරු',
      'register': 'ලියාපදිංචි වන්න',
      'login': 'පිවිසෙන්න',
      'username': 'පරිශීලක නාමය',
      'password': 'මුරපදය',
      'phoneNo': 'දුරකථන අංකය',
      'nic': 'හැඳුනුම්පත් අංකය',
      'busNo': 'බස් අංකය',
      'routeNo': 'මාර්ග අංකය',
      'forgotPassword': 'මුරපදය අමතකද?',
      'registrationSuccess': 'ලියාපදිංචිය සාර්ථකයි',
      'ok': 'හරි',
      'startLocation': 'ආරම්භක ස්ථානය',
      'endLocation': 'අවසාන ස්ථානය',
      'startJourney': 'ගමන අරඹන්න',
      'started': 'ආරම්භ විය',
      'profile': 'පැතිකඩ',
      'profileSubtitle': 'ඔබගේ ගිණුම් විස්තර',
      'about': 'පිළිබඳව',
      'aboutSubtitle': 'අප ගැන තව දැනගන්න',
      'logout': 'ඉවත් වන්න',
      'aboutUs': 'අප ගැන',
      'aboutBody1':
      'බස් ගමනේ නිමක් නැති පොරොත්තුවෙන් සහ අවිනිශ්චිතතාවයෙන් වෙහෙසට පත් වී සිටිනවාද? අපිත් එහෙමයි.',
      'aboutBody2':
      'දෛනික මගීන් සහ මෘදුකාංග ඉංජිනේරු සිසුන් ලෙස, අපි ලංකා රයිඩ් කනෙක්ට් ගොඩනඟමු - අපට සැමවිටම අවශ්‍ය වූ යෙදුම. අපගේ මෙහෙවර වන්නේ සජීවී බස් ලුහුබැඳීම සහ කාලසටහන් වල සිට පහසු ආසන වෙන්කරවා ගැනීම දක්වා තත්‍ය කාලීන තොරතුරු ඔබේ අතට පත් කිරීම, ශ්‍රී ලංකාවේ සංචාරය අපගේ මුළු ප්‍රජාවටම සරල සහ අනාවැකි කිව හැකි බවට පත් කිරීමයි.',
      'version': 'අනුවාදය',
      'developedBy': 'විසින් වැඩි දියුණු කරන ලදි',
      'releasedDate': 'නිකුත් කළ දිනය',
      'creditScore': 'ණය ලකුණු', // <-- 2. ADD THIS LINE (SINHALA)
    },
    'Tamil': {
      'appSubtitle': 'அனைத்து பஸ் பயண துணை',
      'register': 'பதிவு செய்',
      'login': 'உள்நுழை',
      'username': 'பயனர் பெயர்',
      'password': 'கடவுச்சொல்',
      'phoneNo': 'தொலைபேசி எண்',
      'nic': 'NIC',
      'busNo': 'பஸ் எண்',
      'routeNo': 'பாதை எண்',
      'forgotPassword': 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?',
      'registrationSuccess': 'பதிவு வெற்றி',
      'ok': 'சரி',
      'startLocation': 'தொடங்கும் இடம்',
      'endLocation': 'முடியும் இடம்',
      'startJourney': 'பயணத்தைத் தொடங்கு',
      'started': 'தொடங்கியது',
      'profile': 'சுயவிவரம்',
      'profileSubtitle': 'உங்கள் கணக்கு விவரங்கள்',
      'about': 'பற்றி',
      'aboutSubtitle': 'எங்களைப் பற்றி மேலும் அறிக',
      'logout': 'வெளியேறு',
      'aboutUs': 'எங்களை பற்றி',
      'aboutBody1':
      'பஸ் பயணத்தின் முடிவற்ற காத்திருப்பு மற்றும் நிச்சயமற்ற தன்மையால் சோர்வாக இருக்கிறீர்களா? நாங்களும் தான்.',
      'aboutBody2':
      'தினசரி பயணிகள் மற்றும் மென்பொருள் பொறியியல் மாணவர்கள் என்ற வகையில், நாங்கள் எப்போதும் விரும்பும் செயலியான லங்கா ரைடு கனெக்டை உருவாக்குகிறோம். லைவ் பஸ் டிராக்கிங் மற்றும் அட்டவணைகள் முதல் எளிதான இருக்கை முன்பதிவு வரை நிகழ்நேர தகவல்களை உங்கள் கைகளில் வைப்பதே எங்கள் நோக்கம், இலங்கையில் பயணத்தை எங்கள் முழு சமூகத்திற்கும் எளிமையாகவும் யூகிக்கக்கூடியதாகவும் ஆக்குகிறது.',
      'version': 'பதிப்பு',
      'developedBy': 'உருவாக்கியவர்',
      'releasedDate': 'வெளியிடப்பட்ட தேதி',
      'creditScore': 'கடன் மதிப்பெண்', // <-- 3. ADD THIS LINE (TAMIL)
    },
  };

  // --- Getters for each string ---
  // We use getters to safely access the map
  String get appSubtitle => _localizedValues[languageCode]!['appSubtitle']!;
  String get register => _localizedValues[languageCode]!['register']!;
  String get login => _localizedValues[languageCode]!['login']!;
  String get username => _localizedValues[languageCode]!['username']!;
  String get password => _localizedValues[languageCode]!['password']!;
  String get phoneNo => _localizedValues[languageCode]!['phoneNo']!;
  String get nic => _localizedValues[languageCode]!['nic']!;
  String get busNo => _localizedValues[languageCode]!['busNo']!;
  String get routeNo => _localizedValues[languageCode]!['routeNo']!;
  String get forgotPassword =>
      _localizedValues[languageCode]!['forgotPassword']!;
  String get registrationSuccess =>
      _localizedValues[languageCode]!['registrationSuccess']!;
  String get ok => _localizedValues[languageCode]!['ok']!;
  String get startLocation => _localizedValues[languageCode]!['startLocation']!;
  String get endLocation => _localizedValues[languageCode]!['endLocation']!;
  String get startJourney => _localizedValues[languageCode]!['startJourney']!;
  String get started => _localizedValues[languageCode]!['started']!;
  String get profile => _localizedValues[languageCode]!['profile']!;
  String get profileSubtitle =>
      _localizedValues[languageCode]!['profileSubtitle']!;
  String get about => _localizedValues[languageCode]!['about']!;
  String get aboutSubtitle => _localizedValues[languageCode]!['aboutSubtitle']!;
  String get logout => _localizedValues[languageCode]!['logout']!;
  String get aboutUs => _localizedValues[languageCode]!['aboutUs']!;
  String get aboutBody1 => _localizedValues[languageCode]!['aboutBody1']!;
  String get aboutBody2 => _localizedValues[languageCode]!['aboutBody2']!;
  String get version => _localizedValues[languageCode]!['version']!;
  String get developedBy => _localizedValues[languageCode]!['developedBy']!;
  String get releasedDate => _localizedValues[languageCode]!['releasedDate']!;
  String get creditScore => _localizedValues[languageCode]!['creditScore']!; // <-- 4. ADD THIS GETTER
}

