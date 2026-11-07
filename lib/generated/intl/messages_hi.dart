// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  static String m0(prefix) => "\"${prefix}\" प्रीफ़िक्स जोड़ें";

  static String m1(prefix) =>
      "मूल फ़ाइल नाम से पहले \"${prefix}\" जोड़ता है। बंद करने पर मूल नाम रहता है";

  static String m2(version) => "${version} में नया";

  static String m3(count) =>
      "${Intl.plural(count, one: 'लगभग 1 मिनट बाक़ी', other: 'लगभग ${count} मिनट बाक़ी')}";

  static String m4(current, total) => "${total} का फोटो ${current}";

  static String m5(completed, total) =>
      "${total} फ़ोटो में से ${completed} संपीड़ित";

  static String m6(count) => "${count} फ़ोटो सहेजें";

  static String m7(album) =>
      "हाल ही में सहेजे गए फ़ोटो के बजाय संपीड़ित फ़ोटो को ${album} एल्बम में सहेजता है";

  static String m8(error) =>
      "तस्वीरें सहेजी गईं, लेकिन कुछ मूल हटाई नहीं जा सकीं: ${error}";

  static String m9(saved, deleted) =>
      "${saved} फोटो सहेजे गए और ${deleted} मूल हटा दिए गए";

  static String m10(count) => "गैलरी में ${count} तस्वीरें सहेजी गईं";

  static String m11(error) =>
      "कुछ समस्याओं के साथ तस्वीरें सहेजी गईं: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'लगभग 1 सेकंड बाक़ी', other: 'लगभग ${count} सेकंड बाक़ी')}";

  static String m13(url) =>
      "मिनिमो (फोटो) आज़माएँ - आपके फ़ोन पर फ़ोटो को छोटा बनाने के लिए एक सरल ऐप: ${url}";

  static String m14(size) => "आपने ${size} बचाया";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("ऐप के बारे में"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "मिनिमो (फोटो) का जन्म एक साधारण निराशा से हुआ था।\n\nयह प्रोजेक्ट हर किसी को सीधे मोबाइल डिवाइस पर फोटो कंप्रेस करने, स्टोरेज बचाने और महत्वपूर्ण क्षणों को सहेजने का एक सुविधाजनक और मुफ्त तरीका देता है।",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("उन्नत"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "कोई उपयोगी बचत नहीं",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "इन सेटिंग्स ने फ़ाइल को कम से कम 10% तक कम नहीं किया। निम्न गुणवत्ता या आयाम आज़माएँ.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("ऑटो"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "संपीड़न पूरा होने तक minimo खुला रखें। दूसरे ऐप पर जाने से आपका फ़ोन minimo को रोक सकता है",
    ),
    "better": MessageLookupByLibrary.simpleMessage("बेहतर"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "कैश साफ़ नहीं हुआ",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("कैश साफ़"),
    "cancel": MessageLookupByLibrary.simpleMessage("रद्द करें"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("समझ गया"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "अनदेखे अपडेट के बदलाव",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("कैश साफ़ करें"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "अस्थायी ऐप फ़ाइलें हटा देता है। आपकी गैलरी में सहेजी गई तस्वीरें अछूती रहती हैं",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("तुलना करें"),
    "compress": MessageLookupByLibrary.simpleMessage("कंप्रेस करें"),
    "compressed": MessageLookupByLibrary.simpleMessage("कंप्रेस्ड"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("के बाद"),
    "compressing": MessageLookupByLibrary.simpleMessage("कंप्रेस हो रहा है..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "कंप्रेशन रद्द",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "कंप्रेशन पूरा",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "कंप्रेशन पूरा हुआ",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage("कंप्रेशन असफल"),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "हम इस फ़ोटो को संपीड़ित नहीं कर सके. पुनः प्रयास करें या कोई अन्य चुनें।",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("डार्क थीम"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "गहरा रूप इस्तेमाल करें",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("फोटो गुणवत्ता"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "एक लक्ष्य गुणवत्ता निर्धारित करें या गुणवत्ता पूर्व निर्धारित को इसे चुनने दें",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("ईमेल कॉपी हुआ"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "बचा समय आँक रहे हैं...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("असफल"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "एक फोटो फ़ाइल चुनें",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "तस्वीरें सहेजी नहीं जा सकीं. पुनः प्रयास करें",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "फ़ोटो साझा नहीं कर सके. पुनः प्रयास करें",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic उपलब्ध नहीं था, इसलिए इस फ़ोटो को jpeg के रूप में सहेजा गया था",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("शुरू करें"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "github रिपॉज़िटरी",
    ),
    "good": MessageLookupByLibrary.simpleMessage("अच्छी"),
    "high": MessageLookupByLibrary.simpleMessage("उच्च"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "कंप्रेशन रोकने के लिए बटन दबाए रखें",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "कैश साफ़ करने के लिए बटन दबाए रखें",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "मूल हटाने के लिए बटन दबाए रखें",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "मिनिमो आपके फोटो की एक नई प्रतिलिपि बनाता है और इसे अधिक कुशलता से संग्रहीत करता है। यह परिणाम को उपयोगी बनाए रखते हुए छवि गुणवत्ता या आयाम को कम कर सकता है।\n\nनिम्न गुणवत्ता में कम छोटे विवरण संग्रहीत होते हैं जिन पर ध्यान देना कठिन होता है। छोटे आयाम कम पिक्सेल का उपयोग करते हैं। दोनों फ़ाइल का आकार कम करते हैं।\n\nआपकी मूल फ़ोटो अछूती रहती है, और आपके डिवाइस पर संपीड़न होता है।",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "फोटो छोटी कैसे हो जाती है",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("एक्सिफ़ मेटाडेटा रखें"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("मेटाडेटा"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "समर्थित होने पर कैमरा और एक्सिफ़ जानकारी को सुरक्षित रखें",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage("मेटाडेटा रखें"),
    "language": MessageLookupByLibrary.simpleMessage("भाषा"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "ऐप की भाषा चुनें",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("बाहर निकलें"),
    "leaveWithoutSaving": MessageLookupByLibrary.simpleMessage("बिना सेव जाएँ"),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "क्लाउड स्टोरेज से डाउनलोड करने या बड़ी फ़ाइलों की प्रतिलिपि बनाने में अधिक समय लग सकता है",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "फ़ोटो लोड हो रहा है...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("कम"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("khlebobul द्वारा"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("अधिकतम आयाम"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "छवि के सबसे लंबे पक्ष को सीमित करें; छोटे मान अधिक स्थान बचाते हैं",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("मध्यम"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("मेटाडेटामोड"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "समर्थित होने पर कैमरा और EXIF जानकारी रखें, या हटा दें",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "कुछ गैलरी मेटाडेटा कॉपी नहीं हुआ",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("मेरे अन्य ऐप"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("मेरी वेबसाइट"),
    "next": MessageLookupByLibrary.simpleMessage("अगला"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "दूसरा मोड आज़माएँ — यह छोटा नहीं करेगा",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "एक या अनेक फ़ोटो चुनें. मिनिमो स्थानीय फ़ाइलों के साथ काम करता है और मूल फ़ाइलों को अछूता रखता है",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "तस्वीरें चुनें",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "एक गुणवत्ता प्रीसेट चुनें या आयाम और मेटाडेटा को मैन्युअल रूप से समायोजित करें",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "क्या बदलना है चुनें",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "आपके डिवाइस पर संपीड़न होता है. तस्वीरें कहीं भी अपलोड नहीं की जाती हैं; परिणाम पसंद आने पर छोटी प्रति सहेजें",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "डिफ़ॉल्ट रूप से निजी",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "मिनिमो (फोटो) खुला स्रोत है। कोड का अन्वेषण करें, प्रोजेक्ट का अनुसरण करें या संपर्क करें",
    ),
    "original": MessageLookupByLibrary.simpleMessage("मूल"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "कुछ मूल नहीं हटे",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("पहले"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("आउटपुट स्वरूप"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "जेपीईजी हर जगह काम करता है; heic छोटा हो सकता है लेकिन वापस jpeg पर आ सकता है",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "डिवाइस गरम होने पर कंप्रेशन धीमा हो सकता है",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "पूर्वावलोकन अनुपलब्ध",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "उच्च गुणवत्ता अधिक विवरण रखती है और एक बड़ी फ़ाइल बनाती है",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "विवरण और मूल आयाम रखें",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "साझा करने के लिए छोटी फ़ाइलें",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "संतुलित गुणवत्ता और फ़ाइल आकार",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "तस्वीरें संपीड़ित",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("फ़ाइलों से"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("गैलरी से"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "स्क्रीन चालू रखें",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "फ़ोटो लोड होने या संपीड़ित होने के दौरान स्क्रीन को निष्क्रिय होने से रोकता है",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("प्रोजेक्ट वेबसाइट"),
    "quality": MessageLookupByLibrary.simpleMessage("क्वालिटी"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "जगह बचाने के लिए गुणवत्ता कम की जाएगी",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("ऐप को रेट करें"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("लोकेशन हटाएं"),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "अन्य मेटाडेटा रखते हुए सेव की गई फ़ोटो से लोकेशन हटाएं",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("मूल बदलें"),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "मूल मेटाडेटा के साथ सहेजें, फिर मूल को हटाने के लिए कहें",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("छवि आयाम"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "छवि के सबसे लंबे पक्ष को सीमित करें; छोटे आयाम अधिक स्थान बचाते हैं",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("रिज़ॉल्यूशन"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "सबसे ज़्यादा स्पेस बचाने के लिए आकार घटाएँ",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "रिज़ॉल्यूशन hd होगा",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "रिज़ॉल्यूशन sd होगा",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("सेव"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("नया सेव करें"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "मूल रखें और एक नई गैलरी फ़ोटो सहेजें",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "मूल के पास सेव करें",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "मूल रखें और उसकी तारीख व मेटाडेटा कॉपी करें",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("कैसे सेव करें"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "फ़ोटो को एल्बम में सहेजें",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("सेव हुआ"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("सेटिंग्स"),
    "share": MessageLookupByLibrary.simpleMessage("शेयर"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("शेयर या सेव…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "दोस्तों के साथ शेयर करें",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "ओवरहीट चेतावनी दिखाएँ",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "डिवाइस धीमा हो सकने पर कंप्रेशन के दौरान छोटा बैनर दिखाता है",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("सरल"),
    "skip": MessageLookupByLibrary.simpleMessage("छोड़ें"),
    "small": MessageLookupByLibrary.simpleMessage("छोटा"),
    "smaller": MessageLookupByLibrary.simpleMessage("छोटा"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("बचाया गया स्थान"),
    "statistics": MessageLookupByLibrary.simpleMessage("आँकड़े"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "इस उपकरण पर आँकड़े स्थानीय रूप से संग्रहीत किए जाते हैं।",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("रुकें"),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "मेटाडेटा स्ट्रिप करें",
    ),
    "system": MessageLookupByLibrary.simpleMessage("सिस्टम"),
    "todo": MessageLookupByLibrary.simpleMessage("कार्य करना"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("फिर कोशिश करें"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "सहेजे न गए संपीड़ित फ़ोटो को छोड़ें और हटाएं?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "सहेजे न गए फ़ोटो",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "सीधे अपने फ़ोन पर वीडियो छोटे बनाएं",
    ),
    "videoAppPromptTitle": MessageLookupByLibrary.simpleMessage(
      "वीडियो भी संपीड़ित करें?",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("इंतज़ार"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
