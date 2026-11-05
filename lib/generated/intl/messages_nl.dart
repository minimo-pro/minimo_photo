// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(prefix) => "voorvoegsel \"${prefix}\" toevoegen";

  static String m1(prefix) =>
      "voegt \"${prefix}\" toe voor de oorspronkelijke bestandsnaam. uitschakelen behoudt de oorspronkelijke naam";

  static String m2(version) => "nieuw in ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'nog ongeveer 1 minuut', other: 'nog ongeveer ${count} minuten')}";

  static String m4(current, total) => "foto ${current} of ${total}";

  static String m5(completed, total) =>
      "${completed} van ${total}-foto\'s gecomprimeerd";

  static String m6(count) => "bewaar ${count}-foto\'s";

  static String m7(album) =>
      "slaat gecomprimeerde foto\'s op in het ${album}-album in plaats van recentelijk opgeslagen";

  static String m8(error) =>
      "foto\'s opgeslagen, maar sommige originelen konden niet worden verwijderd: ${error}";

  static String m9(saved, deleted) =>
      "opgeslagen ${saved}-foto(\'s) en verwijderde ${deleted}-origineel(en)";

  static String m10(count) => "${count}-foto\'s opgeslagen in galerij";

  static String m11(error) =>
      "foto\'s opgeslagen met enkele problemen: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'nog ongeveer 1 seconde', other: 'nog ongeveer ${count} seconden')}";

  static String m13(url) =>
      "probeer minimo (foto) — een eenvoudige app om foto\'s kleiner te maken op je telefoon: ${url}";

  static String m14(size) => "je hebt ${size} bespaard";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("over de app"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) is ontstaan uit een simpele frustratie.\n\ndit project biedt iedereen een handige en gratis manier om foto\'s rechtstreeks op een mobiel apparaat te comprimeren, opslagruimte te besparen en de momenten die er toe doen vast te leggen.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("geavanceerd"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "geen nuttige besparingen",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "deze instellingen hebben het bestand niet met minstens 10% verkleind. probeer een lagere kwaliteit of afmetingen.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "houd minimo open totdat de compressie is voltooid. uw telefoon kan de app pauzeren als u wegschakelt",
    ),
    "better": MessageLookupByLibrary.simpleMessage("beter"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "cache kon niet worden gewist",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache gewist"),
    "cancel": MessageLookupByLibrary.simpleMessage("annuleren"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("begrepen"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "wijzigingen uit updates die je nog niet hebt gezien",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("cache wissen"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "verwijdert tijdelijke app-bestanden. foto\'s die in uw galerij zijn opgeslagen, blijven onaangeroerd",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("vergelijk"),
    "compress": MessageLookupByLibrary.simpleMessage("comprimeren"),
    "compressed": MessageLookupByLibrary.simpleMessage("gecomprimeerd"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("na"),
    "compressing": MessageLookupByLibrary.simpleMessage("comprimeren..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compressie geannuleerd",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compressie voltooid",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compressie voltooid",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "compressie mislukt",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "we konden deze foto niet comprimeren. probeer het opnieuw of kies een andere.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("donker thema"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "gebruik de donkere weergave",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("foto kwaliteit"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "stel een doelkwaliteit in of laat de kwaliteitsvoorinstelling deze kiezen",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage(
      "e-mailadres gekopieerd",
    ),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "resterende tijd schatten...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("mislukt"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "kies een fotobestand",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "kon de foto\'s niet opslaan. probeer het opnieuw",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "kon de foto\'s niet delen. probeer het opnieuw",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic was niet beschikbaar, dus deze foto is opgeslagen als jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("aan de slag"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "github-repository",
    ),
    "good": MessageLookupByLibrary.simpleMessage("goed"),
    "high": MessageLookupByLibrary.simpleMessage("hoog"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "houd de knop ingedrukt om de compressie te annuleren",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "houd de knop ingedrukt om de cache te wissen",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "houd de knop ingedrukt om originelen te verwijderen",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo maakt een nieuwe kopie van uw foto en slaat deze efficiënter op. het kan de beeldkwaliteit of afmetingen verminderen terwijl het resultaat bruikbaar blijft.\n\nlagere kwaliteit slaat minder kleine details op die moeilijk op te merken zijn. kleinere afmetingen gebruiken minder pixels. beide verkleinen de bestandsgrootte.\n\nuw originele foto blijft onaangeroerd en de compressie vindt plaats op uw apparaat.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "hoe de foto kleiner wordt",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage(
      "bewaar exif-metagegevens",
    ),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("metagegevens"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "bewaar camera- en exif-informatie indien ondersteund",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "metagegevens bewaren",
    ),
    "language": MessageLookupByLibrary.simpleMessage("taal"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "kies de taal van de app",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "downloaden vanuit de cloudopslag of het kopiëren van grote bestanden kan langer duren",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("foto\'s laden..."),
    "low": MessageLookupByLibrary.simpleMessage("laag"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("door khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "maximale afmeting",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "beperk de langste beeldzijde; kleinere waarden besparen meer ruimte",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("gemiddeld"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("metadatamodus"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "bewaar camera- en EXIF-informatie indien ondersteund, of verwijder deze",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "sommige galerijmetadata kon niet worden gekopieerd",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("mijn andere apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("mijn website"),
    "next": MessageLookupByLibrary.simpleMessage("volgende"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "probeer een andere modus — deze maakt het bestand niet kleiner",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "kies één of meerdere foto\'s. minimo werkt met lokale bestanden en houdt de originelen onaangeroerd",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("kies foto\'s"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "kies een kwaliteitsvoorinstelling of pas afmetingen en metadata handmatig aan",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "kies wat er verandert",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "compressie vindt plaats op uw apparaat. foto\'s worden nergens geüpload; bewaar de kleinere kopie als het resultaat u bevalt",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "standaard privé",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) is open source. verken de code, volg het project of neem contact op",
    ),
    "original": MessageLookupByLibrary.simpleMessage("origineel"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "sommige originelen konden niet worden verwijderd",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("voor"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("uitvoerformaat"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg werkt overal; heic kan kleiner zijn, maar kan terugvallen op jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "compressie kan trager worden als je apparaat warm wordt",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "voorbeeld niet beschikbaar",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "hogere kwaliteit behoudt meer details en creëert een groter bestand",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "behoud details en originele afmetingen",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "kleinere bestanden om te delen",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "evenwichtige kwaliteit en bestandsgrootte",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "foto\'s gecomprimeerd",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("uit bestanden"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("uit galerij"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "scherm ingeschakeld houden",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "voorkomt dat het scherm slaapt terwijl foto\'s worden geladen of gecomprimeerd",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("projectwebsite"),
    "quality": MessageLookupByLibrary.simpleMessage("kwaliteit"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "de kwaliteit zal worden verminderd om ruimte te besparen",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("beoordeel de app"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "locatie verwijderen",
    ),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "verwijder de locatie uit opgeslagen foto\'s en behoud andere metagegevens",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "origineel vervangen",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "sla op met de originele metagegevens en vraag vervolgens om het origineel te verwijderen",
    ),
    "resize": MessageLookupByLibrary.simpleMessage(
      "afmetingen van afbeeldingen",
    ),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "beperk de langste beeldzijde; kleinere afmetingen besparen meer ruimte",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("resolutie"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "verlaag de afmetingen voor de grootste ruimtebesparing",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "de resolutie wordt verlaagd naar hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "de resolutie wordt verlaagd naar sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("opslaan"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("opslaan als nieuw"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "bewaar het origineel en sla een nieuwe galerijfoto op",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "naast origineel opslaan",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "behoud het origineel en kopieer de datum en metadata",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage(
      "manier van opslaan",
    ),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "foto\'s opslaan in album",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("opgeslagen"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("instellingen"),
    "share": MessageLookupByLibrary.simpleMessage("delen"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("delen of opslaan in…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "delen met vrienden",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "waarschuwing voor oververhitting tonen",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "toont tijdens compressie een kleine melding wanneer het apparaat mogelijk trager wordt",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("eenvoudig"),
    "skip": MessageLookupByLibrary.simpleMessage("overslaan"),
    "small": MessageLookupByLibrary.simpleMessage("klein"),
    "smaller": MessageLookupByLibrary.simpleMessage("kleiner"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("ruimte bespaard"),
    "statistics": MessageLookupByLibrary.simpleMessage("statistieken"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "statistieken worden lokaal op dit apparaat opgeslagen.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "metagegevens verwijderen",
    ),
    "system": MessageLookupByLibrary.simpleMessage("systeem"),
    "todo": MessageLookupByLibrary.simpleMessage("taak"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("opnieuw proberen"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "niet-opgeslagen gecomprimeerde foto\'s achterlaten en verwijderen?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "niet-opgeslagen foto\'s",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "maak video\'s kleiner, rechtstreeks op je telefoon",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("wachten"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
