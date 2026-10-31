import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/profile/data/models/profile_data.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final narrow = context.isCompact;

    return DsCard(
      variant: DsCardVariant.filled,
      color: colors.primarySoft,
      radius: AppSpacing.radiusXl,
      padding: EdgeInsets.all(AppSpacing.md.r),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DsAvatar(
                size: narrow ? AvatarSize.md : AvatarSize.lg,
                imageUrl: data.avatarUrl,
                initials: data.initials,
                backgroundColor: colors.surface,
                foregroundColor: colors.primary,
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DsText(
                      data.fullName,
                      role: DsTextRole.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSpacing.xxs.h),
                    DsText(
                      data.email,
                      role: DsTextRole.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    Wrap(
                      spacing: AppSpacing.xs.w,
                      runSpacing: AppSpacing.xs.h,
                      children: [
                        DsBadge(
                          label: data.yearLabel,
                          icon: Icons.school_outlined,
                          backgroundColor: colors.surface,
                          foregroundColor: colors.accent,
                        ),
                        DsBadge(
                          label: data.badge,
                          icon: Icons.workspace_premium_outlined,
                          backgroundColor: colors.surface,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md.h),
          DsCard(
            variant: DsCardVariant.filled,
            color: colors.surface,
            radius: AppSpacing.radiusMd,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.sm.h,
            ),
            child: narrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _info('profile.university'.tr(), data.university),
                      SizedBox(height: AppSpacing.sm.h),
                      const DsDivider(),
                      SizedBox(height: AppSpacing.sm.h),
                      _info('profile.college'.tr(), data.college),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _info(
                          'profile.university'.tr(),
                          data.university,
                        ),
                      ),
                      DsDivider(vertical: true, length: 30.h),
                      SizedBox(width: AppSpacing.md.w),
                      Expanded(
                        child: _info('profile.college'.tr(), data.college),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _info(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DsText(label, role: DsTextRole.overline, fontWeight: FontWeight.w400),
        SizedBox(height: AppSpacing.xxs.h),
        DsText(
          value,
          role: DsTextRole.label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
