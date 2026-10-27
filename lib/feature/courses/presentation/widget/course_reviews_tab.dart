import 'package:flutter/material.dart';
import 'package:uniflow/core/design/design_system.dart';

class CourseReview {
  const CourseReview({
    required this.author,
    required this.comment,
    required this.rating,
    required this.dateLabel,
    this.role,
    this.avatarUrl,
    this.avatarAsset,
  });

  final String author;
  final String? role;
  final String comment;
  final double rating;
  final String dateLabel;
  final String? avatarUrl;
  final String? avatarAsset;
}

/// Reusable Reviews tab with summary + lazy sliver builders.
class CourseReviewsTab extends StatelessWidget {
  const CourseReviewsTab({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.reviews,
    this.ratingDistribution = const {},
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.xxl,
    ),
    this.onWriteReview,
  });

  final double averageRating;
  final int totalReviews;
  final List<CourseReview> reviews;
  final Map<int, int> ratingDistribution;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onWriteReview;

  @override
  Widget build(BuildContext context) {
    final itemCount = reviews.isEmpty ? 2 : reviews.length + 1;

    return CustomScrollView(
      key: const PageStorageKey('course-reviews'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: padding,
          sliver: SliverList.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _ReviewsSummary(
                    averageRating: averageRating,
                    totalReviews: totalReviews,
                    distribution: ratingDistribution,
                    onWriteReview: onWriteReview,
                  ),
                );
              }

              if (reviews.isEmpty) {
                return const _EmptyReviews();
              }

              final review = reviews[index - 1];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == itemCount - 1 ? 0 : AppSpacing.md,
                ),
                child: _ReviewCard(review: review),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewsSummary extends StatelessWidget {
  const _ReviewsSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.distribution,
    this.onWriteReview,
  });

  final double averageRating;
  final int totalReviews;
  final Map<int, int> distribution;
  final VoidCallback? onWriteReview;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final maxCount = distribution.values.fold<int>(
      0,
      (max, value) => value > max ? value : max,
    );

    return DsCard(
      variant: DsCardVariant.outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DsText(
                      averageRating.toStringAsFixed(1),
                      role: DsTextRole.headline,
                      color: colors.textPrimary,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          final filled = index < averageRating.round();
                          return Icon(
                            filled
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 16,
                            color: colors.accent,
                          );
                        }),
                        const SizedBox(width: AppSpacing.sm),
                        DsText(
                          '$totalReviews reviews',
                          role: DsTextRole.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onWriteReview != null)
                DsButton(
                  label: 'Write',
                  size: DsButtonSize.sm,
                  variant: DsButtonVariant.secondary,
                  onPressed: onWriteReview,
                ),
            ],
          ),
          if (distribution.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            for (var star = 5; star >= 1; star--)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: _RatingBarRow(
                  stars: star,
                  count: distribution[star] ?? 0,
                  maxCount: maxCount == 0 ? 1 : maxCount,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({
    required this.stars,
    required this.count,
    required this.maxCount,
  });

  final int stars;
  final int count;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final progress = (count / maxCount).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 18,
          child: DsText('$stars', role: DsTextRole.caption),
        ),
        Icon(Icons.star_rounded, size: 12, color: colors.accent),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: colors.surfaceMuted,
              color: colors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 28,
          child: DsText(
            '$count',
            role: DsTextRole.caption,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final CourseReview review;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      variant: DsCardVariant.outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DsAvatar(
                size: AvatarSize.md,
                shape: AvatarShape.rounded,
                imageUrl: review.avatarUrl,
                assetPath: review.avatarAsset,
                initials: _initials(review.author),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DsText(
                      review.author,
                      role: DsTextRole.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (review.role != null)
                      DsText(
                        review.role!,
                        role: DsTextRole.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              DsBadge(
                label: review.rating.toStringAsFixed(1),
                icon: Icons.star_rounded,
                backgroundColor: colors.primarySoft,
                foregroundColor: colors.accent,
                iconColor: colors.accent,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          DsText(review.comment, role: DsTextRole.body),
          const SizedBox(height: AppSpacing.sm),
          DsText(
            review.dateLabel,
            role: DsTextRole.overline,
            color: colors.textMuted,
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _EmptyReviews extends StatelessWidget {
  const _EmptyReviews();

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      variant: DsCardVariant.filled,
      child: Column(
        children: [
          Icon(Icons.reviews_outlined, size: 36, color: colors.textMuted),
          const SizedBox(height: AppSpacing.sm),
          const DsText('No reviews yet', role: DsTextRole.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          DsText(
            'Be the first to share your experience with this course.',
            role: DsTextRole.caption,
            textAlign: TextAlign.center,
            color: colors.textSecondary,
          ),
        ],
      ),
    );
  }
}
