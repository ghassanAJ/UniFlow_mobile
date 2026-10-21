// // import 'package:e_learning/core/colors/app_colors.dart';
// // import 'package:e_learning/core/style/app_text_styles.dart';
// // import 'package:e_learning/core/localization/manager/app_localization.dart';
// // import 'package:e_learning/core/themes/theme_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// عدّل المسارات حسب مشروعك
// import 'package:uniflow/core/colors/app_colors.dart';
// class TextFormFieldStyle {
//   static InputDecoration baseForm(
//     String label,
//     BuildContext context, [
//     TextStyle? style,
//   ]) {
//     return InputDecoration(
//       hintStyle:
//           style ?? AppTextStyles.s14w400.copyWith(color: context.colors.dividerGrey),
//       hintText: AppLocalizations.of(context)?.translate(label) ?? "",
//       contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
//       errorStyle: AppTextStyles.s12w400.copyWith(color: Colors.red),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color: context.colors.dividerGrey),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color: context.colors.dividerGrey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color:  context.colors.textBlue, width: 2.w),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color: Colors.red, width: 2.w),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide(color: Colors.red, width: 1.w),
//       ),
//     );
//   }
// }



// import 'package:uniflow/core/localization/manager/app_localization.dart';

/// ألوان خاصة بالـ form (مشتقة من الـ palette الجديدة)
class _FormColors {
  static const Color fill = Color(0xffFFFFFF);
  static const Color iconCircle = Color(0xffFFD9CC); // درجة فاتحة من Primary
  static const Color icon = Color(0xff3B2118); // بني غامق للأيقونات
  static const Color hint = Color(0xffB89E98); // لون الـ hint
  static const Color label = Color(0xff1E2024); // Neutral
  static const Color labelHint = Color(0xff6B6E75);
  static const Color required = Color(0xffA33A12);
  static const Color shadow = Color(0x14FF6433);
}

class TextFormFieldStyle {
  TextFormFieldStyle._();

  static const double _radius = 32;

  /// دائرة الأيقونة على اليسار (نفس الصورة)
  static Widget circleIcon(IconData icon) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
      child: Container(
        width: 40.r,
        height: 40.r,
        decoration: const BoxDecoration(
          color: _FormColors.iconCircle,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.r, color: _FormColors.icon),
      ),
    );
  }

  static OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static InputDecoration baseForm(
    String label,
    BuildContext context, {
    IconData? prefixIcon,
    Widget? prefix,
    Widget? suffixIcon,
    TextStyle? style,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: _FormColors.fill,
      hintText: 
      // AppLocalizations.of(context)?.translate(label) ??
       label,
      hintStyle: style ??
          AppTextStyles.s14w400.copyWith(color: _FormColors.hint),
      errorStyle: AppTextStyles.s12w400.copyWith(color: Colors.red),
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      prefixIcon: prefix ?? (prefixIcon != null ? circleIcon(prefixIcon) : null),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: suffixIcon,
      border: _border(Colors.transparent, 0),
      enabledBorder: _border(Colors.transparent, 0),
      disabledBorder: _border(Colors.transparent, 0),
      focusedBorder: _border(AppColors.primary, 1.5.w),
      errorBorder: _border(Colors.red, 1.w),
      focusedErrorBorder: _border(Colors.red, 1.5.w),
    );
  }
}

/// Wrapper كامل: Label فوق + نص صغير على اليمين + حقل بظل خفيف
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    required this.hint,
    this.trailingLabel,
    this.trailingIsRequired = false,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final String hint;
  final String? trailingLabel; // مثل: As on student card / Required
  final bool trailingIsRequired;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.s14w400.copyWith(
                  color: _FormColors.label,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (trailingLabel != null)
                Text(
                  // AppLocalizations.of(context)?.translate(trailingLabel!) ??
                      trailingLabel!,
                  style: AppTextStyles.s12w400.copyWith(
                    color: trailingIsRequired
                        ? _FormColors.required
                        : _FormColors.labelHint,
                    fontWeight:
                        trailingIsRequired ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: const [
              BoxShadow(
                color: _FormColors.shadow,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            style: AppTextStyles.s14w400.copyWith(color: _FormColors.label),
            decoration: TextFormFieldStyle.baseForm(
              hint,
              context,
              prefixIcon: prefixIcon,
              prefix: prefix,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

/*
مثال استخدام:

AppFormField(
  label: 'Full Name',
  trailingLabel: 'As on student card',
  hint: 'e.g. Zein Al-Abedin',
  prefixIcon: Icons.person_outline,
)

AppFormField(
  label: 'Choose University',
  trailingLabel: 'Required',
  trailingIsRequired: true,
  hint: 'Select your university',
  prefixIcon: Icons.account_balance_outlined,
  suffixIcon: const Icon(Icons.keyboard_arrow_down),
  readOnly: true,
  onTap: () { /* افتح الـ bottom sheet */ },
)
*/