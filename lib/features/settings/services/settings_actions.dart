import 'package:dawurogna_figurative_speaking/core/widgets/contact_bottom_sheet.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/utils/safe_external_launcher.dart';
import 'package:dawurogna_figurative_speaking/features/settings/services/in_app_update_service.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

/// Shared actions for update, share, and contact flows.
abstract final class SettingsActions {
  static Future<void> checkForUpdate(BuildContext context) async {
    await InAppUpdateService.checkForUpdate(context, isManualTrigger: true);
  }

  static Future<void> shareApp() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final playStoreUrl =
        'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';

    await SharePlus.instance.share(ShareParams(uri: Uri.parse(playStoreUrl)));
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

  static Future<void> openPrivacyPolicy(BuildContext context) async {
    await SafeExternalLauncher.launchWithFeedback(
      context,
      Uri.parse(AppConstants.privacyPolicyUrl),
    );
  }

  static Future<void> reportIncorrectProverb(BuildContext context) async {
    const subject = 'Report an incorrect proverb';
    const body =
        'Please include the proverb, the part that is incorrect, and the suggested correction.';

    // Encode spaces as %20 rather than + because some email clients do not
    // decode form-style query parameters in mailto links.
    final uri = Uri.parse(
      'mailto:${AppConstants.reportIncorrectProverbEmail}'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(body)}',
    );
    await SafeExternalLauncher.launchWithFeedback(context, uri);
  }
}
