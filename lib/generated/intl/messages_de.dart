// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(prefix) => "präfix \"${prefix}\" hinzufügen";

  static String m1(prefix) =>
      "fügt \"${prefix}\" vor dem ursprünglichen dateinamen ein. deaktivieren behält den originalnamen";

  static String m2(version) => "neu in ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'noch etwa 1 minute', other: 'noch etwa ${count} minuten')}";

  static String m4(current, total) => "Foto ${current} von ${total}";

  static String m5(completed, total) =>
      "${completed} von ${total} Fotos komprimiert";

  static String m6(count) => "Speichern Sie ${count}-Fotos";

  static String m7(album) =>
      "Speichert komprimierte Fotos im ${album}-Album statt in den zuletzt gespeicherten Fotos";

  static String m8(error) =>
      "Fotos gespeichert, aber einige Originale konnten nicht gelöscht werden: ${error}";

  static String m9(saved, deleted) =>
      "gespeicherte(s) ${saved}-Foto(s) und gelöschte(s) ${deleted}-Original(e)";

  static String m10(count) => "${count}-Fotos in der Galerie gespeichert";

  static String m11(error) =>
      "Fotos mit einigen Problemen gespeichert: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'noch etwa 1 sekunde', other: 'noch etwa ${count} sekunden')}";

  static String m13(url) =>
      "Probieren Sie Minimo (Foto) aus – eine einfache App zum Verkleinern von Fotos auf Ihrem Telefon: ${url}";

  static String m14(size) => "du hast ${size} gespart";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("über die app"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (Foto) entstand aus einer einfachen Frustration.\n\nDieses Projekt bietet jedem eine bequeme und kostenlose Möglichkeit, Fotos direkt auf einem mobilen Gerät zu komprimieren, Speicherplatz zu sparen und die wichtigen Momente festzuhalten.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("erweitert"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "keine sinnvollen Einsparungen",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "Durch diese Einstellungen wurde die Datei nicht um mindestens 10 % verkleinert. Versuchen Sie es mit geringerer Qualität oder geringeren Abmessungen.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "Halten Sie Minimo offen, bis die Komprimierung abgeschlossen ist. Ihr Telefon pausiert möglicherweise die App, wenn Sie wegschalten",
    ),
    "better": MessageLookupByLibrary.simpleMessage("besser"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "cache konnte nicht geleert werden",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache geleert"),
    "cancel": MessageLookupByLibrary.simpleMessage("abbrechen"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("verstanden"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "änderungen aus updates, die du noch nicht gesehen hast",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("cache leeren"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "Entfernt temporäre App-Dateien. In Ihrer Galerie gespeicherte Fotos bleiben davon unberührt",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("vergleichen"),
    "compress": MessageLookupByLibrary.simpleMessage("komprimieren"),
    "compressed": MessageLookupByLibrary.simpleMessage("komprimiert"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("danach"),
    "compressing": MessageLookupByLibrary.simpleMessage("wird komprimiert..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "komprimierung abgebrochen",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "komprimierung abgeschlossen",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "komprimierung abgeschlossen",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "komprimierung fehlgeschlagen",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "Wir konnten dieses Foto nicht komprimieren. Versuchen Sie es erneut oder wählen Sie ein anderes.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("dunkles design"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "dunkle darstellung verwenden",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("Fotoqualität"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "Legen Sie eine Zielqualität fest oder lassen Sie sie von der Qualitätsvoreinstellung auswählen",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("e-mail kopiert"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "restzeit wird geschätzt...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("fehlgeschlagen"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie eine Fotodatei",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "Die Fotos konnten nicht gespeichert werden. Versuchen Sie es noch einmal",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "konnte die Fotos nicht teilen. Versuchen Sie es noch einmal",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic war nicht verfügbar, daher wurde dieses Foto als JPEG gespeichert",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("loslegen"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "github-repository",
    ),
    "good": MessageLookupByLibrary.simpleMessage("gut"),
    "high": MessageLookupByLibrary.simpleMessage("hoch"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "taste halten, um die komprimierung abzubrechen",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "taste halten, um den cache zu leeren",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "taste halten, um originale zu löschen",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo erstellt eine neue Kopie Ihres Fotos und speichert es effizienter. Dies kann die Bildqualität oder -abmessungen verringern, während das Ergebnis brauchbar bleibt.\n\nEine geringere Qualität speichert weniger kleine Details, die schwer zu erkennen sind. Kleinere Abmessungen verbrauchen weniger Pixel. Beide reduzieren die Dateigröße.\n\nIhr Originalfoto bleibt unberührt und die Komprimierung erfolgt auf Ihrem Gerät.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "wie das Foto kleiner wird",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("Exif-Metadaten behalten"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("Metadaten"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "Behalten Sie Kamera- und Exif-Informationen bei, sofern dies unterstützt wird",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "Metadaten behalten",
    ),
    "language": MessageLookupByLibrary.simpleMessage("sprache"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "sprache der app auswählen",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "Das Herunterladen aus dem Cloud-Speicher oder das Kopieren großer Dateien kann länger dauern",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "Fotos werden geladen...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("niedrig"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("von khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "maximale Dimension",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "Begrenzen Sie die längste Bildseite. Kleinere Werte sparen mehr Platz",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("mittel"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("Metadatenmodus"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "Behalten Sie Kamera- und EXIF-Informationen bei, sofern diese unterstützt werden, oder entfernen Sie sie",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "einige galeriemetadaten konnten nicht kopiert werden",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("meine anderen apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("meine website"),
    "next": MessageLookupByLibrary.simpleMessage("weiter"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "versuche einen anderen modus – dieser verkleinert die datei nicht",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie ein oder mehrere Fotos aus. Minimo arbeitet mit lokalen Dateien und lässt die Originale unberührt",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "Fotos auswählen",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie eine Qualitätsvoreinstellung oder passen Sie Abmessungen und Metadaten manuell an",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "änderungen auswählen",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "Die Komprimierung erfolgt auf Ihrem Gerät. Fotos werden nirgendwo hochgeladen; Speichern Sie die kleinere Kopie, wenn Ihnen das Ergebnis gefällt",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "standardmäßig privat",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (Foto) ist Open Source. Entdecken Sie den Code, verfolgen Sie das Projekt oder nehmen Sie Kontakt mit uns auf",
    ),
    "original": MessageLookupByLibrary.simpleMessage("original"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "einige originale konnten nicht gelöscht werden",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("vor"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("Ausgabeformat"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "JPEG funktioniert überall; heic kann kleiner sein, kann aber auf JPEG zurückgreifen",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "die komprimierung kann langsamer werden, wenn dein gerät heiß wird",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "Vorschau nicht verfügbar",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "Bei höherer Qualität bleiben mehr Details erhalten und es entsteht eine größere Datei",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "Behalten Sie Details und Originalmaße bei",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "kleinere Dateien zum Teilen",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "ausgewogene Qualität und Dateigröße",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "Fotos komprimiert",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("aus dateien"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("aus galerie"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "bildschirm aktiv halten",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "Verhindert, dass der Bildschirm in den Ruhezustand wechselt, während Fotos geladen oder komprimiert werden",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("projektwebsite"),
    "quality": MessageLookupByLibrary.simpleMessage("qualität"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "Die Qualität wird reduziert, um Platz zu sparen",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("app bewerten"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "standort entfernen",
    ),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "standort aus gespeicherten fotos entfernen, andere metadaten behalten",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "original ersetzen",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "Speichern Sie mit den ursprünglichen Metadaten und bitten Sie dann um die Löschung des Originals",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("Bildabmessungen"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "Begrenzen Sie die längste Bildseite. kleinere Abmessungen sparen mehr Platz",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("auflösung"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "abmessungen für die größte platzersparnis reduzieren",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "die auflösung wird auf hd reduziert",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "die auflösung wird auf sd reduziert",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("speichern"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("als neu speichern"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "Behalten Sie das Original und speichern Sie ein neues Galeriefoto",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "neben original speichern",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "original behalten und datum sowie metadaten kopieren",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("speicherart"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "Fotos im Album speichern",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("gespeichert"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("einstellungen"),
    "share": MessageLookupByLibrary.simpleMessage("teilen"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "teilen oder speichern unter…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "mit freunden teilen",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "überhitzungswarnung anzeigen",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "zeigt während der komprimierung einen kleinen hinweis, wenn das gerät langsamer werden kann",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("einfach"),
    "skip": MessageLookupByLibrary.simpleMessage("überspringen"),
    "small": MessageLookupByLibrary.simpleMessage("klein"),
    "smaller": MessageLookupByLibrary.simpleMessage("kleiner"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("speicher gespart"),
    "statistics": MessageLookupByLibrary.simpleMessage("statistik"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "Statistiken werden lokal auf diesem Gerät gespeichert.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "Metadaten entfernen",
    ),
    "system": MessageLookupByLibrary.simpleMessage("system"),
    "todo": MessageLookupByLibrary.simpleMessage("todo"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("erneut versuchen"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "Nicht gespeicherte komprimierte Fotos belassen und löschen?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "nicht gespeicherte Fotos",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "Verkleinern Sie Videos direkt auf Ihrem Telefon",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("wartet"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
