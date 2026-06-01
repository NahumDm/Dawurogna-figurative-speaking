import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/theme/theme_controller.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/staggered_entrance.dart';
import 'package:dawurogna_figurative_speaking/features/settings/services/settings_actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final maxWidth = Responsive.contentMaxWidth(context);
    final padding = AppSpacing.screenPadding(context);
    final sectionGap = AppSpacing.sectionGap(context);

    return Scaffold(
      appBar: AppBar(
        title: const DawuroAppBarTitle(AppConstants.settingsTitle),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView(
              padding: padding,
              children: [
                StaggeredEntrance(
                  index: 0,
                  child: _AppearanceHeroCard(
                    isDark: themeController.isDarkMode,
                    onChanged: themeController.setDarkMode,
                  ),
                ),
                SizedBox(height: sectionGap),
                StaggeredEntrance(
                  index: 1,
                  child: _SettingsGroup(
                    title: AppConstants.settingsAppSection,
                    children: [
                      _SettingsTile(
                        icon: Icons.system_update_rounded,
                        iconTint: context.appColors.brandRed,
                        title: AppConstants.checkForUpdateLabel,
                        subtitle: AppConstants.settingsUpdateSubtitle,
                        onTap: () => SettingsActions.checkForUpdate(context),
                        animationIndex: 2,
                      ),
                      _SettingsTile(
                        icon: Icons.share_rounded,
                        iconTint: context.appColors.brandRed,
                        title: AppConstants.shareAppLabel,
                        subtitle: AppConstants.settingsShareSubtitle,
                        onTap: SettingsActions.shareApp,
                        animationIndex: 3,
                      ),
                      _SettingsTile(
                        icon: Icons.mail_outline_rounded,
                        iconTint: context.appColors.brandRed,
                        title: AppConstants.contactDeveloperLabel,
                        subtitle: AppConstants.settingsContactSubtitle,
                        onTap: () =>
                            SettingsActions.showContactDeveloper(context),
                        animationIndex: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sectionGap),
                StaggeredEntrance(
                  index: 5,
                  child: _SettingsFooter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppearanceHeroCard extends StatelessWidget {
  const _AppearanceHeroCard({
    required this.isDark,
    required this.onChanged,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;

    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.brandRed.withValues(alpha: isDark ? 0.35 : 0.12),
              scheme.surfaceContainerLow,
              colors.brandGold.withValues(alpha: isDark ? 0.2 : 0.1),
            ],
          ),
          border: Border.all(
            color: scheme.outline.withValues(alpha: 0.15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colors.brandRed.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeIn,
                  child: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    key: ValueKey(isDark),
                    color: colors.brandRed,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.settingsAppearanceSection,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.darkModeLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppConstants.darkModeSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: isDark,
                onChanged: onChanged,
                activeThumbColor: scheme.onPrimary,
                activeTrackColor: colors.brandRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xs,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Material(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Column(children: _withDividers(children, theme)),
        ),
      ],
    );
  }

  List<Widget> _withDividers(List<Widget> items, ThemeData theme) {
    if (items.length <= 1) return items;
    final result = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(
          Divider(
            height: 1,
            indent: 72,
            endIndent: AppSpacing.md,
            color: theme.dividerColor.withValues(alpha: 0.5),
          ),
        );
      }
    }
    return result;
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconTint,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.animationIndex,
  });

  final IconData icon;
  final Color iconTint;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final int animationIndex;

  @override
  Widget build(BuildContext context) {
    return StaggeredEntrance(
      index: animationIndex,
      child: Semantics(
        button: true,
        label: title,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 14,
            ),
            child: Row(
              children: [
                _IconBadge(icon: icon, tint: iconTint),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.tint});

  final IconData icon;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: tint, size: 22),
    );
  }
}

class _SettingsFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        AppConstants.settingsFooterHint,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
          height: 1.45,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
