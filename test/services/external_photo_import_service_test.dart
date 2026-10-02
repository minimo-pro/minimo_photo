import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/services/external_photo_import_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('minimo_photo/external_photos');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  test(
    'imports shared photos with Shortcut quality and handles empty inbox',
    () async {
      var pending = true;
      messenger.setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'consumeExternalPhotos');
        if (!pending) return null;
        pending = false;
        return {
          'preset': 'low',
          'files': [
            {'path': '/tmp/shared.jpg', 'name': 'shared.jpg', 'size': 123},
          ],
        };
      });
      addTearDown(() => messenger.setMockMethodCallHandler(channel, null));

      final service = ExternalPhotoImportService();
      final import = await service.consume();
      expect(import?.photos.single.name, 'shared.jpg');
      expect(import?.settings.quality, 72);
      expect(import?.settings.maxDimension, 1600);
      expect(await service.consume(), isNull);
    },
  );
}
