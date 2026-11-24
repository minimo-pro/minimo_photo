import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_launch_service.dart';

enum Language {
  en('en'),
  de('de'),
  es('es'),
  fr('fr'),
  hi('hi'),
  it('it'),
  ja('ja'),
  ko('ko'),
  nl('nl'),
  pt('pt'),
  ru('ru'),
  tr('tr'),
  zh('zh');

  final String code;

  const Language(this.code);

  static Language fromCode(String? code) {
    for (final language in values) {
      if (language.code == code) return language;
    }
    return Language.en;
  }
}

typedef Changelog = Map<String, Map<Language, List<String>>>;

const Changelog _changelog = {
  '1.1.2': {
    Language.en: ['report a bug from the about screen.'],
    Language.de: ['fehler lassen sich über den infobereich melden.'],
    Language.es: ['informa de un error desde la pantalla de información.'],
    Language.fr: ['signalez un bug depuis l’écran à propos.'],
    Language.hi: [
      'ऐप के बारे में बताने वाली स्क्रीन से समस्या की रिपोर्ट करें।',
    ],
    Language.it: ['segnala un problema dalla schermata delle informazioni.'],
    Language.ja: ['アプリ情報画面から不具合を報告できます。'],
    Language.ko: ['앱 정보 화면에서 버그를 신고할 수 있습니다.'],
    Language.nl: ['meld een fout via het infoscherm.'],
    Language.pt: ['relate um erro na tela sobre o app.'],
    Language.ru: ['сообщить об ошибке можно с экрана «о приложении».'],
    Language.tr: ['hakkında ekranından hata bildirin.'],
    Language.zh: ['可以在关于页面报告问题。'],
  },
  '1.1.1': {
    Language.en: [
      'the update dialog follows your app theme and language.',
      'website and contact links are easier to find on the about screen.',
    ],
    Language.de: [
      'der aktualisierungsdialog verwendet das design und die sprache der app.',
      'website und kontaktlinks sind im infobereich leichter zu finden.',
    ],
    Language.es: [
      'el aviso de actualización usa el tema y el idioma de la app.',
      'el sitio web y los enlaces de contacto son más fáciles de encontrar en la pantalla de información.',
    ],
    Language.fr: [
      'la fenêtre de mise à jour utilise le thème et la langue de l’application.',
      'le site web et les liens de contact sont plus faciles à trouver dans l’écran à propos.',
    ],
    Language.hi: [
      'अपडेट का संदेश ऐप की थीम और भाषा में दिखता है।',
      'ऐप के बारे में बताने वाली स्क्रीन पर वेबसाइट और संपर्क लिंक ढूँढना आसान है।',
    ],
    Language.it: [
      'l’avviso di aggiornamento usa il tema e la lingua dell’app.',
      'il sito web e i link di contatto sono più facili da trovare nella schermata delle informazioni.',
    ],
    Language.ja: [
      'アップデートの案内にアプリのテーマと言語が反映されます。',
      'アプリ情報画面でウェブサイトや連絡先のリンクを見つけやすくなりました。',
    ],
    Language.ko: [
      '업데이트 안내에 앱의 테마와 언어가 적용됩니다.',
      '앱 정보 화면에서 웹사이트와 연락처 링크를 더 쉽게 찾을 수 있습니다.',
    ],
    Language.nl: [
      'het updatevenster gebruikt het thema en de taal van de app.',
      'de website en contactlinks zijn makkelijker te vinden op het infoscherm.',
    ],
    Language.pt: [
      'o aviso de atualização usa o tema e o idioma do app.',
      'o site e os links de contato estão mais fáceis de encontrar na tela sobre o app.',
    ],
    Language.ru: [
      'окно обновления учитывает тему и язык приложения.',
      'вебсайт и ссылки для связи проще найти на экране «о приложении».',
    ],
    Language.tr: [
      'güncelleme penceresi uygulamanın temasını ve dilini kullanır.',
      'web sitesi ve iletişim bağlantılarını hakkında ekranında bulmak artık daha kolay.',
    ],
    Language.zh: ['更新提示会使用应用的主题和语言。', '在关于页面更容易找到网站和联系链接。'],
  },
  '1.1.0': {
    Language.en: [
      'on supported devices, photos selected from the gallery or files can continue importing in the background with system progress and cancellation.',
      'on supported devices, photo compression can continue in the background with system progress and cancellation.',
      'a refreshed introduction with animated cards makes getting started easier.',
    ],
    Language.de: [
      'auf unterstützten geräten können fotos aus der galerie oder aus dateien im hintergrund weiter importiert werden, mit systemfortschritt und abbruchmöglichkeit.',
      'auf unterstützten geräten können fotos im hintergrund weiter komprimiert werden, mit systemfortschritt und abbruchmöglichkeit.',
      'eine überarbeitete einführung mit animierten karten erleichtert den einstieg.',
    ],
    Language.es: [
      'en dispositivos compatibles, las fotos seleccionadas de la galería o de archivos pueden seguir importándose en segundo plano, con progreso del sistema y opción de cancelar.',
      'en dispositivos compatibles, la compresión de fotos puede continuar en segundo plano, con progreso del sistema y opción de cancelar.',
      'una introducción renovada con tarjetas animadas facilita los primeros pasos.',
    ],
    Language.fr: [
      'sur les appareils compatibles, les photos sélectionnées dans la galerie ou les fichiers peuvent continuer à être importées en arrière-plan, avec progression système et annulation.',
      'sur les appareils compatibles, la compression des photos peut continuer en arrière-plan, avec progression système et annulation.',
      'une présentation repensée avec des cartes animées facilite la prise en main.',
    ],
    Language.hi: [
      'समर्थित डिवाइस पर गैलरी या फ़ाइलों से चुनी गई फ़ोटो का आयात पृष्ठभूमि में जारी रह सकता है, जिसमें सिस्टम की प्रगति और रद्द करने का विकल्प मिलता है।',
      'समर्थित डिवाइस पर फ़ोटो का संपीड़न पृष्ठभूमि में जारी रह सकता है, जिसमें सिस्टम की प्रगति और रद्द करने का विकल्प मिलता है।',
      'एनिमेटेड कार्ड के साथ नया परिचय शुरुआत करना आसान बनाता है।',
    ],
    Language.it: [
      'sui dispositivi compatibili, le foto selezionate dalla galleria o dai file possono continuare a essere importate in background, con avanzamento di sistema e possibilità di annullamento.',
      'sui dispositivi compatibili, la compressione delle foto può continuare in background, con avanzamento di sistema e possibilità di annullamento.',
      'una nuova introduzione con schede animate facilita i primi passi.',
    ],
    Language.ja: [
      '対応デバイスでは、ギャラリーやファイルから選択した写真の読み込みをバックグラウンドで続行でき、システムの進行状況表示やキャンセルに対応しています。',
      '対応デバイスでは、写真の圧縮をバックグラウンドで続行でき、システムの進行状況表示やキャンセルに対応しています。',
      'アニメーション付きカードの新しい入門ガイドで、より簡単に始められるようになりました。',
    ],
    Language.ko: [
      '지원되는 기기에서는 갤러리나 파일에서 선택한 사진을 백그라운드에서 계속 가져올 수 있으며, 시스템 진행 상황 표시와 취소 기능을 제공합니다.',
      '지원되는 기기에서는 사진 압축을 백그라운드에서 계속할 수 있으며, 시스템 진행 상황 표시와 취소 기능을 제공합니다.',
      '애니메이션 카드가 있는 새로운 시작 안내로 더 쉽게 시작할 수 있습니다.',
    ],
    Language.nl: [
      'op ondersteunde apparaten kunnen foto’s uit de galerij of bestanden op de achtergrond verder worden geïmporteerd, met systeemvoortgang en de mogelijkheid om te annuleren.',
      'op ondersteunde apparaten kunnen foto’s op de achtergrond verder worden gecomprimeerd, met systeemvoortgang en de mogelijkheid om te annuleren.',
      'een vernieuwde introductie met geanimeerde kaarten helpt u op weg.',
    ],
    Language.pt: [
      'em dispositivos compatíveis, as fotos selecionadas da galeria ou dos arquivos podem continuar sendo importadas em segundo plano, com progresso do sistema e opção de cancelar.',
      'em dispositivos compatíveis, a compressão de fotos pode continuar em segundo plano, com progresso do sistema e opção de cancelar.',
      'uma apresentação renovada com cartões animados facilita os primeiros passos.',
    ],
    Language.ru: [
      'на поддерживаемых устройствах импорт фото из галереи и файлов продолжается в фоне, с системным прогрессом и возможностью отмены.',
      'на поддерживаемых устройствах сжатие фото продолжается в фоне, с системным прогрессом и возможностью отмены.',
      'обновлённое знакомство с приложением с анимированными карточками поможет быстрее начать работу.',
    ],
    Language.tr: [
      'desteklenen cihazlarda galeriden veya dosyalardan seçilen fotoğraflar, sistem ilerleme göstergesi ve iptal seçeneğiyle arka planda içe aktarılmaya devam edebilir.',
      'desteklenen cihazlarda fotoğraf sıkıştırma, sistem ilerleme göstergesi ve iptal seçeneğiyle arka planda devam edebilir.',
      'animasyonlu kartlarla yenilenen tanıtım, başlamayı kolaylaştırır.',
    ],
    Language.zh: [
      '在支持的设备上，从图库或文件中选择的照片可继续在后台导入，并支持系统进度显示和取消操作。',
      '在支持的设备上，照片压缩可继续在后台进行，并支持系统进度显示和取消操作。',
      '全新动画卡片入门引导，让您更轻松地开始使用。',
    ],
  },
  '1.0.8': {
    Language.en: ['share your photo compression statistics and space saved.'],
    Language.de: [
      'teile deine fotokomprimierungsstatistik und den gesparten speicherplatz.',
    ],
    Language.es: [
      'comparte tus estadísticas de compresión de fotos y el espacio ahorrado.',
    ],
    Language.fr: [
      'partagez vos statistiques de compression de photos et l’espace économisé.',
    ],
    Language.hi: ['फ़ोटो संपीड़न के आँकड़े और बचाई गई जगह साझा करें।'],
    Language.it: [
      'condividi le statistiche di compressione delle foto e lo spazio risparmiato.',
    ],
    Language.ja: ['写真の圧縮枚数と節約した容量を共有できるようになりました。'],
    Language.ko: ['사진 압축 통계와 절약한 공간을 공유하세요.'],
    Language.nl: [
      'deel je fotocompressiestatistieken en bespaarde opslagruimte.',
    ],
    Language.pt: [
      'compartilhe suas estatísticas de compressão de fotos e o espaço economizado.',
    ],
    Language.ru: ['делитесь статистикой сжатия фото и сэкономленного места.'],
    Language.tr: [
      'fotoğraf sıkıştırma istatistiklerini ve kazanılan alanı paylaş.',
    ],
    Language.zh: ['分享照片压缩数量和节省的空间。'],
  },
  '1.0.7': {
    Language.en: ['fixed bugs when saving photos.'],
    Language.de: ['fehler beim speichern von fotos behoben.'],
    Language.es: ['corregidos errores al guardar fotos.'],
    Language.fr: ['correction de bugs lors de l’enregistrement des photos.'],
    Language.hi: ['फ़ोटो सहेजते समय होने वाली समस्याएँ ठीक की गईं।'],
    Language.it: ['corretti errori nel salvataggio delle foto.'],
    Language.ja: ['写真の保存時に発生する不具合を修正しました。'],
    Language.ko: ['사진 저장 시 발생하는 오류를 수정했습니다.'],
    Language.nl: ['fouten bij het opslaan van foto’s opgelost.'],
    Language.pt: ['corrigidos erros ao salvar fotos.'],
    Language.ru: ['исправлены ошибки при сохранении фото.'],
    Language.tr: ['fotoğraf kaydederken oluşan hatalar düzeltildi.'],
    Language.zh: ['修复了保存照片时出现的问题。'],
  },
  '1.0.6': {
    Language.en: [
      'save compressed photos even when some originals cannot be deleted.',
      'secondary text is easier to read in the light theme.',
    ],
    Language.de: [
      'komprimierte fotos speichern, auch wenn einige originale nicht gelöscht werden können.',
      'zweitrangiger text ist im hellen design besser lesbar.',
    ],
    Language.es: [
      'guarda las fotos comprimidas aunque no se puedan eliminar algunos originales.',
      'el texto secundario se lee mejor en el tema claro.',
    ],
    Language.fr: [
      'enregistrez les photos compressées même si certains originaux ne peuvent pas être supprimés.',
      'le texte secondaire est plus lisible en mode clair.',
    ],
    Language.hi: [
      'कुछ मूल फ़ोटो न हटने पर भी संपीड़ित फ़ोटो सहेजें।',
      'हल्की थीम में सहायक पाठ पढ़ना आसान है।',
    ],
    Language.it: [
      'salva le foto compresse anche se alcuni originali non possono essere eliminati.',
      'il testo secondario è più leggibile nel tema chiaro.',
    ],
    Language.ja: [
      '一部の元の写真を削除できない場合も、圧縮した写真を保存します。',
      'ライトテーマの補助テキストが読みやすくなりました。',
    ],
    Language.ko: [
      '일부 원본을 삭제할 수 없어도 압축한 사진을 저장합니다.',
      '라이트 테마에서 보조 텍스트를 더 쉽게 읽을 수 있습니다.',
    ],
    Language.nl: [
      'sla gecomprimeerde foto’s op, ook als sommige originelen niet kunnen worden verwijderd.',
      'secundaire tekst is beter leesbaar in het lichte thema.',
    ],
    Language.pt: [
      'salve as fotos comprimidas mesmo que alguns originais não possam ser excluídos.',
      'o texto secundário está mais legível no tema claro.',
    ],
    Language.ru: [
      'сжатые фото сохраняются, даже если некоторые оригиналы не удалось удалить.',
      'в светлой теме вспомогательный текст стал читабельнее.',
    ],
    Language.tr: [
      'bazı orijinaller silinemese bile sıkıştırılmış fotoğrafları kaydet.',
      'açık temada ikincil metin daha kolay okunuyor.',
    ],
    Language.zh: ['即使部分原照片无法删除，也会保存压缩后的照片。', '浅色模式中的辅助文字更易阅读。'],
  },
  '1.0.5': {
    Language.en: [
      'discover minimo for videos after compressing photos.',
      'clearer confirmation before leaving while photos are loading or results are unsaved.',
    ],
    Language.de: [
      'entdecke minimo für videos nach dem komprimieren von fotos.',
      'klarere bestätigung beim verlassen, während fotos laden oder ergebnisse ungespeichert sind.',
    ],
    Language.es: [
      'descubre minimo para vídeos después de comprimir fotos.',
      'confirmación más clara al salir mientras se cargan fotos o hay resultados sin guardar.',
    ],
    Language.fr: [
      'découvrez minimo pour les vidéos après la compression de photos.',
      'confirmation plus claire avant de quitter pendant le chargement ou avec des résultats non enregistrés.',
    ],
    Language.hi: [
      'फ़ोटो संपीड़ित करने के बाद वीडियो के लिए minimo खोजें।',
      'फ़ोटो लोड होते समय या परिणाम सहेजे बिना बाहर निकलने से पहले स्पष्ट पुष्टि।',
    ],
    Language.it: [
      'scopri minimo per i video dopo aver compresso le foto.',
      'conferma più chiara prima di uscire mentre le foto si caricano o i risultati non sono salvati.',
    ],
    Language.ja: [
      '写真の圧縮後に動画用のminimoを見つけられます。',
      '写真の読み込み中や結果の未保存時に、終了の確認がより分かりやすくなりました。',
    ],
    Language.ko: [
      '사진 압축 후 동영상용 minimo를 만나보세요.',
      '사진을 불러오는 중이거나 결과를 저장하지 않았을 때 종료 확인이 더 명확해졌습니다.',
    ],
    Language.nl: [
      'ontdek minimo voor video’s na het comprimeren van foto’s.',
      'duidelijkere bevestiging bij afsluiten terwijl foto’s laden of resultaten niet zijn opgeslagen.',
    ],
    Language.pt: [
      'conheça o minimo para vídeos após comprimir fotos.',
      'confirmação mais clara ao sair enquanto as fotos carregam ou há resultados não salvos.',
    ],
    Language.ru: [
      'после сжатия фото узнайте о minimo для видео.',
      'подтверждение выхода стало понятнее, когда фото загружаются или результат не сохранён.',
    ],
    Language.tr: [
      'fotoğrafları sıkıştırdıktan sonra videolar için minimo’yu keşfedin.',
      'fotoğraflar yüklenirken veya sonuçlar kaydedilmemişken çıkış onayı daha anlaşılır.',
    ],
    Language.zh: ['压缩照片后，了解视频版 minimo。', '照片加载中或结果尚未保存时，退出确认更加清晰。'],
  },
  '1.0.4': {
    Language.en: [
      "remove photo location while keeping other metadata. fixed minor bugs.",
    ],
    Language.de: [
      "entferne den standort aus fotos und behalte andere metadaten. kleinere fehler wurden behoben.",
    ],
    Language.es: [
      "elimina la ubicación de las fotos y conserva otros metadatos. se corrigieron errores menores.",
    ],
    Language.fr: [
      "supprimez la localisation des photos en conservant les autres métadonnées. des erreurs mineures ont été corrigées.",
    ],
    Language.hi: [
      "अन्य मेटाडेटा रखते हुए फ़ोटो की लोकेशन हटाएं। छोटी समस्याएं ठीक की गई हैं।",
    ],
    Language.it: [
      "rimuovi la posizione dalle foto e conserva gli altri metadati. corretti piccoli errori.",
    ],
    Language.ja: ["他のメタデータを残して写真の位置情報を削除できます。軽微な不具合を修正しました。"],
    Language.ko: ["다른 메타데이터는 유지하고 사진의 위치 정보를 제거할 수 있습니다. 사소한 오류를 수정했습니다."],
    Language.nl: [
      "verwijder de locatie uit foto's en behoud andere metagegevens. kleine fouten zijn verholpen.",
    ],
    Language.pt: [
      "remova a localização das fotos e mantenha os outros metadados. pequenos erros foram corrigidos.",
    ],
    Language.ru: [
      "удаляйте геолокацию фото, сохраняя остальные метаданные. исправлены небольшие ошибки.",
    ],
    Language.tr: [
      "diğer meta verileri koruyarak fotoğrafların konumunu kaldırın. küçük hatalar düzeltildi.",
    ],
    Language.zh: ["保留其他元数据的同时移除照片位置。修复了一些小问题。"],
  },
  '1.0.3': {
    Language.en: [
      'minimo now supports 13 languages. choose yours in settings or use your device language.',
    ],
    Language.de: [
      'minimo unterstützt jetzt 13 sprachen. wähle deine sprache in den einstellungen oder nutze die gerätesprache.',
    ],
    Language.es: [
      'minimo ya está disponible en 13 idiomas. elige el tuyo en ajustes o usa el idioma del dispositivo.',
    ],
    Language.fr: [
      'minimo est désormais disponible en 13 langues. choisissez la vôtre dans les réglages ou utilisez celle de votre appareil.',
    ],
    Language.hi: [
      'minimo अब 13 भाषाओं में उपलब्ध है। सेटिंग में अपनी भाषा चुनें या फ़ोन की भाषा का उपयोग करें।',
    ],
    Language.it: [
      'minimo ora supporta 13 lingue. scegli la tua nelle impostazioni o usa quella del dispositivo.',
    ],
    Language.ja: ['minimoが13言語に対応しました。設定で言語を選ぶか、端末の言語を使用できます。'],
    Language.ko: ['이제 minimo를 13개 언어로 사용할 수 있습니다. 설정에서 언어를 선택하거나 기기 언어를 따르세요.'],
    Language.nl: [
      'minimo ondersteunt nu 13 talen. kies je taal in de instellingen of gebruik de taal van je apparaat.',
    ],
    Language.pt: [
      'o minimo agora está disponível em 13 idiomas. escolha o seu nas configurações ou use o idioma do aparelho.',
    ],
    Language.ru: [
      'minimo теперь доступен на 13 языках. выберите язык в настройках или используйте язык устройства.',
    ],
    Language.tr: [
      'minimo artık 13 dili destekliyor. ayarlardan dilinizi seçin veya cihaz dilini kullanın.',
    ],
    Language.zh: ['minimo 现已支持 13 种语言。可在设置中选择语言，也可使用设备语言。'],
  },
  '1.0.2': {
    Language.en: [
      'adjust photo quality and maximum dimension with sliders in advanced mode.',
      'see a reminder to keep minimo open while compressing photos.',
      'select more photos at once from the gallery or files.',
    ],
    Language.ru: [
      'в продвинутом режиме качество и максимальный размер фото теперь настраиваются слайдерами.',
      'во время сжатия показывается напоминание не сворачивать minimo.',
      'выбирайте больше фото за раз из галереи или файлов.',
    ],
  },
  '1.0.1': {
    Language.en: [
      'share minimo with friends from the about screen.',
      'save compressed photos as new gallery items more reliably.',
    ],
    Language.ru: [
      'делитесь minimo с друзьями через экран «о приложении».',
      'улучшено сохранение сжатых фото как новых снимков в галерее.',
    ],
  },
};

