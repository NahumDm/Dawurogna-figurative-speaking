import 'dart:ui';

import 'package:dawurogna_figurative_speaking/core/constants/app_constants.dart';
import 'package:dawurogna_figurative_speaking/core/constants/app_spacing.dart';
import 'package:dawurogna_figurative_speaking/core/theme/app_colors.dart';
import 'package:dawurogna_figurative_speaking/core/utils/responsive.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/dawuro_app_bar_title.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/empty_state_view.dart';
import 'package:dawurogna_figurative_speaking/core/widgets/staggered_entrance.dart';
import 'package:dawurogna_figurative_speaking/data/models/proverb.dart';
import 'package:dawurogna_figurative_speaking/features/favorites/widgets/favorite_icon_button.dart';
import 'package:dawurogna_figurative_speaking/features/proverbs/proverbs_controller.dart';
import 'package:dawurogna_figurative_speaking/features/sharing/services/proverb_share_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProverbDetailScreen extends StatelessWidget {
  const ProverbDetailScreen({super.key, required this.proverbId});

  final String proverbId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProverbsController>();
    final proverb = controller.getProverbById(proverbId);

    if (proverb == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 20),
          ),
          title: const DawuroAppBarTitle(AppConstants.appTitle),
        ),
        body: const EmptyStateView(message: 'Proverb not found.'),
      );
    }

    final allProverbs = controller.allProverbs;
    final currentIndex = allProverbs.indexWhere((p) => p.id == proverb.id);
    final hasNext = currentIndex >= 0 && currentIndex < allProverbs.length - 1;
    final hasPrevious = currentIndex > 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: context.appColors.appBarTitleOnOverlay,
        iconTheme: IconThemeData(
          color: context.appColors.appBarTitleOnOverlay,
        ),
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/eachAlphabetList/${proverb.letter}');
            }
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 20),
          tooltip: 'Back',
        ),
        title: DawuroAppBarTitle(
          AppConstants.appTitle,
          color: context.appColors.appBarTitleOnOverlay,
        ),
        actions: [
          FavoriteIconButton(
            proverbId: proverb.id,
            iconColor: context.appColors.appBarTitleOnOverlay,
          ),
          IconButton(
            tooltip: AppConstants.shareProverbLabel,
            onPressed: () => ProverbShareService.share(proverb),
            icon: Icon(
              Icons.share_outlined,
              color: context.appColors.appBarTitleOnOverlay,
            ),
          ),
        ],
      ),
      body: _ProverbDetailBody(
        proverb: proverb,
        listIndex: currentIndex,
        listTotal: allProverbs.length,
        hasNext: hasNext,
        hasPrevious: hasPrevious,
        onPrevious: hasPrevious
            ? () => _navigateTo(context, allProverbs[currentIndex - 1].id, -1)
            : null,
        onNext: hasNext
            ? () => _navigateTo(context, allProverbs[currentIndex + 1].id, 1)
            : null,
      ),
    );
  }

  void _navigateTo(BuildContext context, String id, double directionX) {
    context.pushReplacement(
      '/tale/$id',
      extra: Offset(directionX, 0),
    );
  }
}

class _ProverbDetailBody extends StatelessWidget {
  const _ProverbDetailBody({
    required this.proverb,
    required this.listIndex,
    required this.listTotal,
    required this.hasNext,
    required this.hasPrevious,
    required this.onPrevious,
    required this.onNext,
  });

  final Proverb proverb;
  final int listIndex;
  final int listTotal;
  final bool hasNext;
  final bool hasPrevious;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textScale = MediaQuery.textScalerOf(context);
    final maxWidth = Responsive.contentMaxWidth(context);
    final horizontal = Responsive.horizontalPadding(context);
    final showPosition = listIndex >= 0 && listTotal > 0;

