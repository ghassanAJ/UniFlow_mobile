import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_icon_button.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

/// Tappable row with a leading icon tile, title, optional subtitle,
/// trailing widget, and chevron.
class DsListTile extends StatelessWidget {
  const DsListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.showChevron = true,
    this.onTap,
    this.iconBackgroundColor,
    this.iconColor,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg.w,
              vertical: AppSpacing.md.h,
            ),
        child: Row(
          children: [
            if (icon != null) ...[
              DsIconButton(
                icon: icon!,
                size: 36,
                iconSize: 19,
                shape: DsIconButtonShape.rounded,
                backgroundColor: iconBackgroundColor ?? colors.surfaceMuted,
                foregroundColor: iconColor ?? colors.accent,
              ),
              SizedBox(width: AppSpacing.md.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DsText(
                    title,
                    role: DsTextRole.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppSpacing.xxs.h),
                    DsText(
                      subtitle!,
                      role: DsTextRole.overline,
                      color: colors.textSecondary,
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
            ],
            if (showChevron)
              Padding(
                padding: EdgeInsetsDirectional.only(start: AppSpacing.xs.w),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: AppSpacing.iconMd.r,
                  color: colors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
