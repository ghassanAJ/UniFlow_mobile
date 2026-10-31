import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/profile/data/models/profile_data.dart';

class ProfileStreakCard extends StatelessWidget {
  const ProfileStreakCard({super.key, required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      padding: EdgeInsets.all(AppSpacing.md.r),
      child: Row(
        children: [
          const DsIconButton(
            icon: Icons.local_fire_department_rounded,
            variant: DsIconButtonVariant.filled,
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DsText(
                  'profile.streakDays'.tr(args: ['${data.streakDays}']),
                  role: DsTextRole.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.xxs.h),
                DsText(
                  'profile.studyHours'.tr(args: ['${data.studyHours}']),
                  role: DsTextRole.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Flexible(
            fit: FlexFit.loose,
            child: DsBadge(
              label: 'profile.honorRoll'.tr(),
              icon: Icons.bookmark_rounded,
              backgroundColor: colors.primarySoft,
              foregroundColor: colors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
