import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Validates and launches external URLs with host allowlisting.
abstract final class SafeExternalLauncher {
  static const String launchFailedMessage =
      'Could not open this link on your device.';

  static final Set<String> _allowedHttpsHosts = {
    'play.google.com',
    't.me',
    'telegram.me',
    'telegram.org',
  };

  static bool isAllowed(Uri uri) {
    if (uri.scheme == 'mailto') {
      return _mailtoAddress(uri).contains('@');
    }
    if (uri.scheme != 'https') return false;
    final host = uri.host.toLowerCase();
    return _allowedHttpsHosts.any(
      (allowed) => host == allowed || host.endsWith('.$allowed'),
    );
  }

  /// Resolves the email target from a [mailto] URI (Dart may leave [path] empty).
  static String _mailtoAddress(Uri uri) {
    if (uri.path.isNotEmpty) return uri.path;
    if (uri.pathSegments.isNotEmpty) return uri.pathSegments.first;
    final withoutScheme = uri.toString().replaceFirst(
      RegExp(r'^mailto:', caseSensitive: false),
      '',
    );
    return withoutScheme.split('?').first;
  }

  static Future<bool> launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    if (!isAllowed(uri)) return false;

    // Allowlisted links only — skip [canLaunchUrl], which often returns false on
    // Android 11+ without manifest <queries> even when a handler exists.
    try {
      return await launchUrl(uri, mode: mode);
    } catch (_) {
      return false;
    }
  }

  static Future<bool> launchWithFeedback(
    BuildContext context,
    Uri uri, {
    LaunchMode mode = LaunchMode.externalApplication,
    String? failureMessage,
  }) async {
    final success = await launch(uri, mode: mode);
    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failureMessage ?? launchFailedMessage)),
      );
    }
    return success;
  }
}
