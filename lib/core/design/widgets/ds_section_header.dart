import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

/// Title row with an optional leading icon, subtitle, and a trailing
/// widget or action.
class DsSectionHeader extends StatelessWidget {
  const DsSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.titleRole = DsTextRole.titleSmall,
    this.subtitleRole = DsTextRole.caption,
    this.titleColor,
    this.subtitleColor,
    this.iconColor,
    this.actionColor,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;
  final DsTextRole titleRole;
  final DsTextRole subtitleRole;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? iconColor;
  final Color? actionColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: AppSpacing.iconSm.r,
            color: iconColor ?? colors.primary,
          ),
          SizedBox(width: (AppSpacing.xs + AppSpacing.xxs).w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DsText(
                title,
                role: titleRole,
                color: titleColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                SizedBox(height: AppSpacing.xxs.h),
                DsText(
                  subtitle!,
                  role: subtitleRole,
                  color: subtitleColor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: AppSpacing.sm.w),
          Flexible(
            fit: FlexFit.loose,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: trailing!,
            ),
          ),
        ] else if (actionLabel != null) ...[
          SizedBox(width: AppSpacing.sm.w),
          Flexible(
            fit: FlexFit.loose,
            child: GestureDetector(
              onTap: onAction,
              child: DsText(
                actionLabel!,
                role: DsTextRole.label,
                color: actionColor ?? colors.primary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
