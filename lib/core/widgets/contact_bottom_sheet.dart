import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/staggered_entrance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Brand colors for third-party contact channels (official palette).
abstract final class _ContactChannelColors {
  static const Color email = Color(0xFFEA4335);
  static const Color telegram = Color(0xFF229ED9);
}

/// Contact developer bottom sheet with branded layout and entrance motion.
class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({super.key});

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;
    final media = MediaQuery.of(context);
    final bottomInset = media.padding.bottom;
    final viewInsets = media.viewInsets.bottom;
    final compact = media.size.height < 700 || Responsive.isCompact(context);

    final gapLg = compact ? AppSpacing.md : AppSpacing.lg;
    final gapMd = compact ? AppSpacing.sm : AppSpacing.md;
    final iconSize = compact ? 60.0 : 72.0;

    // Cap height so content scrolls on small screens / with keyboard open.
    final maxHeight = media.size.height * 0.92 - media.padding.top;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md + bottomInset,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _BrandStripe(colors: colors, scheme: scheme),
                SizedBox(height: gapLg),
                StaggeredEntrance(
                  index: 0,
                  child: _HeaderIllustration(
                    colors: colors,
                    size: iconSize,
                  ),
                ),
                SizedBox(height: gapMd),
                StaggeredEntrance(
                  index: 1,
                  child: Text(
                    AppConstants.contactSheetTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 18 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                StaggeredEntrance(
                  index: 2,
                  child: Text(
                    AppConstants.contactSheetSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.45,
                      fontSize: compact ? 13 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: gapLg),
                StaggeredEntrance(
                  index: 3,
                  child: _ContactActionCard(
                    icon: FontAwesomeIcons.solidEnvelope,
                    iconColor: _ContactChannelColors.email,
                    title: AppConstants.contactEmailTitle,
                    description: AppConstants.contactEmailDescription,
                    compact: compact,
                    onTap: () async {
                      await _launchUrl(AppConstants.developerEmail);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                StaggeredEntrance(
                  index: 4,
                  child: _ContactActionCard(
                    icon: FontAwesomeIcons.telegram,
                    iconColor: _ContactChannelColors.telegram,
                    title: AppConstants.contactTelegramTitle,
                    description: AppConstants.contactTelegramDescription,
                    compact: compact,
                    onTap: () async {
                      await _launchUrl(AppConstants.developerTelegram);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: gapMd),
                StaggeredEntrance(
                  index: 5,
                  child: Text(
                    AppConstants.contactSheetFooter,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                      fontSize: compact ? 11 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandStripe extends StatelessWidget {
  const _BrandStripe({required this.colors, required this.scheme});

  final AppColors colors;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Expanded(child: Container(height: 4, color: colors.brandRed)),
          Expanded(child: Container(height: 4, color: colors.brandGold)),
          Expanded(child: Container(height: 4, color: scheme.onSurface)),
        ],
      ),
    );
  }
}

class _HeaderIllustration extends StatelessWidget {
  const _HeaderIllustration({required this.colors, required this.size});

  final AppColors colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.brandRed.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.brandRed.withValues(alpha: 0.25),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.favorite_outline_rounded,
        size: size * 0.5,
        color: colors.brandRed,
      ),
    );
  }
}

class _ContactActionCard extends StatefulWidget {
  const _ContactActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
    required this.compact,
  });

  final FaIconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<_ContactActionCard> createState() => _ContactActionCardState();
}

class _ContactActionCardState extends State<_ContactActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final verticalPad = widget.compact ? 10.0 : 14.0;
    final badgeSize = widget.compact ? 42.0 : 48.0;

    return Semantics(
      button: true,
      label: widget.title,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Material(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: (highlighted) {
              setState(() => _pressed = highlighted);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: verticalPad,
              ),
              child: Row(
                children: [
                  Container(
                    width: badgeSize,
                    height: badgeSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.iconColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      widget.icon,
                      color: widget.iconColor,
                      size: widget.compact ? 22 : 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: widget.compact ? 14 : null,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.35,
                            fontSize: widget.compact ? 11 : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                    size: widget.compact ? 20 : 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
