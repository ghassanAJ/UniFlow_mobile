import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.caption,
    required this.ratio,
    this.barColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final String caption;
  final double ratio;
  final Color? barColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      padding: EdgeInsets.all(AppSpacing.md.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DsIconButton(
            icon: icon,
            size: 30,
            iconSize: 17,
            shape: DsIconButtonShape.rounded,
            foregroundColor: colors.accent,
          ),
          SizedBox(height: AppSpacing.sm.h),
          DsText(
            title,
            role: DsTextRole.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.xxs.h),
          DsText(
            value,
            role: DsTextRole.headline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.xxs.h),
          DsText(
            caption,
            role: DsTextRole.overline,
            color: colors.accent,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.sm.h),
          DsProgressBar(value: ratio, color: barColor),
        ],
      ),
    );
  }
}
