// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `unsaved photos`
  String get unsavedResultsTitle {
    return Intl.message(
      'unsaved photos',
      name: 'unsavedResultsTitle',
      desc: '',
      args: [],
    );
  }

  /// `leave and delete unsaved compressed photos?`
  String get unsavedResultsExit {
    return Intl.message(
      'leave and delete unsaved compressed photos?',
      name: 'unsavedResultsExit',
      desc: '',
      args: [],
    );
  }

  /// `minimo (photo)`
  String get appName {
    return Intl.message('minimo (photo)', name: 'appName', desc: '', args: []);
  }

  /// `by khlebobul`
  String get madeByKhlebobul {
    return Intl.message(
      'by khlebobul',
      name: 'madeByKhlebobul',
      desc: '',
      args: [],
    );
  }

  /// `skip`
  String get skip {
    return Intl.message('skip', name: 'skip', desc: '', args: []);
  }

  /// `next`
  String get next {
    return Intl.message('next', name: 'next', desc: '', args: []);
  }

  /// `get started`
  String get getStarted {
    return Intl.message('get started', name: 'getStarted', desc: '', args: []);
  }

  /// `pick photos`
  String get onboardingPickTitle {
    return Intl.message(
      'pick photos',
      name: 'onboardingPickTitle',
      desc: '',
      args: [],
    );
  }

  /// `choose one or several photos. minimo works with local files and keeps the originals untouched`
  String get onboardingPickDescription {
    return Intl.message(
      'choose one or several photos. minimo works with local files and keeps the originals untouched',
      name: 'onboardingPickDescription',
      desc: '',
      args: [],
    );
  }

  /// `choose what changes`
  String get onboardingQualityTitle {
    return Intl.message(
      'choose what changes',
      name: 'onboardingQualityTitle',
      desc: '',
      args: [],
    );
  }

  /// `choose a quality preset or adjust dimensions and metadata manually`
  String get onboardingQualityDescription {
    return Intl.message(
      'choose a quality preset or adjust dimensions and metadata manually',
      name: 'onboardingQualityDescription',
      desc: '',
      args: [],
    );
  }

  /// `private by default`
  String get onboardingSaveTitle {
    return Intl.message(
      'private by default',
      name: 'onboardingSaveTitle',
      desc: '',
      args: [],
    );
  }

  /// `compression happens on your device. photos are not uploaded anywhere; save the smaller copy when you like the result`
  String get onboardingSaveDescription {
    return Intl.message(
      'compression happens on your device. photos are not uploaded anywhere; save the smaller copy when you like the result',
      name: 'onboardingSaveDescription',
      desc: '',
      args: [],
    );
  }

  /// `todo`
  String get todo {
    return Intl.message('todo', name: 'todo', desc: '', args: []);
  }

  /// `about`
  String get about {
    return Intl.message('about', name: 'about', desc: '', args: []);
  }

  /// `minimo (photo) was born from a simple frustration.\n\nthis project gives everyone a convenient and free way to compress photos directly on a mobile device, save storage and keep the moments that matter.`
  String get aboutStory {
    return Intl.message(
      'minimo (photo) was born from a simple frustration.\n\nthis project gives everyone a convenient and free way to compress photos directly on a mobile device, save storage and keep the moments that matter.',
      name: 'aboutStory',
      desc: '',
      args: [],
    );
  }

  /// `how photo gets smaller`
  String get howCompressionWorksTitle {
    return Intl.message(
      'how photo gets smaller',
      name: 'howCompressionWorksTitle',
      desc: '',
      args: [],
    );
  }

  /// `minimo makes a new copy of your photo and stores it more efficiently. it can reduce image quality or dimensions while keeping the result useful.\n\nlower quality stores fewer tiny details that are hard to notice. smaller dimensions use fewer pixels. both reduce file size.\n\nyour original photo stays untouched, and compression happens on your device.`
  String get howCompressionWorksBody {
    return Intl.message(
      'minimo makes a new copy of your photo and stores it more efficiently. it can reduce image quality or dimensions while keeping the result useful.\n\nlower quality stores fewer tiny details that are hard to notice. smaller dimensions use fewer pixels. both reduce file size.\n\nyour original photo stays untouched, and compression happens on your device.',
      name: 'howCompressionWorksBody',
      desc: '',
      args: [],
    );
  }

  /// `minimo (photo) is open source. explore the code, follow the project or get in touch`
  String get openSourceNote {
    return Intl.message(
      'minimo (photo) is open source. explore the code, follow the project or get in touch',
      name: 'openSourceNote',
      desc: '',
      args: [],
    );
  }

  /// `rate the app`
  String get rateTheApp {
    return Intl.message('rate the app', name: 'rateTheApp', desc: '', args: []);
  }

  /// `share with friends`
  String get shareWithFriends {
    return Intl.message(
      'share with friends',
      name: 'shareWithFriends',
      desc: '',
      args: [],
    );
  }

  /// `try minimo (photo) — a simple app for making photos smaller on your phone: {url}`
  String shareAppText(String url) {
    return Intl.message(
      'try minimo (photo) — a simple app for making photos smaller on your phone: $url',
      name: 'shareAppText',
      desc: '',
      args: [url],
    );
  }

  /// `what's new in {version}`
  String changelogTitle(String version) {
    return Intl.message(
      'what\'s new in $version',
      name: 'changelogTitle',
      desc: '',
      args: [version],
    );
  }

  /// `changes from updates you have not seen yet`
  String get changelogSubtitle {
    return Intl.message(
      'changes from updates you have not seen yet',
      name: 'changelogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `got it`
  String get changelogDone {
    return Intl.message('got it', name: 'changelogDone', desc: '', args: []);
  }

  /// `project website`
  String get projectWebsite {
    return Intl.message(
      'project website',
      name: 'projectWebsite',
      desc: '',
      args: [],
    );
  }

  /// `github repository`
  String get githubRepository {
    return Intl.message(
      'github repository',
      name: 'githubRepository',
      desc: '',
      args: [],
    );
  }

  /// `x (twitter)`
  String get xTwitter {
    return Intl.message('x (twitter)', name: 'xTwitter', desc: '', args: []);
  }

  /// `my website`
  String get myWebsite {
    return Intl.message('my website', name: 'myWebsite', desc: '', args: []);
  }

  /// `my other apps`
  String get myOtherApps {
    return Intl.message(
      'my other apps',
      name: 'myOtherApps',
      desc: '',
      args: [],
    );
  }

  /// `make videos smaller, right on your phone`
  String get videoAppDescription {
    return Intl.message(
      'make videos smaller, right on your phone',
      name: 'videoAppDescription',
      desc: '',
      args: [],
    );
  }

  /// `email copied`
  String get emailCopied {
    return Intl.message(
      'email copied',
      name: 'emailCopied',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settings {
    return Intl.message('settings', name: 'settings', desc: '', args: []);
  }

  /// `add "{prefix}" prefix`
  String addPrefix(String prefix) {
    return Intl.message(
      'add "$prefix" prefix',
      name: 'addPrefix',
      desc: '',
      args: [prefix],
    );
  }

  /// `adds "{prefix}" before the original file name. disabling keeps the original file name`
  String addPrefixDescription(String prefix) {
    return Intl.message(
      'adds "$prefix" before the original file name. disabling keeps the original file name',
      name: 'addPrefixDescription',
      desc: '',
      args: [prefix],
    );
  }

  /// `show overheat warning`
  String get showOverheatWarning {
    return Intl.message(
      'show overheat warning',
      name: 'showOverheatWarning',
      desc: '',
      args: [],
    );
  }

  /// `shows a small banner during compression when the device may slow down`
  String get showOverheatWarningDescription {
    return Intl.message(
      'shows a small banner during compression when the device may slow down',
      name: 'showOverheatWarningDescription',
      desc: '',
      args: [],
    );
  }

  /// `save photos to album`
  String get savePhotosToAlbum {
    return Intl.message(
      'save photos to album',
      name: 'savePhotosToAlbum',
      desc: '',
      args: [],
    );
  }

  /// `saves compressed photos to the {album} album instead of recently saved`
  String savePhotosToAlbumDescription(String album) {
    return Intl.message(
      'saves compressed photos to the $album album instead of recently saved',
      name: 'savePhotosToAlbumDescription',
      desc: '',
      args: [album],
    );
  }

  /// `how to save`
  String get saveOptionsTitle {
    return Intl.message(
      'how to save',
      name: 'saveOptionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `save as new`
  String get saveAsNew {
    return Intl.message('save as new', name: 'saveAsNew', desc: '', args: []);
  }

  /// `keep the original and save a new gallery photo`
  String get saveAsNewDescription {
    return Intl.message(
      'keep the original and save a new gallery photo',
      name: 'saveAsNewDescription',
      desc: '',
      args: [],
    );
  }

  /// `save beside original`
  String get saveBesideOriginal {
    return Intl.message(
      'save beside original',
      name: 'saveBesideOriginal',
      desc: '',
      args: [],
    );
  }

  /// `keep the original and copy its gallery date and metadata`
  String get saveBesideOriginalDescription {
    return Intl.message(
      'keep the original and copy its gallery date and metadata',
      name: 'saveBesideOriginalDescription',
      desc: '',
      args: [],
    );
  }

  /// `replace original`
  String get replaceOriginal {
    return Intl.message(
      'replace original',
      name: 'replaceOriginal',
      desc: '',
      args: [],
    );
  }

  /// `save with original metadata, then ask to delete the original`
  String get replaceOriginalDescription {
    return Intl.message(
      'save with original metadata, then ask to delete the original',
      name: 'replaceOriginalDescription',
      desc: '',
      args: [],
    );
  }

  /// `keep screen awake`
  String get preventScreenSleep {
    return Intl.message(
      'keep screen awake',
      name: 'preventScreenSleep',
      desc: '',
      args: [],
    );
  }

  /// `prevents the screen from sleeping while photos are loading or compressing`
  String get preventScreenSleepDescription {
    return Intl.message(
      'prevents the screen from sleeping while photos are loading or compressing',
      name: 'preventScreenSleepDescription',
      desc: '',
      args: [],
    );
  }

  /// `clear cache`
  String get clearCache {
    return Intl.message('clear cache', name: 'clearCache', desc: '', args: []);
  }

  /// `removes temporary app files. photos saved to your gallery remain untouched`
  String get clearCacheDescription {
    return Intl.message(
      'removes temporary app files. photos saved to your gallery remain untouched',
      name: 'clearCacheDescription',
      desc: '',
      args: [],
    );
  }

  /// `hold the button to clear cache`
  String get holdToClearCache {
    return Intl.message(
      'hold the button to clear cache',
      name: 'holdToClearCache',
      desc: '',
      args: [],
    );
  }

  /// `cache cleared`
  String get cacheCleared {
    return Intl.message(
      'cache cleared',
      name: 'cacheCleared',
      desc: '',
      args: [],
    );
  }

  /// `failed to clear cache`
  String get cacheClearFailed {
    return Intl.message(
      'failed to clear cache',
      name: 'cacheClearFailed',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get language {
    return Intl.message('language', name: 'language', desc: '', args: []);
  }

  /// `select the language for the app`
  String get languageDescription {
    return Intl.message(
      'select the language for the app',
      name: 'languageDescription',
      desc: '',
      args: [],
    );
  }

  /// `dark theme`
  String get darkTheme {
    return Intl.message('dark theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `use the dark appearance`
  String get darkThemeDescription {
    return Intl.message(
      'use the dark appearance',
      name: 'darkThemeDescription',
      desc: '',
      args: [],
    );
  }

  /// `system`
  String get system {
    return Intl.message('system', name: 'system', desc: '', args: []);
  }

  /// `english`
  String get english {
    return Intl.message('english', name: 'english', desc: '', args: []);
  }

  /// `русский`
  String get russian {
    return Intl.message('русский', name: 'russian', desc: '', args: []);
  }

  /// `compression can slow down if your device gets hot`
  String get overheatWarning {
    return Intl.message(
      'compression can slow down if your device gets hot',
      name: 'overheatWarning',
      desc: '',
      args: [],
    );
  }

  /// `keep minimo open during compression. if you leave, the current photo restarts when you return`
  String get iosBackgroundCompressionWarning {
    return Intl.message(
      'keep minimo open during compression. if you leave, the current photo restarts when you return',
      name: 'iosBackgroundCompressionWarning',
      desc: '',
      args: [],
    );
  }

  /// `quality`
  String get quality {
    return Intl.message('quality', name: 'quality', desc: '', args: []);
  }

  /// `resolution`
  String get resolution {
    return Intl.message('resolution', name: 'resolution', desc: '', args: []);
  }

  /// `high`
  String get high {
    return Intl.message('high', name: 'high', desc: '', args: []);
  }

  /// `good`
  String get good {
    return Intl.message('good', name: 'good', desc: '', args: []);
  }

  /// `medium`
  String get medium {
    return Intl.message('medium', name: 'medium', desc: '', args: []);
  }

  /// `low`
  String get low {
    return Intl.message('low', name: 'low', desc: '', args: []);
  }

  /// `small`
  String get small {
    return Intl.message('small', name: 'small', desc: '', args: []);
  }

  /// `reduce dimensions for the biggest size savings`
  String get resolutionDescription {
    return Intl.message(
      'reduce dimensions for the biggest size savings',
      name: 'resolutionDescription',
      desc: '',
      args: [],
    );
  }

  /// `photo quality`
  String get detailLevel {
    return Intl.message(
      'photo quality',
      name: 'detailLevel',
      desc: '',
      args: [],
    );
  }

  /// `set a target quality or let the quality preset choose it`
  String get detailLevelDescription {
    return Intl.message(
      'set a target quality or let the quality preset choose it',
      name: 'detailLevelDescription',
      desc: '',
      args: [],
    );
  }

  /// `auto`
  String get automatic {
    return Intl.message('auto', name: 'automatic', desc: '', args: []);
  }

  /// `image dimensions`
  String get resize {
    return Intl.message('image dimensions', name: 'resize', desc: '', args: []);
  }

  /// `limit output frames per second; higher source rates are left unchanged`
  String get resizeDescription {
    return Intl.message(
      'limit output frames per second; higher source rates are left unchanged',
      name: 'resizeDescription',
      desc: '',
      args: [],
    );
  }

  /// `outputformat`
  String get outputFormat {
    return Intl.message(
      'outputformat',
      name: 'outputFormat',
      desc: '',
      args: [],
    );
  }

  /// `jpeg works everywhere; heic can be smaller but may fall back to jpeg`
  String get outputFormatDescription {
    return Intl.message(
      'jpeg works everywhere; heic can be smaller but may fall back to jpeg',
      name: 'outputFormatDescription',
      desc: '',
      args: [],
    );
  }

  /// `metadatamode`
  String get metadataMode {
    return Intl.message(
      'metadatamode',
      name: 'metadataMode',
      desc: '',
      args: [],
    );
  }

  /// `keep the original audio or strip it to save more space`
  String get metadataModeDescription {
    return Intl.message(
      'keep the original audio or strip it to save more space',
      name: 'metadataModeDescription',
      desc: '',
      args: [],
    );
  }

  /// `keep metadata`
  String get keepMetadataLegacy {
    return Intl.message(
      'keep metadata',
      name: 'keepMetadataLegacy',
      desc: '',
      args: [],
    );
  }

  /// `strip metadata`
  String get stripMetadata {
    return Intl.message(
      'strip metadata',
      name: 'stripMetadata',
      desc: '',
      args: [],
    );
  }

  /// `original`
  String get original {
    return Intl.message('original', name: 'original', desc: '', args: []);
  }

  /// `compressed`
  String get compressed {
    return Intl.message('compressed', name: 'compressed', desc: '', args: []);
  }

  /// `simple`
  String get simpleOptions {
    return Intl.message('simple', name: 'simpleOptions', desc: '', args: []);
  }

  /// `advanced`
  String get advancedOptions {
    return Intl.message(
      'advanced',
      name: 'advancedOptions',
      desc: '',
      args: [],
    );
  }

  /// `quality will be reduced to save space`
  String get qualityReducedDescription {
    return Intl.message(
      'quality will be reduced to save space',
      name: 'qualityReducedDescription',
      desc: '',
      args: [],
    );
  }

  /// `resolution will be reduced to hd`
  String get resolutionReducedHdDescription {
    return Intl.message(
      'resolution will be reduced to hd',
      name: 'resolutionReducedHdDescription',
      desc: '',
      args: [],
    );
  }

  /// `resolution will be reduced to sd`
  String get resolutionReducedSdDescription {
    return Intl.message(
      'resolution will be reduced to sd',
      name: 'resolutionReducedSdDescription',
      desc: '',
      args: [],
    );
  }

  /// `better`
  String get better {
    return Intl.message('better', name: 'better', desc: '', args: []);
  }

  /// `smaller`
  String get smaller {
    return Intl.message('smaller', name: 'smaller', desc: '', args: []);
  }

  /// `try another mode — this won't make it smaller`
  String get noSavingsHint {
    return Intl.message(
      'try another mode — this won\'t make it smaller',
      name: 'noSavingsHint',
      desc: '',
      args: [],
    );
  }

  /// `compress`
  String get compress {
    return Intl.message('compress', name: 'compress', desc: '', args: []);
  }

  /// `compressing...`
  String get compressing {
    return Intl.message(
      'compressing...',
      name: 'compressing',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `hold the button to cancel compression`
  String get holdToCancelCompression {
    return Intl.message(
      'hold the button to cancel compression',
      name: 'holdToCancelCompression',
      desc: '',
      args: [],
    );
  }

  /// `compression cancelled`
  String get compressionCancelled {
    return Intl.message(
      'compression cancelled',
      name: 'compressionCancelled',
      desc: '',
      args: [],
    );
  }

  /// `estimating time remaining...`
  String get estimatingTimeRemaining {
    return Intl.message(
      'estimating time remaining...',
      name: 'estimatingTimeRemaining',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{about 1 second left} other{about {count} seconds left}}`
  String secondsRemaining(int count) {
    return Intl.plural(
      count,
      one: 'about 1 second left',
      other: 'about $count seconds left',
      name: 'secondsRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{about 1 minute left} other{about {count} minutes left}}`
  String minutesRemaining(int count) {
    return Intl.plural(
      count,
      one: 'about 1 minute left',
      other: 'about $count minutes left',
      name: 'minutesRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `from gallery`
  String get pickFromGallery {
    return Intl.message(
      'from gallery',
      name: 'pickFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `from files`
  String get pickFromFiles {
    return Intl.message(
      'from files',
      name: 'pickFromFiles',
      desc: '',
      args: [],
    );
  }

  /// `loading photos...`
  String get loadingPhotos {
    return Intl.message(
      'loading photos...',
      name: 'loadingPhotos',
      desc: '',
      args: [],
    );
  }

  /// `downloading from cloud storage or copying large files may take longer`
  String get loadingManyPhotosHint {
    return Intl.message(
      'downloading from cloud storage or copying large files may take longer',
      name: 'loadingManyPhotosHint',
      desc: '',
      args: [],
    );
  }

  /// `choose a photo file`
  String get failedToPickPhotos {
    return Intl.message(
      'choose a photo file',
      name: 'failedToPickPhotos',
      desc: '',
      args: [],
    );
  }

  /// `compression complete`
  String get compressionComplete {
    return Intl.message(
      'compression complete',
      name: 'compressionComplete',
      desc: '',
      args: [],
    );
  }

  /// `compression completed`
  String get compressionCompleted {
    return Intl.message(
      'compression completed',
      name: 'compressionCompleted',
      desc: '',
      args: [],
    );
  }

  /// `compression failed`
  String get compressionFailed {
    return Intl.message(
      'compression failed',
      name: 'compressionFailed',
      desc: '',
      args: [],
    );
  }

  /// `we couldn't compress this photo. try again or choose another one.`
  String get compressionFailedDescription {
    return Intl.message(
      'we couldn\'t compress this photo. try again or choose another one.',
      name: 'compressionFailedDescription',
      desc: '',
      args: [],
    );
  }

  /// `no useful savings`
  String get alreadyOptimized {
    return Intl.message(
      'no useful savings',
      name: 'alreadyOptimized',
      desc: '',
      args: [],
    );
  }

  /// `these settings did not reduce the file by at least 10%. try lower quality or dimensions.`
  String get alreadyOptimizedDescription {
    return Intl.message(
      'these settings did not reduce the file by at least 10%. try lower quality or dimensions.',
      name: 'alreadyOptimizedDescription',
      desc: '',
      args: [],
    );
  }

  /// `try again`
  String get tryAgain {
    return Intl.message('try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `you saved {size}`
  String youSavedSize(String size) {
    return Intl.message(
      'you saved $size',
      name: 'youSavedSize',
      desc: '',
      args: [size],
    );
  }

  /// `share`
  String get share {
    return Intl.message('share', name: 'share', desc: '', args: []);
  }

  /// `share or save to…`
  String get shareOrSave {
    return Intl.message(
      'share or save to…',
      name: 'shareOrSave',
      desc: '',
      args: [],
    );
  }

  /// `compare`
  String get comparePhotos {
    return Intl.message('compare', name: 'comparePhotos', desc: '', args: []);
  }

  /// `before`
  String get originalPhoto {
    return Intl.message('before', name: 'originalPhoto', desc: '', args: []);
  }

  /// `after`
  String get compressedPhoto {
    return Intl.message('after', name: 'compressedPhoto', desc: '', args: []);
  }

  /// `heic wasn't available, so this photo was saved as jpeg`
  String get formatFallbackNotice {
    return Intl.message(
      'heic wasn\'t available, so this photo was saved as jpeg',
      name: 'formatFallbackNotice',
      desc: '',
      args: [],
    );
  }

  /// `preview unavailable`
  String get photoPreviewUnavailable {
    return Intl.message(
      'preview unavailable',
      name: 'photoPreviewUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message('save', name: 'save', desc: '', args: []);
  }

  /// `saved`
  String get saved {
    return Intl.message('saved', name: 'saved', desc: '', args: []);
  }

  /// `hold the button to delete originals`
  String get holdToDeleteOriginals {
    return Intl.message(
      'hold the button to delete originals',
      name: 'holdToDeleteOriginals',
      desc: '',
      args: [],
    );
  }

  /// `couldn't share the photos. try again`
  String get failedToShare {
    return Intl.message(
      'couldn\'t share the photos. try again',
      name: 'failedToShare',
      desc: '',
      args: [],
    );
  }

  /// `saved {saved} photo(s) and deleted {deleted} original(s)`
  String savedPhotosAndDeletedOriginals(int saved, int deleted) {
    return Intl.message(
      'saved $saved photo(s) and deleted $deleted original(s)',
      name: 'savedPhotosAndDeletedOriginals',
      desc: '',
      args: [saved, deleted],
    );
  }

  /// `photos saved, but some originals could not be deleted: {error}`
  String savedButOriginalsNotDeleted(String error) {
    return Intl.message(
      'photos saved, but some originals could not be deleted: $error',
      name: 'savedButOriginalsNotDeleted',
      desc: '',
      args: [error],
    );
  }

  /// `photos saved with some issues: {error}`
  String savedWithWarnings(String error) {
    return Intl.message(
      'photos saved with some issues: $error',
      name: 'savedWithWarnings',
      desc: '',
      args: [error],
    );
  }

  /// `some gallery metadata could not be copied`
  String get metadataPreservationIncomplete {
    return Intl.message(
      'some gallery metadata could not be copied',
      name: 'metadataPreservationIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `some originals could not be deleted`
  String get originalDeletionFailed {
    return Intl.message(
      'some originals could not be deleted',
      name: 'originalDeletionFailed',
      desc: '',
      args: [],
    );
  }

  /// `waiting`
  String get waiting {
    return Intl.message('waiting', name: 'waiting', desc: '', args: []);
  }

  /// `failed`
  String get failed {
    return Intl.message('failed', name: 'failed', desc: '', args: []);
  }

  /// `photo {current} of {total}`
  String photoProgress(int current, int total) {
    return Intl.message(
      'photo $current of $total',
      name: 'photoProgress',
      desc: '',
      args: [current, total],
    );
  }

  /// `{completed} of {total} photos compressed`
  String photosCompressed(int completed, int total) {
    return Intl.message(
      '$completed of $total photos compressed',
      name: 'photosCompressed',
      desc: '',
      args: [completed, total],
    );
  }

  /// `{count, plural, =1{save 1 photo} other{save {count} photos}}`
  String savePhotos(int count) {
    return Intl.plural(
      count,
      one: 'save 1 photo',
      other: 'save $count photos',
      name: 'savePhotos',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{saved 1 photo to gallery} other{saved {count} photos to gallery}}`
  String savedPhotosToGallery(int count) {
    return Intl.plural(
      count,
      one: 'saved 1 photo to gallery',
      other: 'saved $count photos to gallery',
      name: 'savedPhotosToGallery',
      desc: '',
      args: [count],
    );
  }

  /// `couldn't save the photos. try again`
  String get failedToSave {
    return Intl.message(
      'couldn\'t save the photos. try again',
      name: 'failedToSave',
      desc: '',
      args: [],
    );
  }

  /// `keep detail and original dimensions`
  String get photoQualityHighDescription {
    return Intl.message(
      'keep detail and original dimensions',
      name: 'photoQualityHighDescription',
      desc: '',
      args: [],
    );
  }

  /// `balanced quality and file size`
  String get photoQualityMediumDescription {
    return Intl.message(
      'balanced quality and file size',
      name: 'photoQualityMediumDescription',
      desc: '',
      args: [],
    );
  }

  /// `smaller files for sharing`
  String get photoQualityLowDescription {
    return Intl.message(
      'smaller files for sharing',
      name: 'photoQualityLowDescription',
      desc: '',
      args: [],
    );
  }

  /// `higher quality keeps more detail and creates a larger file`
  String get photoQualityDescription {
    return Intl.message(
      'higher quality keeps more detail and creates a larger file',
      name: 'photoQualityDescription',
      desc: '',
      args: [],
    );
  }

  /// `maximum dimension`
  String get maximumDimension {
    return Intl.message(
      'maximum dimension',
      name: 'maximumDimension',
      desc: '',
      args: [],
    );
  }

  /// `limit the longest image side; smaller values save more space`
  String get maximumDimensionDescription {
    return Intl.message(
      'limit the longest image side; smaller values save more space',
      name: 'maximumDimensionDescription',
      desc: '',
      args: [],
    );
  }

  /// `metadata`
  String get keepMetadata {
    return Intl.message('metadata', name: 'keepMetadata', desc: '', args: []);
  }

  /// `preserve camera and exif information when supported`
  String get keepMetadataDescription {
    return Intl.message(
      'preserve camera and exif information when supported',
      name: 'keepMetadataDescription',
      desc: '',
      args: [],
    );
  }

  /// `keep exif metadata`
  String get keepExif {
    return Intl.message(
      'keep exif metadata',
      name: 'keepExif',
      desc: '',
      args: [],
    );
  }

  /// `statistics`
  String get statistics {
    return Intl.message('statistics', name: 'statistics', desc: '', args: []);
  }

  /// `photos compressed`
  String get photosCompressedStat {
    return Intl.message(
      'photos compressed',
      name: 'photosCompressedStat',
      desc: '',
      args: [],
    );
  }

  /// `space saved`
  String get spaceSavedStat {
    return Intl.message(
      'space saved',
      name: 'spaceSavedStat',
      desc: '',
      args: [],
    );
  }

  /// `statistics are stored locally on this device.`
  String get statisticsSinceVersion {
    return Intl.message(
      'statistics are stored locally on this device.',
      name: 'statisticsSinceVersion',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
