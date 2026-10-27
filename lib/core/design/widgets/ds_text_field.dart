import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

enum DsFieldIconStyle { plain, circled }

/// Form field. Label, icon treatment, colors, and radius are optional.
class DsTextField extends StatelessWidget {
  const DsTextField({
    super.key,
    this.label,
    this.hint,
    this.trailingLabel,
    this.trailingRequired = false,
    this.controller,
    this.icon,
    this.iconStyle = DsFieldIconStyle.plain,
    this.prefix,
    this.suffix,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.elevated = false,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.fillColor,
    this.radius,
  });

  final String? label;
  final String? hint;
  final String? trailingLabel;
  final bool trailingRequired;
  final TextEditingController? controller;
  final IconData? icon;
  final DsFieldIconStyle iconStyle;
  final Widget? prefix;
  final Widget? suffix;
  final String? errorText;
  final bool obscureText;
  final bool readOnly;
  final bool elevated;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final Color? fillColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final ds = context.ds;
    final tokens = ds.fields;
    final colors = ds.colors;
    final radiusValue = (radius ?? tokens.radius).r;
    final textColor = tokens.text ?? colors.textPrimary;
    final hintColor = tokens.hint ?? colors.textMuted;
    final iconColor = tokens.icon ?? colors.primary;
    final body = ds.typography.body.copyWith(
      fontSize: ds.typography.body.fontSize?.sp,
    );

    final field = TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      style: body.copyWith(color: textColor),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor ?? tokens.fill ?? colors.surface,
        hintText: hint,
        hintStyle: body.copyWith(color: hintColor, fontWeight: FontWeight.w400),
        errorText: errorText,
        errorStyle: ds.typography.caption.copyWith(
          fontSize: ds.typography.caption.fontSize?.sp,
          color: colors.error,
        ),
        prefixIcon: prefix ?? _icon(colors.primarySoft, iconColor),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(
          horizontal: tokens.paddingH.w,
          vertical: 16.h,
        ),
        constraints: BoxConstraints(minHeight: tokens.height.h),
        border: _border(Colors.transparent, radiusValue),
        enabledBorder: _border(Colors.transparent, radiusValue),
        disabledBorder: _border(Colors.transparent, radiusValue),
        focusedBorder: _border(
          tokens.focusedBorder ?? colors.primary,
          radiusValue,
          width: 1.5,
        ),
        errorBorder: _border(colors.error, radiusValue),
        focusedErrorBorder: _border(colors.error, radiusValue, width: 1.5),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Expanded(child: DsText(label!, role: DsTextRole.label)),
                if (trailingLabel != null)
                  DsText(
                    trailingLabel!,
                    role: DsTextRole.caption,
                    color: trailingRequired
                        ? colors.error
                        : colors.textSecondary,
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusValue),
            boxShadow: elevated
                ? [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ]
                : null,
          ),
          child: field,
        ),
      ],
    );
  }

  Widget? _icon(Color circleColor, Color iconColor) {
    if (icon == null) return null;
    final glyph = Icon(icon, size: 20.r, color: iconColor);
    if (iconStyle == DsFieldIconStyle.plain) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w),
        child: glyph,
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, end: 8.w),
      child: DecoratedBox(
        decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
        child: SizedBox.square(dimension: 40.r, child: glyph),
      ),
    );
  }

  OutlineInputBorder _border(Color color, double radius, {double width = 0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
