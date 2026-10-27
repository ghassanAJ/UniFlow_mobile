import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

enum DsChipSize { sm, md, lg }

/// Compact label, with an optional icon and selected state.
class DsChip extends StatelessWidget {
  const DsChip({
    super.key,
    required this.label,
    this.icon,
    this.size = DsChipSize.md,
    this.selected = false,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
    this.radius,
    this.shadow,
  });

  final String label;
  final IconData? icon;
  final DsChipSize size;
  final bool selected;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final double? radius;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.chips;
    final colors = ds.colors;
    final height = switch (size) {
      DsChipSize.sm => tokens.heightSm,
      DsChipSize.md => tokens.heightMd,
      DsChipSize.lg => tokens.heightLg,
    };
    final paddingH = switch (size) {
      DsChipSize.sm => tokens.paddingHSm,
      DsChipSize.md => tokens.paddingHMd,
      DsChipSize.lg => tokens.paddingHLg,
    };
    final background =
        backgroundColor ??
        (selected
            ? tokens.selectedBackground ?? colors.primary
            : tokens.background ?? colors.chipBackground);
    final foreground =
        foregroundColor ??
        (selected
            ? tokens.selectedForeground ?? colors.onPrimary
            : tokens.foreground ?? colors.chipForeground);
    final resolvedIcon =
        iconColor ??
        (selected ? foreground : tokens.iconColor ?? colors.accent);
    final role = switch (size) {
      DsChipSize.sm => DsTextRole.overline,
      DsChipSize.md => DsTextRole.label,
      DsChipSize.lg => DsTextRole.caption,
    };

    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: height.h,
      padding: EdgeInsets.symmetric(horizontal: paddingH.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular((radius ?? tokens.radius).r),
        boxShadow: shadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: tokens.iconSize.r, color: resolvedIcon),
            SizedBox(width: 4.w),
          ],
          DsText(label, role: role, color: foreground, maxLines: 1),
        ],
      ),
    );

    if (onTap == null) return chip;
    return GestureDetector(onTap: onTap, child: chip);
  }
}