List<String> unseenChanges({
  required String lastSeen,
  required String current,
  required Language language,
  Changelog changelog = _changelog,
}) {
  final lastSeenVersion = _tryParseVersion(lastSeen) ?? Version(0, 0, 0);
  final currentVersion = _tryParseVersion(current);
  if (currentVersion == null) return const [];

  final result = <String>[];
  final entries = <({Version version, Map<Language, List<String>> texts})>[];
  for (final entry in changelog.entries) {
    final entryVersion = _tryParseVersion(entry.key);
    if (entryVersion == null) continue;
    entries.add((version: entryVersion, texts: entry.value));
  }
  entries.sort((a, b) => a.version.compareTo(b.version));

  for (final entry in entries) {
    if (entry.version > lastSeenVersion && entry.version <= currentVersion) {
      result.addAll(entry.texts[language] ?? entry.texts[Language.en] ?? []);
    }
  }

  return result;
}

Version? _tryParseVersion(String value) {
  try {
    return Version.parse(value);
  } on FormatException {
    return null;
  }
}

class ChangelogUpdate {
  final String version;
  final List<String> changes;

  const ChangelogUpdate({required this.version, required this.changes});
}

class ChangelogService {
  static const _lastSeenVersionKey = 'last_seen_version';
  static final instance = ChangelogService();

