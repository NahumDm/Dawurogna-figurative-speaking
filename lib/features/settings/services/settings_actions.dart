import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/contact_bottom_sheet.dart';
import 'package:dawurogna_figurative_speaking/core/utils/safe_external_launcher.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:upgrader/upgrader.dart';

/// Shared actions for update, share, and contact flows.
abstract final class SettingsActions {
  static Future<void> checkForUpdate(BuildContext context) async {
    final upgrader = Upgrader();
    await upgrader.initialize();

    if (!context.mounted) return;

    if (upgrader.isUpdateAvailable()) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text(AppConstants.updateAvailableTitle),
          content: Text(
            upgrader.releaseNotes ?? AppConstants.updateAvailableBody,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(AppConstants.updateLaterLabel),
            ),
            FilledButton(
              onPressed: () async {
                final url = upgrader.currentAppStoreListingURL;
                if (url != null) {
                  await SafeExternalLauncher.launchWithFeedback(
                    dialogContext,
                    Uri.parse(url),
                  );
                }
              },
              child: const Text(AppConstants.updateNowLabel),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppConstants.upToDateMessage)),
      );
    }
  }

  static Future<void> shareApp() async {
    await SharePlus.instance.share(
      ShareParams(uri: Uri.parse(AppConstants.playStoreUrl)),
    );
  }

  static Future<void> showContactDeveloper(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const ContactBottomSheet(),
    );
  }
}
