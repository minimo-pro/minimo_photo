// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(prefix) => "\"${prefix}\"接頭辞を追加";

  static String m1(prefix) => "元のファイル名の前に\"${prefix}\"を追加します。オフにすると元の名前を保持します";

  static String m2(version) => "${version}の新機能";

  static String m3(count) =>
      "${Intl.plural(count, one: '残り約1分', other: '残り約${count}分')}";

  static String m4(current, total) => "${total}の写真${current}";

  static String m5(completed, total) => "${total} 枚中 ${completed} 枚の写真を圧縮";

  static String m6(count) => "${count}写真を保存";

  static String m7(album) => "圧縮された写真を最近保存したものではなく、${album} アルバムに保存します";

  static String m8(error) => "写真は保存されましたが、一部のオリジナルは削除できませんでした: ${error}";

  static String m9(saved, deleted) =>
      "${saved} 個の写真を保存し、${deleted} 個のオリジナルを削除しました";

  static String m10(count) => "${count} の写真をギャラリーに保存しました";

  static String m11(error) => "いくつかの問題を抱えて保存された写真: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: '残り約1秒', other: '残り約${count}秒')}";

  static String m13(url) =>
      "minimo (写真) を試してください — 携帯電話で写真を小さくするためのシンプルなアプリ: ${url}";

  static String m14(size) => "${size}節約しました";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("このアプリについて"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo（写真）は、単純な不満から生まれました。\n\nこのプロジェクトは、モバイル デバイス上で写真を直接圧縮し、ストレージを節約し、重要な瞬間を保存するための便利で無料の方法を誰にでも提供します。",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("詳細"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage("有益な貯蓄がない"),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "これらの設定では、ファイルは少なくとも 10% 削減されませんでした。低品質または低サイズを試してください。",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("自動"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "圧縮が完了するまで minimo を開いたままにしてください。切り替えると携帯電話がアプリを一時停止する可能性があります",
    ),
    "better": MessageLookupByLibrary.simpleMessage("高品質"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage("キャッシュを消去できません"),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("キャッシュを消去しました"),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("了解"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage("まだ確認していない更新内容"),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("キャッシュを消去"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "アプリの一時ファイルを削除します。ギャラリーに保存された写真はそのまま残ります",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("比較する"),
    "compress": MessageLookupByLibrary.simpleMessage("圧縮"),
    "compressed": MessageLookupByLibrary.simpleMessage("圧縮済み"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("その後"),
    "compressing": MessageLookupByLibrary.simpleMessage("圧縮中..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "圧縮をキャンセルしました",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage("圧縮完了"),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage("圧縮が完了しました"),
    "compressionFailed": MessageLookupByLibrary.simpleMessage("圧縮に失敗しました"),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "この写真は圧縮できませんでした。もう一度試すか、別のものを選択してください。",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("ダークテーマ"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage("暗い外観を使用"),
    "detailLevel": MessageLookupByLibrary.simpleMessage("写真の品質"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "目標品質を設定するか、品質プリセットで選択させます",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("メールアドレスをコピーしました"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "残り時間を計算中...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("失敗"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "写真ファイルを選択してください",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "写真を保存できませんでした。もう一度試してください",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "写真を共有できませんでした。もう一度試してください",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic が利用できなかったので、この写真は jpeg で保存されました",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("始める"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("githubリポジトリ"),
    "good": MessageLookupByLibrary.simpleMessage("良好"),
    "high": MessageLookupByLibrary.simpleMessage("高"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "ボタンを長押しして圧縮をキャンセル",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "ボタンを長押ししてキャッシュを消去",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "ボタンを長押しして元の写真を削除",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo は写真の新しいコピーを作成し、より効率的に保存します。有用な結果を維持しながら、画質やサイズを下げることができます。\n\n低品質では、気づきにくい小さな詳細があまり保存されません。寸法が小さいほど、使用するピクセルが少なくなります。どちらもファイルサイズを削減します。\n\n元の写真は変更されず、デバイス上で圧縮が行われます。",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "写真が小さくなる仕組み",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("exifメタデータを保持する"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("メタデータ"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "サポートされている場合はカメラと exif 情報を保持します",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage("メタデータを保持する"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "languageDescription": MessageLookupByLibrary.simpleMessage("アプリの言語を選択"),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "クラウド ストレージからのダウンロードや大きなファイルのコピーには時間がかかる場合があります",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("写真を読み込んでいます..."),
    "low": MessageLookupByLibrary.simpleMessage("低"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("khlebobul 作"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("最大寸法"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "画像の最長辺を制限します。値を小さくすると、より多くのスペースを節約できます",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("中"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("メタデータモード"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "サポートされている場合はカメラと EXIF 情報を保持するか、削除します",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "一部のギャラリーメタデータをコピーできませんでした",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("その他のアプリ"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("私のサイト"),
    "next": MessageLookupByLibrary.simpleMessage("次へ"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "別のモードをお試しください — これでは小さくなりません",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "1 つまたは複数の写真を選択します。 minimo はローカル ファイルを操作し、オリジナルをそのまま保持します",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("写真を選ぶ"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "品質プリセットを選択するか、寸法とメタデータを手動で調整します",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage("変更内容を選択"),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "圧縮はデバイス上で行われます。写真はどこにもアップロードされません。結果が気に入ったら、小さいコピーを保存します",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage("プライバシーを優先"),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (写真) はオープンソースです。コードを探索したり、プロジェクトをフォローしたり、連絡したりする",
    ),
    "original": MessageLookupByLibrary.simpleMessage("オリジナル"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "一部の元の写真を削除できませんでした",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("前に"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("出力形式"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg はどこでも機能します。 heic の方が小さくなる可能性がありますが、jpeg に戻る可能性があります",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "デバイスが熱くなると圧縮が遅くなることがあります",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "プレビューは利用できません",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "品質が高いほど、より多くの詳細が保持され、より大きなファイルが作成されます",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "ディテールと元の寸法を維持する",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "共有用の小さいファイル",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "バランスの取れた品質とファイルサイズ",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage("圧縮された写真"),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("ファイルから"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("ギャラリーから"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage("画面をオンのままにする"),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "写真の読み込み中または圧縮中に画面がスリープ状態になるのを防ぎます",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("プロジェクトサイト"),
    "quality": MessageLookupByLibrary.simpleMessage("画質"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "スペースを節約するために品質が低下します",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("アプリを評価"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("位置情報を削除"),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "他のメタデータを残して保存する写真から位置情報を削除",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("元の写真を置き換え"),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "元のメタデータを引き継いで保存し、元の写真を削除するか確認します",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("画像の寸法"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "画像の最長辺を制限します。より小さな寸法でより多くのスペースを節約",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("解像度"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "寸法を下げると容量を最も節約できます",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "解像度をhdに下げます",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "解像度をsdに下げます",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("新規保存"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "オリジナルを保持し、新しいギャラリー写真を保存します",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage("元の写真の隣に保存"),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "元の写真を残し、撮影日とメタデータをコピーします",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("保存方法"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage("写真をアルバムに保存する"),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("保存済み"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "share": MessageLookupByLibrary.simpleMessage("共有"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("共有または保存先…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage("友達と共有"),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage("過熱警告を表示"),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "デバイスが遅くなる可能性があるときに小さなバナーを表示します",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("シンプル"),
    "skip": MessageLookupByLibrary.simpleMessage("スキップ"),
    "small": MessageLookupByLibrary.simpleMessage("小"),
    "smaller": MessageLookupByLibrary.simpleMessage("小さい"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("節約した容量"),
    "statistics": MessageLookupByLibrary.simpleMessage("統計"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "統計情報はこのデバイスにローカルに保存されます。",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("メタデータを削除する"),
    "system": MessageLookupByLibrary.simpleMessage("システム"),
    "todo": MessageLookupByLibrary.simpleMessage("やるべきこと"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("再試行"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "終了して、未保存の圧縮写真を破棄しますか？",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage("保存されていない写真"),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "携帯電話で直接ビデオを小さくする",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("待機中"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
