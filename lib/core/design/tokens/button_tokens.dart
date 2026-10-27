import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Geometry for [DsButton]. Colors come from [ColorTokens] unless a
/// widget override or [primaryGradient] is set.
@immutable
class ButtonTokens extends ThemeExtension<ButtonTokens> {
  const ButtonTokens({
    this.heightSm = 36,
    this.heightMd = 48,
    this.heightLg = 56,
    this.radius = 999,
    this.paddingHSm = 14,
    this.paddingHMd = 18,
    this.paddingHLg = 24,
    this.iconSize = 18,
    this.gap = 8,
    this.primaryGradient,
  });

  final double heightSm;
  final double heightMd;
  final double heightLg;
  final double radius;
  final double paddingHSm;
  final double paddingHMd;
  final double paddingHLg;
  final double iconSize;
  final double gap;
  final Gradient? primaryGradient;

  static const standard = ButtonTokens();

  @override
  ButtonTokens copyWith({
    double? heightSm,
    double? heightMd,
    double? heightLg,
    double? radius,
    double? paddingHSm,
    double? paddingHMd,
    double? paddingHLg,
    double? iconSize,
    double? gap,
    Gradient? primaryGradient,
  }) {
    return ButtonTokens(
      heightSm: heightSm ?? this.heightSm,
      heightMd: heightMd ?? this.heightMd,
      heightLg: heightLg ?? this.heightLg,
      radius: radius ?? this.radius,
      paddingHSm: paddingHSm ?? this.paddingHSm,
      paddingHMd: paddingHMd ?? this.paddingHMd,
      paddingHLg: paddingHLg ?? this.paddingHLg,
      iconSize: iconSize ?? this.iconSize,
      gap: gap ?? this.gap,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }

  @override
  ButtonTokens lerp(covariant ButtonTokens? other, double t) {
    if (other == null) return this;

    return ButtonTokens(
      heightSm: dsLerp(heightSm, other.heightSm, t),
      heightMd: dsLerp(heightMd, other.heightMd, t),
      heightLg: dsLerp(heightLg, other.heightLg, t),
      radius: dsLerp(radius, other.radius, t),
      paddingHSm: dsLerp(paddingHSm, other.paddingHSm, t),
      paddingHMd: dsLerp(paddingHMd, other.paddingHMd, t),
      paddingHLg: dsLerp(paddingHLg, other.paddingHLg, t),
      iconSize: dsLerp(iconSize, other.iconSize, t),
      gap: dsLerp(gap, other.gap, t),
      primaryGradient: dsLerpGradient(
        primaryGradient,
        other.primaryGradient,
        t,
      ),
    );
  }
}
