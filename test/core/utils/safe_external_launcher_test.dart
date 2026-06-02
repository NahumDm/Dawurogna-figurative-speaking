import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/utils/safe_external_launcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SafeExternalLauncher.isAllowed', () {
    test('allows mailto with valid address', () {
      expect(
        SafeExternalLauncher.isAllowed(
          Uri.parse('mailto:dev@example.com?subject=Hi'),
        ),
        isTrue,
      );
    });

    test('rejects mailto without address', () {
      expect(
        SafeExternalLauncher.isAllowed(Uri.parse('mailto:')),
        isFalse,
      );
    });

    test('allows Play Store and Telegram hosts', () {
      expect(
        SafeExternalLauncher.isAllowed(
          Uri.parse(
            'https://play.google.com/store/apps/details?id=com.example',
          ),
        ),
        isTrue,
      );
      expect(
        SafeExternalLauncher.isAllowed(Uri.parse('https://t.me/example')),
        isTrue,
      );
    });

    test('rejects unknown https hosts', () {
      expect(
        SafeExternalLauncher.isAllowed(Uri.parse('https://evil.example')),
        isFalse,
      );
    });

    test('rejects non-https schemes except mailto', () {
      expect(
        SafeExternalLauncher.isAllowed(Uri.parse('http://t.me/foo')),
        isFalse,
      );
    });

    test('allows app contact email and Telegram URLs', () {
      expect(
        SafeExternalLauncher.isAllowed(Uri.parse(AppConstants.developerEmail)),
        isTrue,
      );
      expect(
        SafeExternalLauncher.isAllowed(
          Uri.parse(AppConstants.developerTelegram),
        ),
        isTrue,
      );
    });
  });
}
