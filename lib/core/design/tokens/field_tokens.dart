import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Geometry for [DsTextField] and [DsSearchField].
@immutable
class FieldTokens extends ThemeExtension<FieldTokens> {
  const FieldTokens({
    this.height = 56,
    this.radius = 16,
    this.searchHeight = 56,
    this.searchRadius = 28,
    this.iconSize = 18,
    this.paddingH = 18,
    this.paddingEnd = 8,
    this.gap = 12,
    this.fill,
    this.hint,
    this.text,
    this.icon,
    this.focusedBorder,
  });

  final double height;
  final double radius;
  final double searchHeight;
  final double searchRadius;
  final double iconSize;
  final double paddingH;
  final double paddingEnd;
  final double gap;
  final Color? fill;
  final Color? hint;
  final Color? text;
  final Color? icon;
  final Color? focusedBorder;

  static const standard = FieldTokens();

  @override
  FieldTokens copyWith({
    double? height,
    double? radius,
    double? searchHeight,
    double? searchRadius,
    double? iconSize,
    double? paddingH,
    double? paddingEnd,
    double? gap,
    Color? fill,
    Color? hint,
    Color? text,
    Color? icon,
    Color? focusedBorder,
  }) {
    return FieldTokens(
      height: height ?? this.height,
      radius: radius ?? this.radius,
      searchHeight: searchHeight ?? this.searchHeight,
      searchRadius: searchRadius ?? this.searchRadius,
      iconSize: iconSize ?? this.iconSize,
      paddingH: paddingH ?? this.paddingH,
      paddingEnd: paddingEnd ?? this.paddingEnd,
      gap: gap ?? this.gap,
      fill: fill ?? this.fill,
      hint: hint ?? this.hint,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      focusedBorder: focusedBorder ?? this.focusedBorder,
    );
  }

  @override
  FieldTokens lerp(covariant FieldTokens? other, double t) {
    if (other == null) return this;

    return FieldTokens(
      height: dsLerp(height, other.height, t),
      radius: dsLerp(radius, other.radius, t),
      searchHeight: dsLerp(searchHeight, other.searchHeight, t),
      searchRadius: dsLerp(searchRadius, other.searchRadius, t),
      iconSize: dsLerp(iconSize, other.iconSize, t),
      paddingH: dsLerp(paddingH, other.paddingH, t),
      paddingEnd: dsLerp(paddingEnd, other.paddingEnd, t),
      gap: dsLerp(gap, other.gap, t),
      fill: dsLerpColor(fill, other.fill, t),
      hint: dsLerpColor(hint, other.hint, t),
      text: dsLerpColor(text, other.text, t),
      icon: dsLerpColor(icon, other.icon, t),
      focusedBorder: dsLerpColor(focusedBorder, other.focusedBorder, t),
    );
  }
}
