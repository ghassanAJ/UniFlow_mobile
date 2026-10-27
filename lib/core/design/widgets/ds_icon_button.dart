import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';

enum DsIconButtonVariant { soft, filled, ghost }

enum DsIconButtonShape { circle, rounded }

/// Icon action. Shape, colors, and the badge dot are all overridable.
class DsIconButton extends StatelessWidget {
  const DsIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = DsIconButtonVariant.soft,
    this.shape = DsIconButtonShape.circle,
    this.showBadge = false,
    this.backgroundColor,
    this.foregroundColor,
    this.badgeColor,
    this.size,
    this.iconSize,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final DsIconButtonVariant variant;
  final DsIconButtonShape shape;
  final bool showBadge;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? badgeColor;
  final double? size;
  final double? iconSize;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.iconButtons;
    final colors = ds.colors;
    final dimension = (size ?? tokens.size).r;
    final radius = BorderRadius.circular(tokens.radius.r);
    final isCircle = shape == DsIconButtonShape.circle;

    final (Color background, Color foreground) = switch (variant) {
      DsIconButtonVariant.soft => (
        backgroundColor ?? tokens.softBackground ?? colors.primarySoft,
        foregroundColor ?? tokens.softForeground ?? colors.primary,
      ),
      DsIconButtonVariant.filled => (
        backgroundColor ?? tokens.filledBackground ?? colors.primary,
        foregroundColor ?? tokens.filledForeground ?? colors.onPrimary,
      ),
      DsIconButtonVariant.ghost => (
        backgroundColor ?? Colors.transparent,
        foregroundColor ?? tokens.ghostForeground ?? colors.textPrimary,
      ),
    };

    final shapeBorder = isCircle
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: radius);

    final button = SizedBox.square(
      dimension: dimension,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Material(
              color: background,
              shape: shapeBorder,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onPressed,
                customBorder: shapeBorder,
                child: Icon(
                  icon,
                  size: (iconSize ?? tokens.iconSize).r,
                  color: foreground,
                ),
              ),
            ),
          ),
          if (showBadge)
            Positioned(
              top: 1.r,
              right: 1.r,
              child: Container(
                width: tokens.badgeSize.r,
                height: tokens.badgeSize.r,
                decoration: BoxDecoration(
                  color: badgeColor ?? tokens.badgeColor ?? colors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.surface, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );

    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
