// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(prefix) => "ajouter le préfixe \"${prefix}\"";

  static String m1(prefix) =>
      "ajoute \"${prefix}\" avant le nom d\'origine. la désactivation conserve le nom d\'origine";

  static String m2(version) => "nouveautés de ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'environ 1 minute restante', other: 'environ ${count} minutes restantes')}";

  static String m4(current, total) => "photo ${current} de ${total}";

  static String m5(completed, total) =>
      "Photos ${completed} de ${total} compressées";

  static String m6(count) => "enregistrer des photos ${count}";

  static String m7(album) =>
      "enregistre les photos compressées dans l\'album ${album} au lieu de celles récemment enregistrées";

  static String m8(error) =>
      "photos enregistrées, mais certains originaux n\'ont pas pu être supprimés : ${error}";

  static String m9(saved, deleted) =>
      "photo(s) ${saved} enregistrée(s) et original(s) ${deleted} supprimé(s)";

  static String m10(count) => "enregistré des photos ${count} dans la galerie";

  static String m11(error) =>
      "photos enregistrées avec quelques problèmes : ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'environ 1 seconde restante', other: 'environ ${count} secondes restantes')}";

  static String m13(url) =>
      "essayez minimo (photo) — une application simple pour réduire la taille des photos sur votre téléphone : ${url}";

  static String m14(size) => "vous avez économisé ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("à propos"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) est né d\'une simple frustration.\n\nce projet offre à chacun un moyen pratique et gratuit de compresser des photos directement sur un appareil mobile, d\'économiser de l\'espace de stockage et de conserver les moments qui comptent.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("avancé"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "pas d\'économies utiles",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "ces paramètres n\'ont pas réduit le fichier d\'au moins 10 %. essayez une qualité ou des dimensions inférieures.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "gardez minimo ouvert jusqu\'à la fin de la compression. votre téléphone peut mettre l\'application en pause si vous déconnectez",
    ),
    "better": MessageLookupByLibrary.simpleMessage("meilleure"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "impossible de vider le cache",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache vidé"),
    "cancel": MessageLookupByLibrary.simpleMessage("annuler"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("compris"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "modifications des mises à jour que vous n\'avez pas encore vues",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("vider le cache"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "supprime les fichiers d\'application temporaires. les photos enregistrées dans votre galerie restent intactes",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("comparer"),
    "compress": MessageLookupByLibrary.simpleMessage("compresser"),
    "compressed": MessageLookupByLibrary.simpleMessage("compressé"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("après"),
    "compressing": MessageLookupByLibrary.simpleMessage("compression..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compression annulée",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compression terminée",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compression terminée",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "échec de la compression",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "nous n\'avons pas pu compresser cette photo. réessayez ou choisissez-en un autre.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("thème sombre"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "utiliser l\'apparence sombre",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("qualité des photos"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "définir une qualité cible ou laisser le préréglage de qualité la choisir",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("e-mail copié"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "estimation du temps restant...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("échec"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "choisir un fichier photo",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "impossible de sauvegarder les photos. réessaye",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "je n\'ai pas pu partager les photos. réessaye",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "Heic n\'était pas disponible, donc cette photo a été enregistrée au format JPEG",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("commencer"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("dépôt github"),
    "good": MessageLookupByLibrary.simpleMessage("bonne"),
    "high": MessageLookupByLibrary.simpleMessage("haute"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "maintenez le bouton pour annuler la compression",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "maintenez le bouton pour vider le cache",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "maintenez le bouton pour supprimer les originaux",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo crée une nouvelle copie de votre photo et la stocke plus efficacement. cela peut réduire la qualité ou les dimensions de l’image tout en gardant le résultat utile.\n\nune qualité inférieure stocke moins de petits détails difficiles à remarquer. les dimensions plus petites utilisent moins de pixels. les deux réduisent la taille du fichier.\n\nvotre photo originale reste intacte et la compression se produit sur votre appareil.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "comment la photo devient plus petite",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage(
      "conserver les métadonnées exif",
    ),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("métadonnées"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "conserver les informations de la caméra et des exif lorsqu\'ils sont pris en charge",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "conserver les métadonnées",
    ),
    "language": MessageLookupByLibrary.simpleMessage("langue"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "choisissez la langue de l\'app",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("quitter"),
    "leaveWithoutSaving": MessageLookupByLibrary.simpleMessage(
      "quitter sans enregistrer",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "le téléchargement à partir du stockage cloud ou la copie de fichiers volumineux peut prendre plus de temps",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "chargement des photos...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("basse"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("par khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "dimension maximale",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "limiter le côté le plus long de l\'image ; des valeurs plus petites permettent d\'économiser plus d\'espace",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("moyenne"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("mode métadonnées"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "conserver les informations de l\'appareil photo et EXIF lorsqu\'elles sont prises en charge, ou les supprimer",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "certaines métadonnées de la galerie n\'ont pas pu être copiées",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("mes autres apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("mon site"),
    "next": MessageLookupByLibrary.simpleMessage("suivant"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "essayez un autre mode — celui-ci ne réduira pas la taille",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "choisissez une ou plusieurs photos. minimo fonctionne avec les fichiers locaux et conserve les originaux intacts",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "choisir des photos",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "choisissez un paramètre de qualité prédéfini ou ajustez manuellement les dimensions et les métadonnées",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "choisissez les modifications",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "la compression se produit sur votre appareil. les photos ne sont téléchargées nulle part ; enregistrez la plus petite copie lorsque vous aimez le résultat",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "privé par défaut",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) est open source. explorez le code, suivez le projet ou contactez-nous",
    ),
    "original": MessageLookupByLibrary.simpleMessage("original"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "certains originaux n\'ont pas pu être supprimés",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("avant"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("format de sortie"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg fonctionne partout ; heic peut être plus petit mais peut revenir au format jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "la compression peut ralentir si votre appareil chauffe",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "aperçu indisponible",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "une qualité supérieure conserve plus de détails et crée un fichier plus volumineux",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "conserver les détails et les dimensions d\'origine",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "fichiers plus petits à partager",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "qualité et taille de fichier équilibrées",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "photos compressées",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage(
      "depuis les fichiers",
    ),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage(
      "depuis la galerie",
    ),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "garder l\'écran allumé",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "empêche l\'écran de dormir pendant le chargement ou la compression des photos",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("site du projet"),
    "quality": MessageLookupByLibrary.simpleMessage("qualité"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "la qualité sera réduite pour gagner de la place",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("noter l\'app"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "supprimer la localisation",
    ),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "supprimer la localisation des photos enregistrées en conservant les autres métadonnées",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "remplacer l\'original",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "enregistrer avec les métadonnées d\'origine, puis demander de supprimer l\'original",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("dimensions de l\'image"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "limiter le côté le plus long de l\'image ; des dimensions plus petites permettent d\'économiser plus d\'espace",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("résolution"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "réduisez les dimensions pour gagner le plus d\'espace",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "la résolution sera réduite en hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "la résolution sera réduite en sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("enregistrer"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage(
      "enregistrer comme nouvelle",
    ),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "conservez l\'original et enregistrez une nouvelle photo de la galerie",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "enregistrer avec l\'original",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "conserver l\'original et copier sa date et ses métadonnées",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage(
      "méthode d\'enregistrement",
    ),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "enregistrer des photos dans un album",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("enregistré"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("réglages"),
    "share": MessageLookupByLibrary.simpleMessage("partager"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "partager ou enregistrer dans…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "partager avec des amis",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "afficher l\'avertissement de surchauffe",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "affiche une petite alerte pendant la compression si l\'appareil risque de ralentir",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("simple"),
    "skip": MessageLookupByLibrary.simpleMessage("passer"),
    "small": MessageLookupByLibrary.simpleMessage("petite"),
    "smaller": MessageLookupByLibrary.simpleMessage("plus petite"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("espace économisé"),
    "statistics": MessageLookupByLibrary.simpleMessage("statistiques"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "les statistiques sont stockées localement sur cet appareil.",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("rester"),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "supprimer les métadonnées",
    ),
    "system": MessageLookupByLibrary.simpleMessage("système"),
    "todo": MessageLookupByLibrary.simpleMessage("faire"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("réessayer"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "laisser et supprimer les photos compressées non enregistrées ?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "photos non enregistrées",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "réduisez la taille des vidéos, directement sur votre téléphone",
    ),
    "videoAppPromptTitle": MessageLookupByLibrary.simpleMessage(
      "vous compressez aussi des vidéos ?",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("en attente"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
