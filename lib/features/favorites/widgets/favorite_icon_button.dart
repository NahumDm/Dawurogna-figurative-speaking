import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// AppBar favorite toggle with Material 3 animation.
class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.proverbId,
    this.iconColor,
  });

  final String proverbId;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesController>();
    final isFavorite = favorites.isFavorite(proverbId);
    final color = iconColor ?? Theme.of(context).colorScheme.onPrimary;

    return Semantics(
      button: true,
      label: isFavorite
          ? AppConstants.removeFavoriteLabel
          : AppConstants.addFavoriteLabel,
      child: IconButton(
        tooltip: isFavorite
            ? AppConstants.removeFavoriteLabel
            : AppConstants.addFavoriteLabel,
        onPressed: () => favorites.toggleFavorite(proverbId),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            key: ValueKey<bool>(isFavorite),
            color: isFavorite ? Colors.red.shade300 : color,
          ),
        ),
      ),
    );
  }
}
