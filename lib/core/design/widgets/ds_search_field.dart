import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';

/// Search row with an optional trailing action, such as a filter button.
class DsSearchField extends StatelessWidget {
  const DsSearchField({
    super.key,
    this.hint = 'Search',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.icon = Icons.search_rounded,
    this.trailing,
    this.fillColor,
    this.iconColor,
    this.radius,
    this.height,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData icon;
  final Widget? trailing;
  final Color? fillColor;
  final Color? iconColor;
  final double? radius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.fields;
    final colors = ds.colors;
    final body = ds.typography.body.copyWith(
      fontSize: ds.typography.body.fontSize?.sp,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: fillColor ?? tokens.fill ?? colors.surfaceMuted,
        borderRadius: BorderRadius.circular((radius ?? tokens.searchRadius).r),
      ),
      child: SizedBox(
        height: (height ?? tokens.searchHeight).h,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: tokens.paddingH.w,
            end: (trailing == null ? tokens.paddingH : tokens.paddingEnd).w,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: tokens.iconSize.r,
                color: iconColor ?? tokens.icon ?? colors.textPrimary,
              ),
              SizedBox(width: tokens.gap.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  onTap: onTap,
                  readOnly: readOnly,
                  textInputAction: TextInputAction.search,
                  cursorColor: colors.primary,
                  style: body.copyWith(
                    color: tokens.text ?? colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: body.copyWith(
                      color: tokens.hint ?? colors.textSecondary,
                    ),
                  ),
                ),
              ),
              if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}
