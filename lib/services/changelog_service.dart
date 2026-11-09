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
  '1.0.5': {
    Language.en: [
      'discover minimo for videos after compressing photos.',
      'clearer confirmation before leaving while photos are loading or results are unsaved.',
      'replacing originals no longer fails the whole save when some originals are unavailable.',
    ],
    Language.de: [
      'entdecke minimo für videos nach dem komprimieren von fotos.',
      'klarere bestätigung beim verlassen, während fotos laden oder ergebnisse ungespeichert sind.',
      'beim ersetzen von originalen schlägt das speichern nicht mehr komplett fehl, wenn einige originale nicht verfügbar sind.',
    ],
    Language.es: [
      'descubre minimo para vídeos después de comprimir fotos.',
      'confirmación más clara al salir mientras se cargan fotos o hay resultados sin guardar.',
      'al reemplazar originales, el guardado ya no falla por completo si algunos originales no están disponibles.',
    ],
    Language.fr: [
      'découvrez minimo pour les vidéos après la compression de photos.',
      'confirmation plus claire avant de quitter pendant le chargement ou avec des résultats non enregistrés.',
      "le remplacement des originaux n'échoue plus entièrement si certains originaux sont indisponibles.",
    ],
    Language.hi: [
      'फ़ोटो संपीड़ित करने के बाद वीडियो के लिए minimo खोजें।',
      'फ़ोटो लोड होते समय या परिणाम सहेजे बिना बाहर निकलने से पहले स्पष्ट पुष्टि।',
      'मूल बदलते समय कुछ मूल उपलब्ध न होने पर भी अब पूरी सेविंग विफल नहीं होती।',
    ],
    Language.it: [
      'scopri minimo per i video dopo aver compresso le foto.',
      'conferma più chiara prima di uscire mentre le foto si caricano o i risultati non sono salvati.',
      'sostituendo gli originali, il salvataggio non fallisce più del tutto se alcuni originali non sono disponibili.',
    ],
    Language.ja: [
      '写真の圧縮後に動画用のminimoを見つけられます。',
      '写真の読み込み中や結果の未保存時に、終了の確認がより分かりやすくなりました。',
      '一部の元の写真が利用できない場合でも、置き換え時の保存全体が失敗しなくなりました。',
    ],
    Language.ko: [
      '사진 압축 후 동영상용 minimo를 만나보세요.',
      '사진을 불러오는 중이거나 결과를 저장하지 않았을 때 종료 확인이 더 명확해졌습니다.',
      '일부 원본을 사용할 수 없어도 원본 교체 시 전체 저장이 실패하지 않습니다.',
    ],
    Language.nl: [
      'ontdek minimo voor video’s na het comprimeren van foto’s.',
      'duidelijkere bevestiging bij afsluiten terwijl foto’s laden of resultaten niet zijn opgeslagen.',
      'bij het vervangen van originelen mislukt opslaan niet meer volledig als sommige originelen niet beschikbaar zijn.',
    ],
    Language.pt: [
      'conheça o minimo para vídeos após comprimir fotos.',
      'confirmação mais clara ao sair enquanto as fotos carregam ou há resultados não salvos.',
      'ao substituir originais, o salvamento não falha mais por completo se alguns originais estiverem indisponíveis.',
    ],
    Language.ru: [
      'после сжатия фото узнайте о minimo для видео.',
      'подтверждение выхода стало понятнее, когда фото загружаются или результат не сохранён.',
      'замена оригиналов больше не срывает всё сохранение, если часть оригиналов недоступна.',
    ],
    Language.tr: [
      'fotoğrafları sıkıştırdıktan sonra videolar için minimo’yu keşfedin.',
      'fotoğraflar yüklenirken veya sonuçlar kaydedilmemişken çıkış onayı daha anlaşılır.',
      'orijinalleri değiştirirken bazı orijinaller kullanılamasa da kaydetme artık tamamen başarısız olmuyor.',
    ],
    Language.zh: [
      '压缩照片后，了解视频版 minimo。',
      '照片加载中或结果尚未保存时，退出确认更加清晰。',
      '替换原照片时，即使部分原照片不可用，也不会导致整体保存失败。',
    ],
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
