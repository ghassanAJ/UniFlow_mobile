import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/profile/data/models/profile_data.dart';

class ProfileStandingCard extends StatelessWidget {
  const ProfileStandingCard({super.key, required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      color: colors.primary,
      radius: AppSpacing.radiusXl,
      padding: EdgeInsets.all(AppSpacing.lg.r),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DsText(
                  'profile.overallStanding'.tr(),
                  role: DsTextRole.caption,
                  color: colors.primarySoft,
                  maxLines: 1,
                ),
                SizedBox(height: AppSpacing.xs.h),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: AppSpacing.sm.w,
                  children: [
                    DsText(
                      '${data.overallPercent}%',
                      role: DsTextRole.display,
                      color: colors.onPrimary,
                    ),
                    DsText(
                      data.grade,
                      role: DsTextRole.label,
                      color: colors.onPrimary,
                      maxLines: 1,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm.h),
                DsText(
                  data.standingNote,
                  role: DsTextRole.caption,
                  color: colors.primarySoft,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          DsIconButton(
            icon: Icons.emoji_events_outlined,
            size: context.isCompact ? 44 : 52,
            iconSize: context.isCompact ? 22 : 26,
            backgroundColor: colors.onPrimary.withValues(alpha: 0.18),
            foregroundColor: colors.onPrimary,
          ),
        ],
      ),
    );
  }
}
