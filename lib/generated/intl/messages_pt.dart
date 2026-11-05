// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(prefix) => "adicionar o prefixo \"${prefix}\"";

  static String m1(prefix) =>
      "adiciona \"${prefix}\" antes do nome original. ao desativar, mantém o nome original";

  static String m2(version) => "novidades da versão ${version}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'falta cerca de 1 minuto', other: 'faltam cerca de ${count} minutos')}";

  static String m4(current, total) => "foto ${current} de ${total}";

  static String m5(completed, total) =>
      "${completed} de fotos ${total} compactadas";

  static String m6(count) => "salvar fotos ${count}";

  static String m7(album) =>
      "salva fotos compactadas no álbum ${album} em vez de salvas recentemente";

  static String m8(error) =>
      "fotos salvas, mas alguns originais não puderam ser excluídos: ${error}";

  static String m9(saved, deleted) =>
      "salvou fotos ${saved} e excluiu originais ${deleted}";

  static String m10(count) => "salvou fotos ${count} na galeria";

  static String m11(error) => "fotos salvas com alguns problemas: ${error}";

  static String m12(count) =>
      "${Intl.plural(count, one: 'falta cerca de 1 segundo', other: 'faltam cerca de ${count} segundos')}";

  static String m13(url) =>
      "experimente o minimo (foto) – um aplicativo simples para diminuir o tamanho das fotos no seu telefone: ${url}";

  static String m14(size) => "você economizou ${size}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("sobre"),
    "aboutStory": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) nasceu de uma simples frustração.\n\neste projeto oferece a todos uma maneira conveniente e gratuita de compactar fotos diretamente em um dispositivo móvel, economizar armazenamento e manter os momentos que importam.",
    ),
    "addPrefix": m0,
    "addPrefixDescription": m1,
    "advancedOptions": MessageLookupByLibrary.simpleMessage("avançado"),
    "alreadyOptimized": MessageLookupByLibrary.simpleMessage(
      "nenhuma economia útil",
    ),
    "alreadyOptimizedDescription": MessageLookupByLibrary.simpleMessage(
      "essas configurações não reduziram o arquivo em pelo menos 10%. tente qualidade ou dimensões inferiores.",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("minimo (photo)"),
    "automatic": MessageLookupByLibrary.simpleMessage("auto"),
    "backgroundCompressionWarning": MessageLookupByLibrary.simpleMessage(
      "mantenha o mínimo aberto até que a compressão termine. seu telefone pode pausar o aplicativo se você sair",
    ),
    "better": MessageLookupByLibrary.simpleMessage("melhor"),
    "cacheClearFailed": MessageLookupByLibrary.simpleMessage(
      "não foi possível limpar o cache",
    ),
    "cacheCleared": MessageLookupByLibrary.simpleMessage("cache limpo"),
    "cancel": MessageLookupByLibrary.simpleMessage("cancelar"),
    "changelogDone": MessageLookupByLibrary.simpleMessage("entendi"),
    "changelogSubtitle": MessageLookupByLibrary.simpleMessage(
      "mudanças de atualizações que você ainda não viu",
    ),
    "changelogTitle": m2,
    "clearCache": MessageLookupByLibrary.simpleMessage("limpar cache"),
    "clearCacheDescription": MessageLookupByLibrary.simpleMessage(
      "remove arquivos temporários de aplicativos. as fotos salvas na sua galeria permanecem intactas",
    ),
    "comparePhotos": MessageLookupByLibrary.simpleMessage("comparar"),
    "compress": MessageLookupByLibrary.simpleMessage("comprimir"),
    "compressed": MessageLookupByLibrary.simpleMessage("comprimido"),
    "compressedPhoto": MessageLookupByLibrary.simpleMessage("depois"),
    "compressing": MessageLookupByLibrary.simpleMessage("comprimindo..."),
    "compressionCancelled": MessageLookupByLibrary.simpleMessage(
      "compressão cancelada",
    ),
    "compressionComplete": MessageLookupByLibrary.simpleMessage(
      "compressão concluída",
    ),
    "compressionCompleted": MessageLookupByLibrary.simpleMessage(
      "compressão concluída",
    ),
    "compressionFailed": MessageLookupByLibrary.simpleMessage(
      "falha na compressão",
    ),
    "compressionFailedDescription": MessageLookupByLibrary.simpleMessage(
      "não foi possível compactar esta foto. tente novamente ou escolha outro.",
    ),
    "darkTheme": MessageLookupByLibrary.simpleMessage("tema escuro"),
    "darkThemeDescription": MessageLookupByLibrary.simpleMessage(
      "usar aparência escura",
    ),
    "detailLevel": MessageLookupByLibrary.simpleMessage("qualidade da foto"),
    "detailLevelDescription": MessageLookupByLibrary.simpleMessage(
      "defina uma qualidade alvo ou deixe a predefinição de qualidade escolhê-la",
    ),
    "emailCopied": MessageLookupByLibrary.simpleMessage("e-mail copiado"),
    "english": MessageLookupByLibrary.simpleMessage("english"),
    "estimatingTimeRemaining": MessageLookupByLibrary.simpleMessage(
      "calculando o tempo restante...",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("falhou"),
    "failedToPickPhotos": MessageLookupByLibrary.simpleMessage(
      "escolha um arquivo de foto",
    ),
    "failedToSave": MessageLookupByLibrary.simpleMessage(
      "não foi possível salvar as fotos. tente novamente",
    ),
    "failedToShare": MessageLookupByLibrary.simpleMessage(
      "não foi possível compartilhar as fotos. tente novamente",
    ),
    "formatFallbackNotice": MessageLookupByLibrary.simpleMessage(
      "heic não estava disponível, então esta foto foi salva como jpeg",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("começar"),
    "githubRepository": MessageLookupByLibrary.simpleMessage(
      "repositório no github",
    ),
    "good": MessageLookupByLibrary.simpleMessage("boa"),
    "high": MessageLookupByLibrary.simpleMessage("alta"),
    "holdToCancelCompression": MessageLookupByLibrary.simpleMessage(
      "mantenha o botão pressionado para cancelar a compressão",
    ),
    "holdToClearCache": MessageLookupByLibrary.simpleMessage(
      "mantenha o botão pressionado para limpar o cache",
    ),
    "holdToDeleteOriginals": MessageLookupByLibrary.simpleMessage(
      "mantenha o botão pressionado para excluir os originais",
    ),
    "howCompressionWorksBody": MessageLookupByLibrary.simpleMessage(
      "minimo faz uma nova cópia da sua foto e a armazena com mais eficiência. pode reduzir a qualidade ou as dimensões da imagem, mantendo o resultado útil.\n\nqualidade inferior armazena menos pequenos detalhes que são difíceis de notar. dimensões menores usam menos pixels. ambos reduzem o tamanho do arquivo.\n\nsua foto original permanece intacta e a compactação ocorre no seu dispositivo.",
    ),
    "howCompressionWorksTitle": MessageLookupByLibrary.simpleMessage(
      "como a foto fica menor",
    ),
    "keepExif": MessageLookupByLibrary.simpleMessage("manter metadados exif"),
    "keepMetadata": MessageLookupByLibrary.simpleMessage("metadados"),
    "keepMetadataDescription": MessageLookupByLibrary.simpleMessage(
      "preservar informações da câmera e exif quando suportado",
    ),
    "keepMetadataLegacy": MessageLookupByLibrary.simpleMessage(
      "manter metadados",
    ),
    "language": MessageLookupByLibrary.simpleMessage("idioma"),
    "languageDescription": MessageLookupByLibrary.simpleMessage(
      "escolha o idioma do app",
    ),
    "loadingManyPhotosHint": MessageLookupByLibrary.simpleMessage(
      "baixar do armazenamento em nuvem ou copiar arquivos grandes pode demorar mais",
    ),
    "loadingPhotos": MessageLookupByLibrary.simpleMessage(
      "carregando fotos...",
    ),
    "low": MessageLookupByLibrary.simpleMessage("baixa"),
    "madeByKhlebobul": MessageLookupByLibrary.simpleMessage("por khlebobul"),
    "maximumDimension": MessageLookupByLibrary.simpleMessage("dimensão máxima"),
    "maximumDimensionDescription": MessageLookupByLibrary.simpleMessage(
      "limite o lado mais longo da imagem; valores menores economizam mais espaço",
    ),
    "medium": MessageLookupByLibrary.simpleMessage("média"),
    "metadataMode": MessageLookupByLibrary.simpleMessage("modo de metadados"),
    "metadataModeDescription": MessageLookupByLibrary.simpleMessage(
      "mantenha as informações da câmera e EXIF quando compatível ou remova-as",
    ),
    "metadataPreservationIncomplete": MessageLookupByLibrary.simpleMessage(
      "alguns metadados da galeria não puderam ser copiados",
    ),
    "minutesRemaining": m3,
    "myOtherApps": MessageLookupByLibrary.simpleMessage("meus outros apps"),
    "myWebsite": MessageLookupByLibrary.simpleMessage("meu site"),
    "next": MessageLookupByLibrary.simpleMessage("próximo"),
    "noSavingsHint": MessageLookupByLibrary.simpleMessage(
      "tente outro modo — este não vai diminuir o tamanho",
    ),
    "onboardingPickDescription": MessageLookupByLibrary.simpleMessage(
      "escolha uma ou várias fotos. minimo funciona com arquivos locais e mantém os originais intactos",
    ),
    "onboardingPickTitle": MessageLookupByLibrary.simpleMessage(
      "escolha fotos",
    ),
    "onboardingQualityDescription": MessageLookupByLibrary.simpleMessage(
      "escolha uma predefinição de qualidade ou ajuste dimensões e metadados manualmente",
    ),
    "onboardingQualityTitle": MessageLookupByLibrary.simpleMessage(
      "escolha o que mudar",
    ),
    "onboardingSaveDescription": MessageLookupByLibrary.simpleMessage(
      "a compactação acontece no seu dispositivo. as fotos não são carregadas em lugar nenhum; salve a cópia menor quando gostar do resultado",
    ),
    "onboardingSaveTitle": MessageLookupByLibrary.simpleMessage(
      "privado por padrão",
    ),
    "openSourceNote": MessageLookupByLibrary.simpleMessage(
      "minimo (foto) é de código aberto. explore o código, acompanhe o projeto ou entre em contato",
    ),
    "original": MessageLookupByLibrary.simpleMessage("original"),
    "originalDeletionFailed": MessageLookupByLibrary.simpleMessage(
      "alguns originais não puderam ser excluídos",
    ),
    "originalPhoto": MessageLookupByLibrary.simpleMessage("antes"),
    "outputFormat": MessageLookupByLibrary.simpleMessage("formato de saída"),
    "outputFormatDescription": MessageLookupByLibrary.simpleMessage(
      "jpeg funciona em qualquer lugar; heic pode ser menor, mas pode voltar para jpeg",
    ),
    "overheatWarning": MessageLookupByLibrary.simpleMessage(
      "a compressão pode ficar mais lenta se o dispositivo esquentar",
    ),
    "photoPreviewUnavailable": MessageLookupByLibrary.simpleMessage(
      "visualização indisponível",
    ),
    "photoProgress": m4,
    "photoQualityDescription": MessageLookupByLibrary.simpleMessage(
      "qualidade superior mantém mais detalhes e cria um arquivo maior",
    ),
    "photoQualityHighDescription": MessageLookupByLibrary.simpleMessage(
      "mantenha detalhes e dimensões originais",
    ),
    "photoQualityLowDescription": MessageLookupByLibrary.simpleMessage(
      "arquivos menores para compartilhar",
    ),
    "photoQualityMediumDescription": MessageLookupByLibrary.simpleMessage(
      "qualidade e tamanho de arquivo equilibrados",
    ),
    "photosCompressed": m5,
    "photosCompressedStat": MessageLookupByLibrary.simpleMessage(
      "fotos compactadas",
    ),
    "pickFromFiles": MessageLookupByLibrary.simpleMessage("dos arquivos"),
    "pickFromGallery": MessageLookupByLibrary.simpleMessage("da galeria"),
    "preventScreenSleep": MessageLookupByLibrary.simpleMessage(
      "manter a tela ligada",
    ),
    "preventScreenSleepDescription": MessageLookupByLibrary.simpleMessage(
      "evita que a tela hiberne enquanto as fotos estão sendo carregadas ou compactadas",
    ),
    "projectWebsite": MessageLookupByLibrary.simpleMessage("site do projeto"),
    "quality": MessageLookupByLibrary.simpleMessage("qualidade"),
    "qualityReducedDescription": MessageLookupByLibrary.simpleMessage(
      "a qualidade será reduzida para economizar espaço",
    ),
    "rateTheApp": MessageLookupByLibrary.simpleMessage("avaliar o app"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "remover localização",
    ),
    "removeLocationDescription": MessageLookupByLibrary.simpleMessage(
      "remover a localização das fotos salvas e manter os outros metadados",
    ),
    "replaceOriginal": MessageLookupByLibrary.simpleMessage(
      "substituir o original",
    ),
    "replaceOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "salve com os metadados originais e peça para excluir o original",
    ),
    "resize": MessageLookupByLibrary.simpleMessage("dimensões da imagem"),
    "resizeDescription": MessageLookupByLibrary.simpleMessage(
      "limite o lado mais longo da imagem; dimensões menores economizam mais espaço",
    ),
    "resolution": MessageLookupByLibrary.simpleMessage("resolução"),
    "resolutionDescription": MessageLookupByLibrary.simpleMessage(
      "reduza as dimensões para economizar o máximo de espaço",
    ),
    "resolutionReducedHdDescription": MessageLookupByLibrary.simpleMessage(
      "a resolução será reduzida para hd",
    ),
    "resolutionReducedSdDescription": MessageLookupByLibrary.simpleMessage(
      "a resolução será reduzida para sd",
    ),
    "russian": MessageLookupByLibrary.simpleMessage("русский"),
    "save": MessageLookupByLibrary.simpleMessage("salvar"),
    "saveAsNew": MessageLookupByLibrary.simpleMessage("salvar como novo"),
    "saveAsNewDescription": MessageLookupByLibrary.simpleMessage(
      "mantenha o original e salve uma nova foto da galeria",
    ),
    "saveBesideOriginal": MessageLookupByLibrary.simpleMessage(
      "salvar ao lado do original",
    ),
    "saveBesideOriginalDescription": MessageLookupByLibrary.simpleMessage(
      "manter o original e copiar a data e os metadados dele",
    ),
    "saveOptionsTitle": MessageLookupByLibrary.simpleMessage("como salvar"),
    "savePhotos": m6,
    "savePhotosToAlbum": MessageLookupByLibrary.simpleMessage(
      "salvar fotos no álbum",
    ),
    "savePhotosToAlbumDescription": m7,
    "saved": MessageLookupByLibrary.simpleMessage("salvo"),
    "savedButOriginalsNotDeleted": m8,
    "savedPhotosAndDeletedOriginals": m9,
    "savedPhotosToGallery": m10,
    "savedWithWarnings": m11,
    "secondsRemaining": m12,
    "settings": MessageLookupByLibrary.simpleMessage("configurações"),
    "share": MessageLookupByLibrary.simpleMessage("compartilhar"),
    "shareAppText": m13,
    "shareOrSave": MessageLookupByLibrary.simpleMessage(
      "compartilhar ou salvar em…",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "compartilhar com amigos",
    ),
    "showOverheatWarning": MessageLookupByLibrary.simpleMessage(
      "mostrar aviso de superaquecimento",
    ),
    "showOverheatWarningDescription": MessageLookupByLibrary.simpleMessage(
      "mostra um pequeno aviso durante a compressão quando o dispositivo pode ficar mais lento",
    ),
    "simpleOptions": MessageLookupByLibrary.simpleMessage("simples"),
    "skip": MessageLookupByLibrary.simpleMessage("pular"),
    "small": MessageLookupByLibrary.simpleMessage("pequeno"),
    "smaller": MessageLookupByLibrary.simpleMessage("menor"),
    "spaceSavedStat": MessageLookupByLibrary.simpleMessage(
      "espaço economizado",
    ),
    "statistics": MessageLookupByLibrary.simpleMessage("estatísticas"),
    "statisticsSinceVersion": MessageLookupByLibrary.simpleMessage(
      "as estatísticas são armazenadas localmente neste dispositivo.",
    ),
    "stripMetadata": MessageLookupByLibrary.simpleMessage("remover metadados"),
    "system": MessageLookupByLibrary.simpleMessage("sistema"),
    "todo": MessageLookupByLibrary.simpleMessage("fazer"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("tentar novamente"),
    "unsavedResultsExit": MessageLookupByLibrary.simpleMessage(
      "sair e excluir fotos compactadas não salvas?",
    ),
    "unsavedResultsTitle": MessageLookupByLibrary.simpleMessage(
      "fotos não salvas",
    ),
    "videoAppDescription": MessageLookupByLibrary.simpleMessage(
      "diminua o tamanho dos vídeos diretamente no seu telefone",
    ),
    "waiting": MessageLookupByLibrary.simpleMessage("aguardando"),
    "xTwitter": MessageLookupByLibrary.simpleMessage("x (twitter)"),
    "youSavedSize": m14,
  };
}
