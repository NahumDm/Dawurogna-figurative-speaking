import 'dart:io';

import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

/// Handles Google Play in-app updates for Android.
abstract final class InAppUpdateService {
  static Future<void> checkForUpdate(
    BuildContext context, {
    bool isManualTrigger = false,
  }) async {
    if (!Platform.isAndroid) {
      if (isManualTrigger && context.mounted) {
        _showFeedback(context, AppConstants.upToDateMessage);
      }
      return;
    }

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (!context.mounted) return;

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
          return;
        }

        if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
          return;
        }
      }

      if (isManualTrigger && context.mounted) {
        _showFeedback(context, AppConstants.upToDateMessage);
      }
    } catch (error) {
      if (isManualTrigger && context.mounted) {
        _showFeedback(
          context,
          'Could not check for updates: ${error.toString()}',
        );
      }
    }
  }

  static Future<void> resumeInterruptedUpdate() async {
    if (!Platform.isAndroid) return;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability ==
          UpdateAvailability.developerTriggeredUpdateInProgress) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (_) {
      // Ignore errors for the silent background resume check.
    }
  }

  static void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
