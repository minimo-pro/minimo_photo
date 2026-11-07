// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(prefix) => "aggiungi il prefisso \"${prefix}\"";

  static String m1(prefix) =>
      "aggiunge \"${prefix}\" prima del nome originale. disattivando l\'opzione, il nome originale viene mantenuto";

  static String m2(version) => "novità di ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'circa 1 minuto rimanente', other: 'circa ${count} minuti rimanenti')}";

  static String m4(current, total) => "foto ${current} di ${total}";

  static String m5(completed, total) =>
      "${completed} di foto ${total} compresse";

  static String m6(count) => "salva le foto ${count}";

  static String m7(album) =>
      "salva le foto compresse nell\'album ${album} anziché salvate di recente";

  static String m8(error) =>
      "foto salvate, ma non è stato possibile eliminare alcuni originali: ${error}";

  static String m9(saved, deleted) =>
      "foto ${saved} salvate e originali ${deleted} cancellati";

  static String m10(count) => "foto ${count} salvate nella galleria";

  static String m11(error) => "foto salvate con alcuni problemi: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'circa 1 secondo rimanente', other: 'circa ${count} secondi rimanenti')}";

  static String m13(url) =>
      "prova minimo (foto) — una semplice app per rimpicciolire le foto sul tuo telefono: ${url}";

  static String m14(size) => "hai risparmiato ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("informazioni"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) nasce da una semplice frustrazione.\n\nquesto progetto offre a tutti un modo comodo e gratuito per comprimere le foto direttamente su un dispositivo mobile, risparmiare spazio di archiviazione e conservare i momenti che contano.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("avanzato"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "nessun risparmio utile",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "queste impostazioni non hanno ridotto il file almeno del 10%. provare qualità o dimensioni inferiori.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "mantenere il minimo aperto fino al termine della compressione. il tuo telefono potrebbe mettere in pausa l\'app se passi dall\'altra parte",
    ),
    "better": MessageLookupByLibrary.simpleMessage("migliore"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "impossibile svuotare la cache",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache svuotata"),
    "cancel": MessageLookupByLibrary.simpleMessage("annulla"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("capito"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "modifiche degli aggiornamenti che non hai ancora visto",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("svuota cache"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "rimuove i file temporanei dell\'app. le foto salvate nella tua galleria rimangono intatte",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("confrontare"),
    "compress": MessageLookupByLibrary.simpleMessage("comprimi"),
    "compressed": MessageLookupByLibrary.simpleMessage("compresso"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("dopo"),
    "compressing": MessageLookupByLibrary.simpleMessage("compressione..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compressione annullata",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compressione completata",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compressione completata",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "compressione non riuscita",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "non siamo riusciti a comprimere questa foto. riprova o scegline un altro.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("tema scuro"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "usa l\'aspetto scuro",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("qualità della foto"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "impostare una qualità target o lasciare che sia la preimpostazione della qualità a sceglierla",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("e-mail copiata"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "stima del tempo rimanente...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("non riuscito"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "scegli un file di foto",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "non è stato possibile salvare le foto. riprovare",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "non è stato possibile condividere le foto. riprovare",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic non era disponibile, quindi questa foto è stata salvata come jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("inizia"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "repository github",
    ),
    "good": MessageLookupByLibrary.simpleMessage("buona"),
    "high": MessageLookupByLibrary.simpleMessage("alta"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "tieni premuto il pulsante per annullare la compressione",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "tieni premuto il pulsante per svuotare la cache",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "tieni premuto il pulsante per eliminare gli originali",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo crea una nuova copia della tua foto e la memorizza in modo più efficiente. può ridurre la qualità o le dimensioni dell\'immagine mantenendo il risultato utile.\n\nuna qualità inferiore memorizza meno piccoli dettagli difficili da notare. le dimensioni più piccole utilizzano meno pixel. entrambi riducono la dimensione del file.\n\nla tua foto originale rimane intatta e la compressione avviene sul tuo dispositivo.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "come la foto diventa più piccola",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage(
      "mantieni i metadati EXIF",
    ),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("metadati"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "preservare le informazioni sulla fotocamera e sugli EXIF quando supportato",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "conservare i metadati",
    ),
    "language": MessageLookupByLibrary.simpleMessage("lingua"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "scegli la lingua dell\'app",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("esci"),
    "leaveWithoutSaving": MessageLookupByLibrary.simpleMessage(
      "esci senza salvare",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "il download dall\'archivio cloud o la copia di file di grandi dimensioni potrebbe richiedere più tempo",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "caricamento foto...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("bassa"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("di khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "dimensione massima",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "limitare il lato più lungo dell\'immagine; valori più piccoli consentono di risparmiare più spazio",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("media"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("modalità metadati"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "mantenere le informazioni sulla fotocamera e EXIF quando supportate oppure rimuoverle",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "alcuni metadati della galleria non sono stati copiati",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("le mie altre app"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("il mio sito"),
    "next": MessageLookupByLibrary.simpleMessage("avanti"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "prova un\'altra modalità — questa non ridurrà le dimensioni",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "scegli una o più foto. minimo funziona con file locali e mantiene intatti gli originali",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "scegli le foto",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "scegli una preimpostazione di qualità o regola manualmente dimensioni e metadati",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "scegli cosa modificare",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "la compressione avviene sul tuo dispositivo. le foto non vengono caricate da nessuna parte; salva la copia più piccola quando ti piace il risultato",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "privato per impostazione predefinita",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) è open source. esplora il codice, segui il progetto o contattaci",
    ),
    "original": MessageLookupByLibrary.simpleMessage("originale"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "alcuni originali non sono stati eliminati",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("prima"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("formato di uscita"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg funziona ovunque; heic può essere più piccolo ma potrebbe ricadere su jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "la compressione può rallentare se il dispositivo si surriscalda",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "anteprima non disponibile",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "una qualità più elevata mantiene più dettagli e crea un file più grande",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "mantenere i dettagli e le dimensioni originali",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "file più piccoli da condividere",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "qualità e dimensioni del file bilanciate",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "foto compresse",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("dai file"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("dalla galleria"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "mantieni lo schermo acceso",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "impedisce allo schermo di andare in stop durante il caricamento o la compressione delle foto",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("sito del progetto"),
    "quality": MessageLookupByLibrary.simpleMessage("qualità"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "la qualità verrà ridotta per risparmiare spazio",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("valuta l\'app"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("rimuovi posizione"),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "rimuovi la posizione dalle foto salvate mantenendo gli altri metadati",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "sostituisci l\'originale",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "salva con i metadati originali, quindi chiedi di eliminare l\'originale",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("dimensioni dell\'immagine"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "limitare il lato più lungo dell\'immagine; le dimensioni più piccole consentono di risparmiare più spazio",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("risoluzione"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "riduci le dimensioni per risparmiare più spazio",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "la risoluzione verrà ridotta a hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "la risoluzione verrà ridotta a sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("salva"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("salva come nuovo"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "mantieni l\'originale e salva una nuova foto della galleria",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "salva accanto all\'originale",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "mantieni l\'originale e copia data e metadati",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("come salvare"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "salvare le foto nell\'album",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("salvato"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("impostazioni"),
    "share": MessageLookupByLibrary.simpleMessage("condividi"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "condividi o salva in…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "condividi con gli amici",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "mostra avviso di surriscaldamento",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "mostra un piccolo avviso durante la compressione quando il dispositivo potrebbe rallentare",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("semplice"),
    "skip": MessageLookupByLibrary.simpleMessage("salta"),
    "small": MessageLookupByLibrary.simpleMessage("piccolo"),
    "smaller": MessageLookupByLibrary.simpleMessage("più piccolo"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage(
      "spazio risparmiato",
    ),
    "statistics": MessageLookupByLibrary.simpleMessage("statistiche"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "le statistiche vengono archiviate localmente su questo dispositivo.",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("rimani"),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "eliminare i metadati",
    ),
    "system": MessageLookupByLibrary.simpleMessage("sistema"),
    "todo": MessageLookupByLibrary.simpleMessage("fare"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("riprova"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "lasciare ed eliminare le foto compresse non salvate?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "foto non salvate",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "rimpicciolisci i video, direttamente sul tuo telefono",
    ),
    "videoAppPromptTitle": MessageLookupByLibrary.simpleMessage(
      "comprimere anche i video?",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("in attesa"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
