// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(prefix) => "添加 \"${prefix}\" 前缀";

  static String m1(prefix) => "在原文件名前添加 \"${prefix}\"。关闭后保留原文件名";

  static String m2(version) => "${version} 新功能";

  static String m3(count) =>
      "${Intl.plural(count, one: '约剩 1 分钟', other: '约剩 ${count} 分钟')}";

  static String m4(current, total) => "${total} 的照片 ${current}";

  static String m5(completed, total) => "${completed} 的 ${total} 照片已压缩";

  static String m6(count) => "保存 ${count} 照片";

  static String m7(album) => "将压缩照片保存到 ${album} 相册而不是最近保存的";

  static String m8(error) => "照片已保存，但部分原件无法删除：${error}";

  static String m9(saved, deleted) => "已保存 ${saved} 照片并删除 ${deleted} 原件";

  static String m10(count) => "将 ${count} 照片保存到图库";

  static String m11(error) => "保存的照片存在一些问题：${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: '约剩 1 秒', other: '约剩 ${count} 秒')}";

  static String m13(url) => "尝试 minimo（照片）——一款用于在手机上缩小照片的简单应用程序：${url}";

  static String m14(size) => "已节省 ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo（照片）的诞生源于一次简单的挫折。\n\n该项目为每个人提供了一种方便且免费的方式，可以直接在移动设备上压缩照片，节省存储空间并保留重要时刻。",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("高级"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage("没有有用的储蓄"),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "这些设置并没有将文件减少至少 10%。尝试较低的质量或尺寸。",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("自动"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "保持 minimo 打开直到压缩完成。如果您离开，您的手机可能会暂停该应用程序",
    ),
    "better": MessageLookupByLibrary.simpleMessage("更好"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage("无法清除缓存"),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("缓存已清除"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("知道了"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage("你尚未查看的更新内容"),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("清除缓存"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "删除临时应用程序文件。保存到图库的照片保持不变",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("比较"),
    "compress": MessageLookupByLibrary.simpleMessage("压缩"),
    "compressed": MessageLookupByLibrary.simpleMessage("已压缩"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("之后"),
    "compressing": MessageLookupByLibrary.simpleMessage("正在压缩..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage("压缩已取消"),
    "compressionComplete": MessageLookupByLibrary.simpleMessage("压缩完成"),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage("压缩已完成"),
    "compressionFailed": MessageLookupByLibrary.simpleMessage("压缩失败"),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "我们无法压缩这张照片。再试一次或选择另一个。",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage("使用深色外观"),
    "detailLevel": MessageLookupByLibrary.simpleMessage("照片质量"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "设置目标质量或让质量预设选择它",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("邮箱已复制"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "正在估算剩余时间...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("失败"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage("选择照片文件"),
    "failedToSave": MessageLookupByLibrary.simpleMessage("无法保存照片。再试一次"),
    "failedToShare": MessageLookupByLibrary.simpleMessage("无法分享照片。再试一次"),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic 不可用，因此这张照片保存为 jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("开始"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("github 仓库"),
    "good": MessageLookupByLibrary.simpleMessage("较好"),
    "high": MessageLookupByLibrary.simpleMessage("高"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage("长按按钮取消压缩"),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage("长按按钮清除缓存"),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage("长按按钮删除原照片"),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo 制作照片的新副本并更有效地存储它。它可以降低图像质量或尺寸，同时保持结果有用。\n\n质量较低的存储较少难以注意到的微小细节。较小的尺寸使用较少的像素。两者都减少了文件大小。\n\n您的原始照片保持不变，并在您的设备上进行压缩。",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage("照片怎么变小"),
    "keepExif": MessageLookupByLibrary.simpleMessage("保留 exif 元数据"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("元数据"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "支持时保留相机和 Exif 信息",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage("保留元数据"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "languageDescription": MessageLookupByLibrary.simpleMessage("选择应用语言"),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "从云存储下载或复制大文件可能需要更长时间",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("加载照片..."),
    "low": MessageLookupByLibrary.simpleMessage("低"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("khlebobul 制作"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("最大尺寸"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "限制最长图像边；较小的值可节省更多空间",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("中"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("元数据模式"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "在支持时保留相机和 EXIF 信息，或将其删除",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "部分图库元数据无法复制",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("我的其他应用"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("我的网站"),
    "next": MessageLookupByLibrary.simpleMessage("下一步"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "请尝试其他模式 — 此模式不会缩小文件",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "选择一张或多张照片。 minimo 使用本地文件并保持原始文件不变",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("选择照片"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "选择质量预设或手动调整尺寸和元数据",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage("选择要更改的内容"),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "压缩发生在您的设备上。照片没有上传到任何地方；当您喜欢结果时，保存较小的副本",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage("默认保护隐私"),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo（照片）是开源的。探索代码、关注项目或取得联系",
    ),
    "original": MessageLookupByLibrary.simpleMessage("原始"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage("部分原照片无法删除"),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("之前"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("输出格式"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg 随处可用； heic 可以更小，但可能会回退到 jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage("设备发热时，压缩可能变慢"),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage("预览不可用"),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "更高的质量保留更多细节并创建更大的文件",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "保留细节和原始尺寸",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "用于共享的较小文件",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "平衡的质量和文件大小",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage("照片压缩"),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("从文件选择"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("从图库选择"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage("保持屏幕亮起"),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "防止屏幕在加载或压缩照片时休眠",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("项目网站"),
    "quality": MessageLookupByLibrary.simpleMessage("质量"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "将降低质量以节省空间",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("为应用评分"),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("替换原照片"),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "保留原始元数据并保存，然后询问是否删除原照片",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("图像尺寸"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "限制最长图像边；尺寸更小，节省更多空间",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("分辨率"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "降低尺寸可最大幅度节省空间",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "分辨率将降低到 hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "分辨率将降低到 sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("另存为新照片"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "保留原始照片并保存新的图库照片",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage("保存在原照片旁"),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "保留原照片，并复制其拍摄日期和元数据",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("保存方式"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage("将照片保存到相册"),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("已保存"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "share": MessageLookupByLibrary.simpleMessage("分享"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("分享或保存到…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage("分享给朋友"),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage("显示过热警告"),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "设备可能因发热变慢时，在压缩期间显示小提示",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("简单"),
    "skip": MessageLookupByLibrary.simpleMessage("跳过"),
    "small": MessageLookupByLibrary.simpleMessage("小"),
    "smaller": MessageLookupByLibrary.simpleMessage("更小"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("已节省空间"),
    "statistics": MessageLookupByLibrary.simpleMessage("统计"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "统计信息存储在该设备本地。",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("剥离元数据"),
    "system": MessageLookupByLibrary.simpleMessage("跟随系统"),
    "todo": MessageLookupByLibrary.simpleMessage("待办事项"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("重试"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "离开并丢弃未保存的压缩照片？",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage("未保存的照片"),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage("直接在手机上缩小视频"),
    "waiting": MessageLookupByLibrary.simpleMessage("等待中"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
