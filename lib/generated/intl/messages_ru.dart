// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(prefix) => "добавлять префикс \"${prefix}\"";

  static String m1(prefix) =>
      "добавляет \"${prefix}\" перед исходным именем файла. если выключить, имя останется исходным";

  static String m2(version) => "что нового в ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'осталась примерно 1 минута', few: 'осталось примерно ${count} минуты', many: 'осталось примерно ${count} минут', other: 'осталось примерно ${count} минуты')}";

  static String m4(current, total) => "фото ${current} из ${total}";

  static String m5(completed, total) => "сжато фото: ${completed} из ${total}";

  static String m6(count) =>
      "${Intl.plural(count, one: 'сохранить 1 фото', few: 'сохранить ${count} фото', many: 'сохранить ${count} фото', other: 'сохранить ${count} фото')}";

  static String m7(album) =>
      "сохраняет сжатые фото в альбом ${album} вместо недавних сохранений";

  static String m8(error) =>
      "фото сохранены, но некоторые оригиналы удалить не удалось: ${error}";

  static String m9(saved, deleted) =>
      "сохранено фото: ${saved}, удалено оригиналов: ${deleted}";

  static String m10(count) =>
      "${Intl.plural(count, one: '1 фото сохранено в галерею', few: '${count} фото сохранено в галерею', many: '${count} фото сохранено в галерею', other: '${count} фото сохранено в галерею')}";

  static String m11(error) => "фото сохранены с замечаниями: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'осталась примерно 1 секунда', few: 'осталось примерно ${count} секунды', many: 'осталось примерно ${count} секунд', other: 'осталось примерно ${count} секунды')}";

  static String m13(url) =>
      "попробуй minimo (photo) — простое приложение, чтобы сжимать фото прямо на телефоне: ${url}";

  static String m14(size) => "экономия ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("о приложении"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) появился из простой проблемы.\n\nэтот проект даёт каждому удобную и бесплатную возможность сжимать фото прямо на мобильном устройстве, экономить память и сохранять важные моменты.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("расширенный"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "уже оптимизировано",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "это фото уже маленькое. попробуйте снизить качество или выберите другое фото.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("авто"),
    "better": MessageLookupByLibrary.simpleMessage("лучше"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "не удалось очистить кеш",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("кеш очищен"),
    "cancel": MessageLookupByLibrary.simpleMessage("отмена"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("понятно"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "изменения из обновлений, которые вы ещё не видели",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("очистка кеша"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "удаляет временные файлы приложения. фото в галерее останутся",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("сравнить"),
    "compress": MessageLookupByLibrary.simpleMessage("сжать"),
    "compressed": MessageLookupByLibrary.simpleMessage("сжатое"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("стало"),
    "compressing": MessageLookupByLibrary.simpleMessage("сжатие..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "сжатие отменено",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "сжатие завершено",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "сжатие завершено",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "не удалось сжать фото",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "попробуйте ещё раз или выберите другое фото.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("темная тема"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "использовать темное оформление",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("качество фото"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "задайте целевой качество или доверьте выбор профилю качества",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("почта скопирована"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "оцениваем оставшееся время...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("ошибка"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "выберите фотографию",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "не удалось сохранить фото. попробуйте ещё раз",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "не удалось поделиться фото. попробуйте ещё раз",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic недоступен — фото сохранено в jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("начать"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "репозиторий github",
    ),
    "good": MessageLookupByLibrary.simpleMessage("хорошее"),
    "high": MessageLookupByLibrary.simpleMessage("высокое"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "удерживайте кнопку, чтобы отменить сжатие",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "удерживайте кнопку, чтобы очистить кеш",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "удерживайте кнопку, чтобы удалить оригиналы",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo создаёт новую копию фото и сохраняет её компактнее. приложение может снизить качество изображения или уменьшить его размеры.\n\nпри меньшем качестве сохраняется меньше мелких деталей, которые обычно сложно заметить. меньшее разрешение означает меньше пикселей. так файл занимает меньше места.\n\nоригинал не меняется, а сжатие происходит на вашем устройстве.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "за счёт чего фото становится меньше",
    ),
    "iosBackgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "не сворачивайте minimo во время сжатия. иначе текущий фото начнёт сжиматься заново после возвращения",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("сохранять exif"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("метаданные"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "сохранять данные камеры и exif, когда формат это поддерживает",
    ),
    "language": MessageLookupByLibrary.simpleMessage("язык"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "выберите язык приложения",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "загрузка большого количества или крупных файлов может занять больше времени",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("загрузка фото..."),
    "low": MessageLookupByLibrary.simpleMessage("низкое"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("by khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage(
      "максимальная сторона",
    ),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "ограничьте длинную сторону изображения для меньшего файла",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("среднее"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("звук"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "сохраните исходный звук или удалите его для меньшего размера",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "некоторые метаданные галереи перенести не удалось",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage(
      "другие мои приложения",
    ),
    "myWebsite": MessageLookupByLibrary.simpleMessage("мой сайт"),
    "next": MessageLookupByLibrary.simpleMessage("далее"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "попробуйте другой режим — размер почти не изменится",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "выберите одно или несколько фото. minimo работает с локальными файлами и не трогает оригиналы",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "выберите фото",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "выберите готовый уровень качества или настройте размер и метаданные вручную",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "выберите, что менять",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "сжатие происходит на устройстве. фото никуда не загружаются; сохраните меньшую копию, когда результат устроит",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "приватно по умолчанию",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (photo) — проект с открытым исходным кодом. посмотрите код, следите за проектом или свяжитесь со мной",
    ),
    "original": MessageLookupByLibrary.simpleMessage("оригинал"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "некоторые оригиналы удалить не удалось",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("было"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("кодек"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg совместим везде; heic может быть компактнее, но иногда заменяется на jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "сжатие может замедлиться, если устройство нагреется",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "предпросмотр недоступен",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "чем выше качество, тем больше деталей и размер файла",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "сохранить детали и исходное разрешение",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "маленькие файлы для отправки",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "баланс качества и размера файла",
    ),
    "photosCompressed": m5,
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("из файлов"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("из галереи"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "не выключать экран",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "не даёт экрану уснуть, пока фото сжимаются",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("сайт проекта"),
    "quality": MessageLookupByLibrary.simpleMessage("качество"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "качество будет уменьшен для экономии места",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("оценить приложение"),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "заменить оригинал",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "сохранить с метаданными, затем запросить удаление оригинала",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("размер изображения"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "ограничивает число кадров в секунду; меньшая частота источника не повышается",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("разрешение"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "уменьшение разрешения сильнее всего сокращает размер",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "разрешение будет уменьшено до hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "разрешение будет уменьшено до sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("сохранить"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("сохранить как новое"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "оставить оригинал и сохранить новое фото в галерею",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "сохранить рядом с оригиналом",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "оставить оригинал и перенести его дату и метаданные",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("как сохранить"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "сохранять фото в альбом",
    ),
    "savePhotosToAlbumDescription": m7,
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("настройки"),
    "share": MessageLookupByLibrary.simpleMessage("поделиться"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "поделиться или сохранить в…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "поделиться с друзьями",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "показывать предупреждение о перегреве",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "показывает небольшой баннер во время сжатия, когда устройство может замедлиться",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("простой"),
    "skip": MessageLookupByLibrary.simpleMessage("пропустить"),
    "small": MessageLookupByLibrary.simpleMessage("маленький"),
    "smaller": MessageLookupByLibrary.simpleMessage("меньше"),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("без метаданных"),
    "system": MessageLookupByLibrary.simpleMessage("система"),
    "todo": MessageLookupByLibrary.simpleMessage("в разработке"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("попробовать снова"),
    "waiting": MessageLookupByLibrary.simpleMessage("ожидает"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