    return Stack(
      fit: StackFit.expand,
      children: [
        const _CulturalBackdrop(),
        const _CulturalGradientOverlay(),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    horizontal,
                    56,
                    horizontal,
                    AppSpacing.md,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: StaggeredEntrance(
                        index: 0,
                        child: _DetailContentCard(
                          proverb: proverb,
                          textScale: textScale,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _DetailNavBar(
                colors: colors,
                showPosition: showPosition,
                positionLabel: showPosition
                    ? AppConstants.detailPositionLabel(
                        listIndex + 1,
                        listTotal,
                      )
                    : null,
                hasPrevious: hasPrevious,
                hasNext: hasNext,
                onPrevious: onPrevious,
                onNext: onNext,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Full-bleed [dawuro_gihibli.png] — Dawuro regional musical instrument.
class _CulturalBackdrop extends StatelessWidget {
  const _CulturalBackdrop();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppConstants.culturalImageAsset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      semanticLabel: AppConstants.detailCulturalImageLabel,
      errorBuilder: (_, _, _) => ColoredBox(
        color: Colors.grey.shade900,
        child: Center(
          child: Icon(
            Icons.music_note_rounded,
            size: 72,
            color: Colors.white.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }
}

/// Keeps the instrument visible while ensuring text contrast.
class _CulturalGradientOverlay extends StatelessWidget {
  const _CulturalGradientOverlay();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.35, 0.65, 1.0],
          colors: [
            Colors.black.withValues(alpha: 0.54),
            Colors.black.withValues(alpha: 0.24),
            Colors.black.withValues(alpha: 0.30),
            Colors.black.withValues(alpha: 0.64),
          ],
        ),
      ),
    );
  }
}

class _DetailContentCard extends StatelessWidget {
  const _DetailContentCard({
    required this.proverb,
    required this.textScale,
  });

  final Proverb proverb;
  final TextScaler textScale;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _BrandStripe(),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Letter ${proverb.letter}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colors.brandGold,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        _LetterChip(letter: proverb.letter),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    StaggeredEntrance(
                      index: 1,
                      child: _DetailSection(
                        title: AppConstants.detailDawuroSection,
                        accentColor: colors.brandRed,
                        body: proverb.dawuro,
                        bodyStyle: theme.textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.5,
                          letterSpacing: 0.2,
                          fontSize: textScale.scale(22),
                        ),
                        semanticsLabel: AppConstants.detailDawuroSection,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sectionGap(context)),
                    StaggeredEntrance(
                      index: 2,
                      child: _DetailSection(
                        title: AppConstants.detailPhoneticSection,
                        accentColor: colors.brandGold,
                        body: proverb.phonetic,
                        bodyStyle: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          height: 1.55,
                          fontSize: textScale.scale(17),
                        ),
                        semanticsLabel: AppConstants.detailPhoneticSection,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sectionGap(context)),
                    StaggeredEntrance(
                      index: 3,
                      child: _DetailSection(
                        title: AppConstants.detailAmharicSection,
                        accentColor: Colors.white.withValues(alpha: 0.85),
                        body: proverb.amharic,
                        bodyStyle: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          height: 1.55,
                          fontSize: textScale.scale(17),
                        ),
                        semanticsLabel: AppConstants.detailAmharicSection,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandStripe extends StatelessWidget {
  const _BrandStripe();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(child: Container(height: 4, color: colors.brandRed)),
        Expanded(child: Container(height: 4, color: colors.brandGold)),
        Expanded(
          child: Container(
            height: 4,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

class _LetterChip extends StatelessWidget {
  const _LetterChip({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 4,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: colors.brandRed,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colors.brandRed.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        letter,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.accentColor,
    required this.body,
    required this.bodyStyle,
    required this.semanticsLabel,
  });

  final String title;
  final Color accentColor;
  final String body;
  final TextStyle? bodyStyle;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.75),
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SelectableText(
                    body,
                    textAlign: TextAlign.start,
                    style: bodyStyle,
                    contextMenuBuilder: (context, editableTextState) {
                      return AdaptiveTextSelectionToolbar.editableText(
                        editableTextState: editableTextState,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailNavBar extends StatelessWidget {
  const _DetailNavBar({
    required this.colors,
    required this.showPosition,
    required this.positionLabel,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  final AppColors colors;
  final bool showPosition;
  final String? positionLabel;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              _NavButton(
                icon: FontAwesomeIcons.circleChevronLeft,
                tooltip: AppConstants.detailPreviousLabel,
                enabled: hasPrevious,
                onPressed: onPrevious,
                colors: colors,
              ),
              Expanded(
                child: showPosition && positionLabel != null
                    ? Text(
                        positionLabel!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colors.brandGold,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              _NavButton(
                icon: FontAwesomeIcons.circleChevronRight,
                tooltip: AppConstants.detailNextLabel,
                enabled: hasNext,
                onPressed: onNext,
                colors: colors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.onPressed,
    required this.colors,
  });

  final FaIconData icon;
  final String tooltip;
  final bool enabled;
  final VoidCallback? onPressed;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final iconColor = enabled
        ? colors.brandGold
        : Colors.white.withValues(alpha: 0.28);

    return IconButton(
      onPressed: enabled ? onPressed : null,
      tooltip: tooltip,
      icon: FaIcon(icon, size: 28, color: iconColor),
      style: IconButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: const CircleBorder(),
      ),
    );
  }
}