  final Future<PackageInfo> Function() _packageInfo;
  final Future<SharedPreferences> Function() _preferences;
  final Changelog _changes;

  String? _currentVersion;

  ChangelogService({
    Future<PackageInfo> Function()? packageInfo,
    Future<SharedPreferences> Function()? preferences,
    Changelog changelog = _changelog,
  }) : _packageInfo = packageInfo ?? PackageInfo.fromPlatform,
       _preferences = preferences ?? SharedPreferences.getInstance,
       _changes = changelog;

  Future<ChangelogUpdate?> currentUpdate({required Language language}) async {
    final current = (await _packageInfo()).version;
    _currentVersion = current;
    final texts = _changes[current];
    if (texts == null) return null;

    final changes = texts[language] ?? texts[Language.en] ?? const [];
    if (changes.isEmpty) return null;
    return ChangelogUpdate(version: current, changes: changes);
  }

  Future<ChangelogUpdate?> initialize({required Language language}) async {
    final current = (await _packageInfo()).version;
    _currentVersion = current;

    final prefs = await _preferences();
    final lastSeenRaw = prefs.getString(_lastSeenVersionKey);
    final lastSeen = lastSeenRaw == null
        ? null
        : (_tryParseVersion(lastSeenRaw) == null ? null : lastSeenRaw);

    if (lastSeenRaw != null && lastSeen == null) {
      await prefs.remove(_lastSeenVersionKey);
    }

    if (lastSeen == null && await FirstLaunchService.shouldShowOnboarding()) {
      await prefs.setString(_lastSeenVersionKey, current);
      return null;
    }

    if (lastSeen == current) return null;

    final changes = unseenChanges(
      lastSeen: lastSeen ?? '0.0.0',
      current: current,
      language: language,
      changelog: _changes,
    );

    if (changes.isEmpty) {
      await prefs.setString(_lastSeenVersionKey, current);
      return null;
    }

    return ChangelogUpdate(version: current, changes: changes);
  }

  Future<void> markCurrentVersionSeen() async {
    final version = _currentVersion ?? (await _packageInfo()).version;
    final prefs = await _preferences();
    await prefs.setString(_lastSeenVersionKey, version);
  }

  Future<void> dismiss() async {
    await markCurrentVersionSeen();
  }
}
