import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';

class CourseDetailsCategoryRow extends StatelessWidget {
  const CourseDetailsCategoryRow({
    super.key,
    required this.category,
    required this.provider,
  });

  final String category;
  final String provider;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Row(
      children: [
        Flexible(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: DsBadge(
              label: category,
              backgroundColor: colors.primarySoft,
              foregroundColor: colors.accent,
            ),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Flexible(
          child: DsText(
            provider,
            role: DsTextRole.caption,
            color: colors.textSecondary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class CourseDetailsStatsRow extends StatelessWidget {
  const CourseDetailsStatsRow({
    super.key,
    required this.rating,
    required this.studentsLabel,
    required this.videosLabel,
    required this.hoursLabel,
  });

  final String rating;
  final String studentsLabel;
  final String videosLabel;
  final String hoursLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      variant: DsCardVariant.filled,
      color: colors.surfaceMuted,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm.w,
        vertical: AppSpacing.sm.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.star_rounded,
              iconColor: colors.warning,
              label: rating,
              emphasize: true,
            ),
          ),
          DsDivider(vertical: true, length: 16.h),
          Expanded(
            flex: 2,
            child: _StatItem(
              icon: Icons.groups_rounded,
              iconColor: colors.accent,
              label: studentsLabel,
            ),
          ),
          DsDivider(vertical: true, length: 16.h),
          Expanded(
            flex: 2,
            child: _StatItem(
              icon: Icons.play_circle_outline_rounded,
              iconColor: colors.accent,
              label: '$videosLabel · $hoursLabel',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.emphasize = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14.sp, color: iconColor),
        SizedBox(width: AppSpacing.xs.w),
        Flexible(
          child: DsText(
            label,
            role: emphasize ? DsTextRole.label : DsTextRole.overline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class CourseDetailsInstructorRow extends StatelessWidget {
  const CourseDetailsInstructorRow({
    super.key,
    required this.name,
    required this.subtitle,
    this.avatarUrl,
    this.initials,
    this.onViewProfile,
  });

  final String name;
  final String subtitle;
  final String? avatarUrl;
  final String? initials;
  final VoidCallback? onViewProfile;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      padding: EdgeInsets.all(AppSpacing.md.r),
      onTap: onViewProfile,
      child: Row(
        children: [
          DsAvatar(
            size: AvatarSize.md,
            imageUrl: avatarUrl,
            initials: initials,
            shape: AvatarShape.rounded,
            showBorder: true,
            backgroundColor: colors.primarySoft,
            foregroundColor: colors.accent,
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DsText(
                  name,
                  role: DsTextRole.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.xxs.h),
                DsText(
                  subtitle,
                  role: DsTextRole.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          DsText(
            'View profile',
            role: DsTextRole.label,
            color: colors.primary,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class CourseDetailsEnrollBar extends StatelessWidget {
  const CourseDetailsEnrollBar({
    super.key,
    required this.price,
    this.currency = 'S.P',
    this.onEnroll,
  });

  final int price;
  final String currency;
  final VoidCallback? onEnroll;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final grouped = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );

    return Material(
      color: colors.surface,
      elevation: 8,
      shadowColor: colors.shadow.withValues(alpha: 0.12),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg.w,
            AppSpacing.md.h,
            AppSpacing.lg.w,
            AppSpacing.md.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DsText(
                      'TOTAL PRICE',
                      role: DsTextRole.overline,
                      color: colors.textSecondary,
                    ),
                    SizedBox(height: AppSpacing.xxs.h),
                    Row(
                      children: [
                        Flexible(
                          child: DsText(
                            grouped,
                            role: DsTextRole.headline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: AppSpacing.xs.w),
                        DsText(
                          currency,
                          role: DsTextRole.label,
                          color: colors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: DsButton(
                  label: 'Enroll Now',
                  leading: Icons.school_rounded,
                  size: DsButtonSize.lg,
                  expanded: true,
                  onPressed: onEnroll,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
