// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(prefix) => "add \"${prefix}\" prefix";

  static String m1(prefix) =>
      "adds \"${prefix}\" before the original file name. disabling keeps the original file name";

  static String m2(version) => "what\'s new in ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'about 1 minute left', other: 'about ${count} minutes left')}";

  static String m4(current, total) => "photo ${current} of ${total}";

  static String m5(completed, total) =>
      "${completed} of ${total} photos compressed";

  static String m6(count) =>
      "${Intl.plural(count, one: 'save 1 photo', other: 'save ${count} photos')}";

  static String m7(album) =>
      "saves compressed photos to the ${album} album instead of recently saved";

  static String m8(error) =>
      "photos saved, but some originals could not be deleted: ${error}";

  static String m9(saved, deleted) =>
      "saved ${saved} photo(s) and deleted ${deleted} original(s)";

  static String m10(count) =>
      "${Intl.plural(count, one: 'saved 1 photo to gallery', other: 'saved ${count} photos to gallery')}";

  static String m11(error) => "photos saved with some issues: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'about 1 second left', other: 'about ${count} seconds left')}";

  static String m13(url) =>
      "try minimo (photo) — a simple app for making photos smaller on your phone: ${url}";

  static String m14(size) => "you saved ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("about"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) was born from a simple frustration.\n\nthis project gives everyone a convenient and free way to compress photos directly on a mobile device, save storage and keep the moments that matter.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("advanced"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "no useful savings",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "these settings did not reduce the file by at least 10%. try lower quality or dimensions.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "better": MessageLookupByLibrary.simpleMessage("better"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "failed to clear cache",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache cleared"),
    "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("got it"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "changes from updates you have not seen yet",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("clear cache"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "removes temporary app files. photos saved to your gallery remain untouched",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("compare"),
    "compress": MessageLookupByLibrary.simpleMessage("compress"),
    "compressed": MessageLookupByLibrary.simpleMessage("compressed"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("after"),
    "compressing": MessageLookupByLibrary.simpleMessage("compressing..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compression cancelled",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compression complete",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compression completed",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "compression failed",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "we couldn\'t compress this photo. try again or choose another one.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("dark theme"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "use the dark appearance",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("photo quality"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "set a target quality or let the quality preset choose it",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("email copied"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "estimating time remaining...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("failed"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "choose a photo file",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "couldn\'t save the photos. try again",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "couldn\'t share the photos. try again",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic wasn\'t available, so this photo was saved as jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("get started"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "github repository",
    ),
    "good": MessageLookupByLibrary.simpleMessage("good"),
    "high": MessageLookupByLibrary.simpleMessage("high"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "hold the button to cancel compression",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "hold the button to clear cache",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "hold the button to delete originals",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo makes a new copy of your photo and stores it more efficiently. it can reduce image quality or dimensions while keeping the result useful.\n\nlower quality stores fewer tiny details that are hard to notice. smaller dimensions use fewer pixels. both reduce file size.\n\nyour original photo stays untouched, and compression happens on your device.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "how photo gets smaller",
    ),
    "iosBackgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "keep minimo open during compression. if you leave, the current photo restarts when you return",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("keep exif metadata"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("metadata"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "preserve camera and exif information when supported",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage("keep metadata"),
    "language": MessageLookupByLibrary.simpleMessage("language"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "select the language for the app",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "downloading from cloud storage or copying large files may take longer",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("loading photos..."),
    "low": MessageLookupByLibrary.simpleMessage("low"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("by khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "maximum dimension",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "limit the longest image side; smaller values save more space",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("medium"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("metadatamode"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "keep the original audio or strip it to save more space",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "some gallery metadata could not be copied",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("my other apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("my website"),
    "next": MessageLookupByLibrary.simpleMessage("next"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "try another mode — this won\'t make it smaller",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "choose one or several photos. minimo works with local files and keeps the originals untouched",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("pick photos"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "choose a quality preset or adjust dimensions and metadata manually",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "choose what changes",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "compression happens on your device. photos are not uploaded anywhere; save the smaller copy when you like the result",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "private by default",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) is open source. explore the code, follow the project or get in touch",
    ),
    "original": MessageLookupByLibrary.simpleMessage("original"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "some originals could not be deleted",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("before"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("outputformat"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg works everywhere; heic can be smaller but may fall back to jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "compression can slow down if your device gets hot",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "preview unavailable",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "higher quality keeps more detail and creates a larger file",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "keep detail and original dimensions",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "smaller files for sharing",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "balanced quality and file size",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "photos compressed",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("from files"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("from gallery"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "keep screen awake",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "prevents the screen from sleeping while photos are compressing",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("project website"),
    "quality": MessageLookupByLibrary.simpleMessage("quality"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "quality will be reduced to save space",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("rate the app"),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("replace original"),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "save with original metadata, then ask to delete the original",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("image dimensions"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "limit output frames per second; higher source rates are left unchanged",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("resolution"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "reduce dimensions for the biggest size savings",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "resolution will be reduced to hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "resolution will be reduced to sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("save"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("save as new"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "keep the original and save a new gallery photo",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "save beside original",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "keep the original and copy its gallery date and metadata",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("how to save"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "save photos to album",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("saved"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("settings"),
    "share": MessageLookupByLibrary.simpleMessage("share"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("share or save to…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "share with friends",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "show overheat warning",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "shows a small banner during compression when the device may slow down",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("simple"),
    "skip": MessageLookupByLibrary.simpleMessage("skip"),
    "small": MessageLookupByLibrary.simpleMessage("small"),
    "smaller": MessageLookupByLibrary.simpleMessage("smaller"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("space saved"),
    "statistics": MessageLookupByLibrary.simpleMessage("statistics"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "statistics are stored locally on this device.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("strip metadata"),
    "system": MessageLookupByLibrary.simpleMessage("system"),
    "todo": MessageLookupByLibrary.simpleMessage("todo"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("try again"),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "make videos smaller, right on your phone",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("waiting"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
