// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(prefix) => "\"${prefix}\" önekini ekle";

  static String m1(prefix) =>
      "orijinal dosya adının önüne \"${prefix}\" ekler. kapatıldığında orijinal ad korunur";

  static String m2(version) => "${version} sürümündeki yenilikler";

  static String m3(count) =>
      "${Intl.plural(count, one: 'yaklaşık 1 dakika kaldı', other: 'yaklaşık ${count} dakika kaldı')}";

  static String m4(current, total) => "${total}\'nin ${current} fotoğrafı";

  static String m5(completed, total) =>
      "${total} fotoğraflarından ${completed} sıkıştırılmış";

  static String m6(count) => "${count} fotoğraflarını kaydet";

  static String m7(album) =>
      "sıkıştırılmış fotoğrafları yakın zamanda kaydedilenler yerine ${album} albümüne kaydeder";

  static String m8(error) =>
      "fotoğraflar kaydedildi ancak bazı orijinaller silinemedi: ${error}";

  static String m9(saved, deleted) =>
      "kaydedilen ${saved} fotoğraf(lar)ı ve silinen ${deleted} orijinal(ler)i";

  static String m10(count) => "${count} fotoğrafları galeriye kaydedildi";

  static String m11(error) =>
      "bazı sorunlarla kaydedilen fotoğraflar: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'yaklaşık 1 saniye kaldı', other: 'yaklaşık ${count} saniye kaldı')}";

  static String m13(url) =>
      "telefonunuzda fotoğrafları küçültmek için basit bir uygulama olan minimo\'yu (photo) deneyin: ${url}";

  static String m14(size) => "${size} tasarruf ettin";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("hakkında"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (fotoğraf) basit bir hayal kırıklığından doğdu.\n\nBu proje herkese fotoğrafları doğrudan mobil cihazda sıkıştırmanın, depolama alanından tasarruf etmenin ve önemli anları saklamanın kolay ve ücretsiz bir yolunu sunuyor.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("gelişmiş"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "yararlı tasarruf yok",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "bu ayarlar dosyayı en az %10 oranında azaltmadı. daha düşük kaliteyi veya boyutları deneyin.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("otomatik"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "Sıkıştırma bitene kadar minimo\'yu açık tutun. geçiş yaparsanız telefonunuz uygulamayı duraklatabilir",
    ),
    "better": MessageLookupByLibrary.simpleMessage("daha iyi"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "önbellek temizlenemedi",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("önbellek temizlendi"),
    "cancel": MessageLookupByLibrary.simpleMessage("iptal"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("anladım"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "henüz görmediğin güncellemelerdeki değişiklikler",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("önbelleği temizle"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "geçici uygulama dosyalarını kaldırır. galerinize kaydedilen fotoğraflara dokunulmaz",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("karşılaştırmak"),
    "compress": MessageLookupByLibrary.simpleMessage("sıkıştır"),
    "compressed": MessageLookupByLibrary.simpleMessage("sıkıştırılmış"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("sonra"),
    "compressing": MessageLookupByLibrary.simpleMessage("sıkıştırılıyor..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "sıkıştırma iptal edildi",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "sıkıştırma tamamlandı",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "sıkıştırma tamamlandı",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "sıkıştırma başarısız",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "bu fotoğrafı sıkıştıramadık. tekrar deneyin veya başka bir tane seçin.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("koyu tema"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "koyu görünümü kullan",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("fotoğraf kalitesi"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "bir hedef kalite belirleyin veya kalite ön ayarının bunu seçmesine izin verin",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("e-posta kopyalandı"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "kalan süre hesaplanıyor...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("başarısız"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "bir fotoğraf dosyası seç",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "fotoğraflar kaydedilemedi. tekrar dene",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "fotoğrafları paylaşamadım. tekrar dene",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic mevcut olmadığından bu fotoğraf jpeg olarak kaydedildi",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("başla"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("github deposu"),
    "good": MessageLookupByLibrary.simpleMessage("iyi"),
    "high": MessageLookupByLibrary.simpleMessage("yüksek"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "sıkıştırmayı iptal etmek için düğmeyi basılı tut",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "önbelleği temizlemek için düğmeyi basılı tut",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "orijinalleri silmek için düğmeyi basılı tut",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo, fotoğrafınızın yeni bir kopyasını oluşturur ve onu daha verimli bir şekilde saklar. sonucu faydalı tutarken görüntü kalitesini veya boyutlarını azaltabilir.\n\ndüşük kalite, fark edilmesi zor olan daha az küçük ayrıntıyı depolar. daha küçük boyutlar daha az piksel kullanır. her ikisi de dosya boyutunu azaltır.\n\norijinal fotoğrafınıza dokunulmaz ve cihazınızda sıkıştırma gerçekleşir.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "fotoğraf nasıl küçülür",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage(
      "exif meta verilerini sakla",
    ),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("meta veri"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "desteklendiğinde kamera ve exif bilgilerini koruyun",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "meta verileri sakla",
    ),
    "language": MessageLookupByLibrary.simpleMessage("dil"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "uygulamanın dilini seç",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "bulut depolama alanından indirme veya büyük dosyaları kopyalama daha uzun sürebilir",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "fotoğraflar yükleniyor...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("düşük"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage(
      "khlebobul tarafından",
    ),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("maksimum boyut"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "en uzun görüntü tarafını sınırlayın; daha küçük değerler daha fazla yerden tasarruf sağlar",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("orta"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("meta veri modu"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "Desteklendiğinde kamera ve EXIF bilgilerini saklayın veya kaldırın",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "bazı galeri meta verileri kopyalanamadı",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("diğer uygulamalarım"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("web sitem"),
    "next": MessageLookupByLibrary.simpleMessage("ileri"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "başka bir mod dene — bu seçenek boyutu küçültmeyecek",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "bir veya daha fazla fotoğraf seçin. minimo yerel dosyalarla çalışır ve orijinallere dokunulmaz",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("fotoğraf seç"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "bir kalite ön ayarı seçin veya boyutları ve meta verileri manuel olarak ayarlayın",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "neyin değişeceğini seç",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "cihazınızda sıkıştırma gerçekleşir. fotoğraflar hiçbir yere yüklenmez; sonucu beğendiğinizde küçük kopyayı kaydedin",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "varsayılan olarak gizli",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (fotoğraf) açık kaynaktır. Kodu inceleyin, projeyi takip edin veya iletişime geçin",
    ),
    "original": MessageLookupByLibrary.simpleMessage("orijinal"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "bazı orijinaller silinemedi",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("önce"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("çıktı formatı"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg her yerde çalışır; heic daha küçük olabilir ancak jpeg\'e geri dönebilir",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "cihazın ısınırsa sıkıştırma yavaşlayabilir",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "önizleme kullanılamıyor",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "daha yüksek kalite daha fazla ayrıntıyı korur ve daha büyük bir dosya oluşturur",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "ayrıntıları ve orijinal boyutları koruyun",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "paylaşım için daha küçük dosyalar",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "dengeli kalite ve dosya boyutu",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "fotoğraflar sıkıştırılmış",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("dosyalardan"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("galeriden"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "ekranı açık tut",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "fotoğraflar yüklenirken veya sıkıştırılırken ekranın uyku moduna geçmesini önler",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("proje web sitesi"),
    "quality": MessageLookupByLibrary.simpleMessage("kalite"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "yerden tasarruf etmek için kalite düşürülecek",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage(
      "uygulamayı değerlendir",
    ),
    "removeLocation": MessageLookupByLibrary.simpleMessage("konumu kaldır"),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "diğer meta verileri koruyarak kaydedilen fotoğraflardan konumu kaldır",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "orijinali değiştir",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "orijinal meta verilerle kaydedin, ardından orijinalin silinmesini isteyin",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("görüntü boyutları"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "en uzun görüntü tarafını sınırlayın; daha küçük boyutlar daha fazla yerden tasarruf sağlar",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("çözünürlük"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "en fazla alan tasarrufu için boyutları azalt",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "çözünürlük hd\'ye düşürülecek",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "çözünürlük sd\'ye düşürülecek",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("kaydet"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("yeni olarak kaydet"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "orijinali saklayın ve yeni bir galeri fotoğrafı kaydedin",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "orijinalin yanına kaydet",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "orijinali koru, tarihini ve meta verilerini kopyala",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage(
      "nasıl kaydedilsin",
    ),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "fotoğrafları albüme kaydet",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("kaydedildi"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("ayarlar"),
    "share": MessageLookupByLibrary.simpleMessage("paylaş"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "paylaş veya şuraya kaydet…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "arkadaşlarla paylaş",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "aşırı ısınma uyarısını göster",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "cihaz yavaşlayabileceğinde sıkıştırma sırasında küçük bir bildirim gösterir",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("basit"),
    "skip": MessageLookupByLibrary.simpleMessage("atla"),
    "small": MessageLookupByLibrary.simpleMessage("küçük"),
    "smaller": MessageLookupByLibrary.simpleMessage("daha küçük"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("kazanılan alan"),
    "statistics": MessageLookupByLibrary.simpleMessage("istatistikler"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "istatistikler bu cihazda yerel olarak depolanır.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage(
      "meta verileri şeritle",
    ),
    "system": MessageLookupByLibrary.simpleMessage("sistem"),
    "todo": MessageLookupByLibrary.simpleMessage("yapılacak"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("tekrar dene"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "kaydedilmemiş sıkıştırılmış fotoğrafları bırakıp silmek mi istiyorsunuz?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "kaydedilmemiş fotoğraflar",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "videoları doğrudan telefonunuzda küçültün",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("bekliyor"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
