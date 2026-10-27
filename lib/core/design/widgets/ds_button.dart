import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/button_tokens.dart';
import 'package:uniflow/core/design/tokens/color_tokens.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

enum DsButtonVariant { primary, secondary, ghost, danger, text }

enum DsButtonSize { sm, md, lg }

/// Pill button. Variant picks the default colors; every visual can be overridden.
class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.size = DsButtonSize.md,
    this.leading,
    this.trailing,
    this.expanded = false,
    this.loading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.radius,
    this.gradient,
  }) : assert(label != null || child != null, 'Provide label or child.');

  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final DsButtonSize size;
  final IconData? leading;
  final IconData? trailing;
  final bool expanded;
  final bool loading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? radius;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.buttons;
    final enabled = onPressed != null && !loading;
    final colors = _colors(ds.colors, enabled);
    final height = switch (size) {
      DsButtonSize.sm => tokens.heightSm,
      DsButtonSize.md => tokens.heightMd,
      DsButtonSize.lg => tokens.heightLg,
    };
    final paddingH = switch (size) {
      DsButtonSize.sm => tokens.paddingHSm,
      DsButtonSize.md => tokens.paddingHMd,
      DsButtonSize.lg => tokens.paddingHLg,
    };
    final borderRadius = BorderRadius.circular((radius ?? tokens.radius).r);
    final resolvedGradient = enabled
        ? gradient ??
              (variant == DsButtonVariant.primary
                  ? tokens.primaryGradient
                  : null)
        : null;

    return SizedBox(
      width: expanded ? double.infinity : null,
      height: height.h,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            color: resolvedGradient == null ? colors.background : null,
            gradient: resolvedGradient,
            borderRadius: borderRadius,
            border: colors.border == null
                ? null
                : Border.all(color: colors.border!),
          ),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingH.w),
              child: Center(child: _content(tokens, colors.foreground)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(ButtonTokens tokens, Color foreground) {
    if (loading) {
      return SizedBox.square(
        dimension: tokens.iconSize.r,
        child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
      );
    }
    if (child != null) return child!;

    final text = DsText(
      label!,
      role: DsTextRole.label,
      color: foreground,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );

    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          Icon(leading, size: tokens.iconSize.r, color: foreground),
          SizedBox(width: tokens.gap.w),
        ],
        if (expanded) Flexible(child: text) else text,
        if (trailing != null) ...[
          SizedBox(width: tokens.gap.w),
          Icon(trailing, size: tokens.iconSize.r, color: foreground),
        ],
      ],
    );
  }

  _ButtonColors _colors(ColorTokens colors, bool enabled) {
    if (!enabled) {
      return _ButtonColors(
        background: backgroundColor ?? colors.disabled,
        foreground: foregroundColor ?? colors.textMuted,
      );
    }

    return switch (variant) {
      DsButtonVariant.primary => _ButtonColors(
        background: backgroundColor ?? colors.primary,
        foreground: foregroundColor ?? colors.onPrimary,
        border: borderColor,
      ),
      DsButtonVariant.secondary => _ButtonColors(
        background: backgroundColor ?? colors.primarySoft,
        foreground: foregroundColor ?? colors.primary,
        border: borderColor,
      ),
      DsButtonVariant.ghost => _ButtonColors(
        background: backgroundColor ?? Colors.transparent,
        foreground: foregroundColor ?? colors.primary,
        border: borderColor ?? colors.border,
      ),
      DsButtonVariant.danger => _ButtonColors(
        background: backgroundColor ?? colors.error,
        foreground: foregroundColor ?? colors.onPrimary,
        border: borderColor,
      ),
      DsButtonVariant.text => _ButtonColors(
        background: backgroundColor ?? Colors.transparent,
        foreground: foregroundColor ?? colors.primary,
        border: borderColor,
      ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
