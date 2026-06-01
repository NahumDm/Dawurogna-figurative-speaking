import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:flutter/material.dart';

class FavoriteProverbCard extends StatelessWidget {
  const FavoriteProverbCard({
    super.key,
    required this.proverb,
    required this.onTap,
    required this.onRemove,
  });

  final Proverb proverb;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label: proverb.dawuro,
      child: Material(
        color: scheme.surfaceContainerLow,
        elevation: 0,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 5, color: colors.brandRed),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proverb.dawuro,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          proverb.amharic,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remove from favorites',
                  icon: Icon(
                    Icons.favorite,
                    color: colors.brandRed,
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
