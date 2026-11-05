// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(prefix) => "añadir el prefijo \"${prefix}\"";

  static String m1(prefix) =>
      "añade \"${prefix}\" antes del nombre original. al desactivarlo se conserva el nombre original";

  static String m2(version) => "novedades de ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'queda cerca de 1 minuto', other: 'quedan cerca de ${count} minutos')}";

  static String m4(current, total) => "foto ${current} de ${total}";

  static String m5(completed, total) =>
      "Fotos ${completed} de ${total} comprimidas";

  static String m6(count) => "guardar fotos ${count}";

  static String m7(album) =>
      "guarda fotos comprimidas en el álbum ${album} en lugar de guardarlas recientemente";

  static String m8(error) =>
      "fotos guardadas, pero algunas originales no se pudieron eliminar: ${error}";

  static String m9(saved, deleted) =>
      "Fotos guardadas de ${saved} y originales de ${deleted} eliminados";

  static String m10(count) => "guardó fotos ${count} en la galería";

  static String m11(error) => "fotos guardadas con algunos problemas: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'queda cerca de 1 segundo', other: 'quedan cerca de ${count} segundos')}";

  static String m13(url) =>
      "prueba minimo (foto): una aplicación sencilla para hacer fotos más pequeñas en tu teléfono: ${url}";

  static String m14(size) => "ahorraste ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("acerca de"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) nació de una simple frustración.\n\neste proyecto ofrece a todos una forma cómoda y gratuita de comprimir fotos directamente en un dispositivo móvil, ahorrar almacenamiento y conservar los momentos importantes.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("avanzado"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "sin ahorros útiles",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "Estas configuraciones no redujeron el archivo en al menos un 10%. Pruebe con menor calidad o dimensiones.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "Mantenga el mínimo abierto hasta que finalice la compresión. su teléfono puede pausar la aplicación si la desconecta",
    ),
    "better": MessageLookupByLibrary.simpleMessage("mejor"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "no se pudo borrar la caché",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("caché borrada"),
    "cancel": MessageLookupByLibrary.simpleMessage("cancelar"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("entendido"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "cambios de actualizaciones que aún no has visto",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("borrar caché"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "elimina archivos temporales de aplicaciones. las fotos guardadas en tu galería permanecen intactas",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("comparar"),
    "compress": MessageLookupByLibrary.simpleMessage("comprimir"),
    "compressed": MessageLookupByLibrary.simpleMessage("comprimido"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("después"),
    "compressing": MessageLookupByLibrary.simpleMessage("comprimiendo..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compresión cancelada",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compresión completa",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compresión completada",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "falló la compresión",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "No pudimos comprimir esta foto. Inténtalo de nuevo o elige otro.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("tema oscuro"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "usar apariencia oscura",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("calidad de la foto"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "establezca una calidad objetivo o deje que la calidad preestablecida la elija",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("correo copiado"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "calculando el tiempo restante...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("fallido"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "elige un archivo de foto",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "No pude guardar las fotos. inténtalo de nuevo",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "No pude compartir las fotos. inténtalo de nuevo",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic no estaba disponible, por lo que esta foto se guardó como jpeg.",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("empezar"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "repositorio de github",
    ),
    "good": MessageLookupByLibrary.simpleMessage("buena"),
    "high": MessageLookupByLibrary.simpleMessage("alta"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "mantén pulsado el botón para cancelar la compresión",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "mantén pulsado el botón para borrar la caché",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "mantén pulsado el botón para eliminar los originales",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo hace una nueva copia de su foto y la almacena de manera más eficiente. puede reducir la calidad o las dimensiones de la imagen y al mismo tiempo mantener el resultado útil.\n\nLa calidad inferior almacena menos detalles pequeños que son difíciles de notar. las dimensiones más pequeñas utilizan menos píxeles. ambos reducen el tamaño del archivo.\n\nsu foto original permanece intacta y la compresión se produce en su dispositivo.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "cómo la foto se hace más pequeña",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("mantener metadatos exif"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("metadatos"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "conservar la información de la cámara y exif cuando sea compatible",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "mantener metadatos",
    ),
    "language": MessageLookupByLibrary.simpleMessage("idioma"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "elige el idioma de la app",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "descargar desde el almacenamiento en la nube o copiar archivos grandes puede tardar más",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("cargando fotos..."),
    "low": MessageLookupByLibrary.simpleMessage("baja"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("por khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "dimensión máxima",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "limitar el lado más largo de la imagen; los valores más pequeños ahorran más espacio",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("media"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("modo de metadatos"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "conservar la información EXIF y de la cámara cuando sea compatible, o eliminarla",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "no se pudieron copiar algunos metadatos de la galería",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("mis otras apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("mi sitio web"),
    "next": MessageLookupByLibrary.simpleMessage("siguiente"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "prueba otro modo: este no reducirá el tamaño",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "elige una o varias fotos. minimo trabaja con archivos locales y mantiene los originales intactos",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "escoger fotos",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "elija un ajuste preestablecido de calidad o ajuste las dimensiones y los metadatos manualmente",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "elige qué cambiar",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "La compresión ocurre en su dispositivo. las fotos no se cargan en ninguna parte; guarda la copia más pequeña cuando te guste el resultado",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "privado por defecto",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) es de código abierto. explora el código, sigue el proyecto o ponte en contacto",
    ),
    "original": MessageLookupByLibrary.simpleMessage("original"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "no se pudieron eliminar algunos originales",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("antes"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("formato de salida"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg funciona en todas partes; heic puede ser más pequeño pero puede volver a ser jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "la compresión puede ralentizarse si el dispositivo se calienta",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "vista previa no disponible",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "una mayor calidad mantiene más detalles y crea un archivo más grande",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "mantener detalles y dimensiones originales",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "archivos más pequeños para compartir",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "calidad y tamaño de archivo equilibrados",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "fotos comprimidas",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("desde archivos"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("desde la galería"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "mantener la pantalla encendida",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "evita que la pantalla entre en suspensión mientras las fotos se cargan o comprimen",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage(
      "sitio web del proyecto",
    ),
    "quality": MessageLookupByLibrary.simpleMessage("calidad"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "La calidad se reducirá para ahorrar espacio.",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("valorar la app"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "eliminar ubicación",
    ),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "eliminar la ubicación de las fotos guardadas y conservar los demás metadatos",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "reemplazar el original",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "guardar con metadatos originales, luego solicitar eliminar el original",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("dimensiones de la imagen"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "limitar el lado más largo de la imagen; dimensiones más pequeñas ahorran más espacio",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("resolución"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "reduce las dimensiones para ahorrar el máximo espacio",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "la resolución se reducirá a hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "la resolución se reducirá a sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("guardar"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("guardar como nuevo"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "conservar el original y guardar una nueva foto de la galería",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "guardar junto al original",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "conservar el original y copiar su fecha y metadatos",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("cómo guardar"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "guardar fotos en el álbum",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("guardado"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("ajustes"),
    "share": MessageLookupByLibrary.simpleMessage("compartir"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "compartir o guardar en…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "compartir con amigos",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "mostrar aviso de sobrecalentamiento",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "muestra un pequeño aviso durante la compresión si el dispositivo puede ralentizarse",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("simple"),
    "skip": MessageLookupByLibrary.simpleMessage("omitir"),
    "small": MessageLookupByLibrary.simpleMessage("pequeño"),
    "smaller": MessageLookupByLibrary.simpleMessage("menor"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("espacio ahorrado"),
    "statistics": MessageLookupByLibrary.simpleMessage("estadísticas"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "Las estadísticas se almacenan localmente en este dispositivo.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("eliminar metadatos"),
    "system": MessageLookupByLibrary.simpleMessage("sistema"),
    "todo": MessageLookupByLibrary.simpleMessage("todo"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("intentar de nuevo"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "¿Dejar y eliminar fotos comprimidas no guardadas?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "fotos no guardadas",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "haz videos más pequeños, directamente en tu teléfono",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("esperando"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
