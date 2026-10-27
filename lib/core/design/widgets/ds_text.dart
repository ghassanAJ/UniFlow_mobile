import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/color_tokens.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';

/// Text that follows the type scale and can be overridden per call.
class DsText extends StatelessWidget {
  const DsText(
    this.data, {
    super.key,
    this.role = DsTextRole.body,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
  });

  final String data;
  final DsTextRole role;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final base = ds.typography.styleFor(role);
    final scaled = base.copyWith(
      fontSize: (fontSize ?? base.fontSize)?.sp,
      fontWeight: fontWeight ?? base.fontWeight,
      color: color ?? base.color ?? _roleColor(role, ds.colors),
    );

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style == null ? scaled : scaled.merge(style),
    );
  }

  static Color _roleColor(DsTextRole role, ColorTokens colors) {
    return switch (role) {
      DsTextRole.display ||
      DsTextRole.headline ||
      DsTextRole.title ||
      DsTextRole.titleSmall ||
      DsTextRole.label ||
      DsTextRole.overline => colors.textPrimary,
      DsTextRole.body || DsTextRole.caption => colors.textSecondary,
    };
  }
}
