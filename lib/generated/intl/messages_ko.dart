// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(prefix) => "\"${prefix}\" 접두사 추가";

  static String m1(prefix) =>
      "원본 파일 이름 앞에 \"${prefix}\"를 추가합니다. 끄면 원본 이름을 유지합니다";

  static String m2(version) => "${version} 새 기능";

  static String m3(count) =>
      "${Intl.plural(count, one: '약 1분 남음', other: '약 ${count}분 남음')}";

  static String m4(current, total) => "${total}의 사진 ${current}";

  static String m5(completed, total) => "${total} 사진 중 ${completed} 압축";

  static String m6(count) => "${count} 사진 저장";

  static String m7(album) => "최근에 저장한 사진 대신 압축된 사진을 ${album} 앨범에 저장합니다.";

  static String m8(error) => "사진이 저장되었으나 일부 원본을 삭제할 수 없음: ${error}";

  static String m9(saved, deleted) =>
      "${saved} 사진을 저장하고 ${deleted} 원본을 삭제했습니다.";

  static String m10(count) => "${count} 사진을 갤러리에 저장했습니다.";

  static String m11(error) => "몇 가지 문제로 저장된 사진: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: '약 1초 남음', other: '약 ${count}초 남음')}";

  static String m13(url) =>
      "minimo(photo)를 사용해 보세요 — 휴대폰에서 사진을 더 작게 만들 수 있는 간단한 앱: ${url}";

  static String m14(size) => "${size} 절약";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("앱 정보"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo(사진)는 단순한 좌절감에서 탄생했습니다.\n\n이 프로젝트는 모든 사람에게 모바일 장치에서 직접 사진을 압축하고 저장 공간을 절약하며 중요한 순간을 보관할 수 있는 편리하고 자유로운 방법을 제공합니다.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("고급"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage("쓸모없는 저축"),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "이러한 설정은 파일을 10% 이상 줄이지 않았습니다. 품질이나 크기를 낮추어 보세요.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("자동"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "압축이 끝날 때까지 minimo를 열어 두십시오. 다른 곳으로 전환하면 휴대전화에서 앱이 일시중지될 수 있습니다.",
    ),
    "better": MessageLookupByLibrary.simpleMessage("더 좋게"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage("캐시를 지울 수 없습니다"),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("캐시 지워짐"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("확인"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "아직 확인하지 않은 업데이트 내용",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("캐시 지우기"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "임시 앱 파일을 제거합니다. 갤러리에 저장된 사진은 그대로 유지됩니다.",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("비교하다"),
    "compress": MessageLookupByLibrary.simpleMessage("압축"),
    "compressed": MessageLookupByLibrary.simpleMessage("압축됨"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("이후"),
    "compressing": MessageLookupByLibrary.simpleMessage("압축 중..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage("압축 취소됨"),
    "compressionComplete": MessageLookupByLibrary.simpleMessage("압축 완료"),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage("압축이 완료됨"),
    "compressionFailed": MessageLookupByLibrary.simpleMessage("압축 실패"),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "이 사진을 압축할 수 없습니다. 다시 시도하거나 다른 것을 선택하세요.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("다크 테마"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "어두운 화면을 사용합니다",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("사진 품질"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "목표 품질을 설정하거나 품질 사전 설정에서 선택하도록 합니다.",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("이메일 복사됨"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "남은 시간 계산 중...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("실패"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage("사진 파일을 선택하세요"),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "사진을 저장할 수 없습니다. 다시 시도",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "사진을 공유할 수 없습니다. 다시 시도",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic을 사용할 수 없어서 이 사진은 jpeg로 저장되었습니다.",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("시작하기"),
    "githubRepository": MessageLookupByLibrary.simpleMessage("github 저장소"),
    "good": MessageLookupByLibrary.simpleMessage("좋음"),
    "high": MessageLookupByLibrary.simpleMessage("높음"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "압축을 취소하려면 버튼을 길게 누르세요",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "캐시를 지우려면 버튼을 길게 누르세요",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "원본을 삭제하려면 버튼을 길게 누르세요",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo는 사진의 새 복사본을 만들어 보다 효율적으로 저장합니다. 결과를 유용하게 유지하면서 이미지 품질이나 크기를 줄일 수 있습니다.\n\n품질이 낮을수록 눈에 띄기 어려운 작은 세부 사항이 저장됩니다. 크기가 작을수록 더 적은 수의 픽셀을 사용합니다. 둘 다 파일 크기를 줄입니다.\n\n원본 사진은 그대로 유지되며 장치에서 압축이 발생합니다.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "사진이 어떻게 작아지는지",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("EXIF 메타데이터 유지"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("메타데이터"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "지원되는 경우 카메라 및 EXIF 정보 보존",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage("메타데이터 유지"),
    "language": MessageLookupByLibrary.simpleMessage("언어"),
    "languageDescription": MessageLookupByLibrary.simpleMessage("앱 언어를 선택하세요"),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "클라우드 저장소에서 다운로드하거나 대용량 파일을 복사하는 데 시간이 더 오래 걸릴 수 있습니다.",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage("사진 로드 중..."),
    "low": MessageLookupByLibrary.simpleMessage("낮음"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("khlebobul 제작"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("최대 치수"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "가장 긴 이미지 면을 제한합니다. 값이 작을수록 더 많은 공간이 절약됩니다.",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("중간"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("메타데이터 모드"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "지원되는 경우 카메라 및 EXIF 정보를 유지하거나 제거합니다.",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "일부 갤러리 메타데이터를 복사할 수 없습니다",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("내 다른 앱"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("내 웹사이트"),
    "next": MessageLookupByLibrary.simpleMessage("다음"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "다른 모드를 사용해 보세요 — 이 모드는 크기를 줄이지 않습니다",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "하나 또는 여러 장의 사진을 선택하십시오. minimo는 로컬 파일과 함께 작동하며 원본을 그대로 유지합니다.",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage("사진 고르기"),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "품질 사전 설정을 선택하거나 크기 및 메타데이터를 수동으로 조정하세요.",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage("변경할 내용 선택"),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "압축은 장치에서 발생합니다. 사진은 어디에도 업로드되지 않습니다. 결과가 마음에 들면 더 작은 복사본을 저장하세요.",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "기본적으로 개인 정보 보호",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo(사진)는 오픈소스입니다. 코드를 탐색하고, 프로젝트를 팔로우하고, 연락하세요.",
    ),
    "original": MessageLookupByLibrary.simpleMessage("원본"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "일부 원본을 삭제할 수 없습니다",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("전에"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("출력 형식"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "JPEG는 어디에서나 작동합니다. heic은 더 작을 수 있지만 JPEG로 다시 떨어질 수 있습니다.",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "기기가 뜨거워지면 압축이 느려질 수 있습니다",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "미리보기를 사용할 수 없습니다",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "품질이 높을수록 더 많은 세부 정보가 유지되고 더 큰 파일이 생성됩니다.",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "세부 사항 및 원래 치수 유지",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "공유할 수 있는 작은 파일",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "균형 잡힌 품질과 파일 크기",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage("압축된 사진"),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("파일에서"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("갤러리에서"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage("화면 켜기"),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "사진을 로드하거나 압축하는 동안 화면이 절전 모드로 전환되는 것을 방지합니다.",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("프로젝트 웹사이트"),
    "quality": MessageLookupByLibrary.simpleMessage("화질"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "공간을 절약하기 위해 품질이 저하됩니다.",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("앱 평가하기"),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage("원본 교체"),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "원본 메타데이터와 함께 저장한 다음 원본 삭제를 요청하세요.",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("이미지 크기"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "가장 긴 이미지 면을 제한합니다. 더 작은 크기로 더 많은 공간을 절약",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("해상도"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "크기를 줄여 가장 많은 공간을 절약합니다",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "해상도를 hd로 낮춥니다",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "해상도를 sd로 낮춥니다",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("저장"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("새로 저장"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "원본을 유지하고 새 갤러리 사진을 저장하세요",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage("원본 옆에 저장"),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "원본을 유지하고 날짜와 메타데이터를 복사합니다",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("저장 방법"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage("사진을 앨범에 저장"),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("저장됨"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "share": MessageLookupByLibrary.simpleMessage("공유"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage("공유 또는 저장…"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage("친구와 공유"),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage("과열 경고 표시"),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "기기가 느려질 수 있을 때 압축 중 작은 배너를 표시합니다",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("간단"),
    "skip": MessageLookupByLibrary.simpleMessage("건너뛰기"),
    "small": MessageLookupByLibrary.simpleMessage("작음"),
    "smaller": MessageLookupByLibrary.simpleMessage("더 작게"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage("절약한 공간"),
    "statistics": MessageLookupByLibrary.simpleMessage("통계"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "통계는 이 장치에 로컬로 저장됩니다.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("메타데이터 제거"),
    "system": MessageLookupByLibrary.simpleMessage("시스템"),
    "todo": MessageLookupByLibrary.simpleMessage("할 일"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("다시 시도"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "저장되지 않은 압축 사진을 두고 삭제하시겠습니까?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage("저장되지 않은 사진"),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "휴대전화에서 바로 동영상을 작게 만드세요.",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("대기 중"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
