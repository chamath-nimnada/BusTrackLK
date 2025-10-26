import 'package:driver_ui/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This class holds all the translation strings for the app.
// It uses the LanguageProvider to determine which language to display.
class AppLocalizations {
  final String languageCode; // e.g., "English", "Sinhala", "Tamil"

  AppLocalizations(this.languageCode);

  // Helper method to easily get the AppLocalizations instance in widgets.
  // It watches the LanguageProvider, so widgets using this will rebuild
  // when the language changes.
  static AppLocalizations of(BuildContext context) {
    final language = context.watch<LanguageProvider>().currentLanguage;
    return AppLocalizations(language);
  }

  // The translation database.
  // Keys are language names (matching LanguageProvider values).
  // Values are maps where keys are translation IDs and values are the strings.
  static final Map<String, Map<String, String>> _localizedValues = {
    'English': {
      'appSubtitle': 'The All-in-One Bus Travel Companion',
      'register': 'Register',
      'login': 'Login',
      'username': 'User Name', // Still needed for register form
      'email': 'Email', // Added for login and register
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
      'creditScore': 'Credit Score',
      // --- Validation Messages (Example) ---
      'validationEnterUsername': 'Please enter a user name',
      'validationEnterEmail': 'Please enter an email',
      'validationValidEmail': 'Please enter a valid email',
      'validationEnterPhone': 'Please enter a phone number',
      'validationEnterNIC': 'Please enter an NIC',
      'validationEnterPassword': 'Please enter a password',
      'validationPasswordLength': 'Password must be at least 6 characters',
      'validationEnterBusNo': 'Please enter a bus number',
      'validationEnterRouteNo': 'Please enter a route number',
    },
    'Sinhala': {
      'appSubtitle': 'ඔබගේ සියලුම බස් ගමන් සහකරු',
      'register': 'ලියාපදිංචි වන්න',
      'login': 'පිවිසෙන්න',
      'username': 'පරිශීලක නාමය',
      'email': 'විද්යුත් තැපෑල', // Added
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
      'creditScore': 'ණය ලකුණු',
      // --- Validation Messages (Example) ---
      'validationEnterUsername': 'කරුණාකර පරිශීලක නාමයක් ඇතුළත් කරන්න',
      'validationEnterEmail': 'කරුණාකර විද්‍යුත් තැපෑලක් ඇතුළත් කරන්න',
      'validationValidEmail': 'කරුණාකර වලංගු විද්‍යුත් තැපෑලක් ඇතුළත් කරන්න',
      'validationEnterPhone': 'කරුණාකර දුරකථන අංකයක් ඇතුළත් කරන්න',
      'validationEnterNIC': 'කරුණාකර හැඳුනුම්පත් අංකයක් ඇතුළත් කරන්න',
      'validationEnterPassword': 'කරුණාකර මුරපදයක් ඇතුළත් කරන්න',
      'validationPasswordLength': 'මුරපදය අවම වශයෙන් අක්ෂර 6 ක් විය යුතුය',
      'validationEnterBusNo': 'කරුණාකර බස් අංකයක් ඇතුළත් කරන්න',
      'validationEnterRouteNo': 'කරුණාකර මාර්ග අංකයක් ඇතුළත් කරන්න',
    },
    'Tamil': {
      'appSubtitle': 'அனைத்து பஸ் பயண துணை',
      'register': 'பதிவு செய்',
      'login': 'உள்நுழை',
      'username': 'பயனர் பெயர்',
      'email': 'மின்னஞ்சல்', // Added
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
      'creditScore': 'கடன் மதிப்பெண்',
      // --- Validation Messages (Example) ---
      'validationEnterUsername': 'பயனர் பெயரை உள்ளிடவும்',
      'validationEnterEmail': 'மின்னஞ்சலை உள்ளிடவும்',
      'validationValidEmail': 'சரியான மின்னஞ்சலை உள்ளிடவும்',
      'validationEnterPhone': 'தொலைபேசி எண்ணை உள்ளிடவும்',
      'validationEnterNIC': 'NIC ஐ உள்ளிடவும்',
      'validationEnterPassword': 'கடவுச்சொல்லை உள்ளிடவும்',
      'validationPasswordLength': 'கடவுச்சொல் குறைந்தது 6 எழுத்துகளாக இருக்க வேண்டும்',
      'validationEnterBusNo': 'பஸ் எண்ணை உள்ளிடவும்',
      'validationEnterRouteNo': 'பாதை எண்ணை உள்ளிடவும்',
    },
  };

  // --- Getters for each string ---
  // Helper method to safely get a value or return a fallback string
  String _getString(String key) {
    return _localizedValues[languageCode]?[key] ?? '[$key not found]';
  }

  String get appSubtitle => _getString('appSubtitle');
  String get register => _getString('register');
  String get login => _getString('login');
  String get username => _getString('username');
  String get email => _getString('email'); // <-- The important getter
  String get password => _getString('password');
  String get phoneNo => _getString('phoneNo');
  String get nic => _getString('nic');
  String get busNo => _getString('busNo');
  String get routeNo => _getString('routeNo');
  String get forgotPassword => _getString('forgotPassword');
  String get registrationSuccess => _getString('registrationSuccess');
  String get ok => _getString('ok');
  String get startLocation => _getString('startLocation');
  String get endLocation => _getString('endLocation');
  String get startJourney => _getString('startJourney');
  String get started => _getString('started');
  String get profile => _getString('profile');
  String get profileSubtitle => _getString('profileSubtitle');
  String get about => _getString('about');
  String get aboutSubtitle => _getString('aboutSubtitle');
  String get logout => _getString('logout');
  String get aboutUs => _getString('aboutUs');
  String get aboutBody1 => _getString('aboutBody1');
  String get aboutBody2 => _getString('aboutBody2');
  String get version => _getString('version');
  String get developedBy => _getString('developedBy');
  String get releasedDate => _getString('releasedDate');
  String get creditScore => _getString('creditScore');

  // --- Getters for Validation Messages ---
  String get validationEnterUsername => _getString('validationEnterUsername');
  String get validationEnterEmail => _getString('validationEnterEmail');
  String get validationValidEmail => _getString('validationValidEmail');
  String get validationEnterPhone => _getString('validationEnterPhone');
  String get validationEnterNIC => _getString('validationEnterNIC');
  String get validationEnterPassword => _getString('validationEnterPassword');
  String get validationPasswordLength => _getString('validationPasswordLength');
  String get validationEnterBusNo => _getString('validationEnterBusNo');
  String get validationEnterRouteNo => _getString('validationEnterRouteNo');
}

