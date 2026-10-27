import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';

enum DsCardVariant { filled, elevated, outlined }

/// Surface container. [filled] is flat, [elevated] adds a shadow,
/// [outlined] draws a border.
class DsCard extends StatelessWidget {
  const DsCard({
    super.key,
    required this.child,
    this.variant = DsCardVariant.elevated,
    this.padding,
    this.margin,
    this.radius,
    this.color,
    this.borderColor,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final DsCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.cards;
    final colors = ds.colors;
    final borderRadius = BorderRadius.circular((radius ?? tokens.radius).r);
    final background =
        color ??
        switch (variant) {
          DsCardVariant.filled => tokens.filled ?? colors.surfaceMuted,
          DsCardVariant.elevated ||
          DsCardVariant.outlined => tokens.elevated ?? colors.surface,
        };
    final border = variant == DsCardVariant.outlined
        ? Border.all(color: borderColor ?? tokens.border ?? colors.border)
        : null;
    final shadows = variant == DsCardVariant.elevated
        ? [
            BoxShadow(
              color: colors.shadow.withValues(alpha: tokens.shadowAlpha),
              blurRadius: tokens.blur.r,
              offset: Offset(0, tokens.shadowY.h),
            ),
          ]
        : null;

    final content = Padding(
      padding: padding ?? EdgeInsets.all(tokens.padding.r),
      child: child,
    );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: borderRadius,
            border: border,
            boxShadow: shadows,
          ),
          child: Material(
            type: MaterialType.transparency,
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: onTap == null
                ? content
                : InkWell(
                    onTap: onTap,
                    borderRadius: borderRadius,
                    child: content,
                  ),
          ),
        ),
      ),
    );
  }
}
