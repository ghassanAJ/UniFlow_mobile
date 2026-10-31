import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  padding: EdgeInsets.only(bottom: AppSpacing.md.h),
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
                  bottom: index == itemCount - 1 ? 0 : AppSpacing.sm.h,
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
      padding: EdgeInsets.all(AppSpacing.md.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DsText(
                averageRating.toStringAsFixed(1),
                role: DsTextRole.title,
                color: colors.textPrimary,
              ),
              SizedBox(width: AppSpacing.sm.w),
              ...List.generate(5, (index) {
                final filled = index < averageRating.round();
                return Icon(
                  filled ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 14.sp,
                  color: colors.accent,
                );
              }),
              SizedBox(width: AppSpacing.sm.w),
              Expanded(
                child: DsText(
                  '$totalReviews reviews',
                  role: DsTextRole.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
            SizedBox(height: AppSpacing.md.h),
            for (var star = 5; star >= 1; star--)
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.xs.h),
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
          width: 14.w,
          child: DsText('$stars', role: DsTextRole.overline),
        ),
        Icon(Icons.star_rounded, size: 11.sp, color: colors.accent),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5.h,
              backgroundColor: colors.surfaceMuted,
              color: colors.primary,
            ),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        SizedBox(
          width: 24.w,
          child: DsText(
            '$count',
            role: DsTextRole.overline,
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
      padding: EdgeInsets.all(AppSpacing.md.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DsAvatar(
                size: AvatarSize.sm,
                shape: AvatarShape.rounded,
                imageUrl: review.avatarUrl,
                assetPath: review.avatarAsset,
                initials: _initials(review.author),
              ),
              SizedBox(width: AppSpacing.sm.w),
              Flexible(
                child: DsText(
                  review.author,
                  role: DsTextRole.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (review.role != null) ...[
                SizedBox(width: AppSpacing.xs.w),
                Flexible(
                  child: DsText(
                    '· ${review.role!}',
                    role: DsTextRole.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              SizedBox(width: AppSpacing.sm.w),
              Icon(Icons.star_rounded, size: 13.sp, color: colors.accent),
              SizedBox(width: 2.w),
              DsText(
                review.rating.toStringAsFixed(1),
                role: DsTextRole.label,
                color: colors.accent,
              ),
              SizedBox(width: AppSpacing.sm.w),
              DsText(
                review.dateLabel,
                role: DsTextRole.overline,
                color: colors.textMuted,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm.h),
          DsText(
            review.comment,
            role: DsTextRole.caption,
            color: colors.textPrimary,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
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
          Icon(Icons.reviews_outlined, size: 32.sp, color: colors.textMuted),
          SizedBox(height: AppSpacing.sm.h),
          const DsText('No reviews yet', role: DsTextRole.label),
          SizedBox(height: AppSpacing.xs.h),
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
