import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/liquid_glass.dart';
class GlassPill extends StatelessWidget {
  const GlassPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      borderRadius: 20,
      blur: 12,
      tintOpacity: .2,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: Text(
        label,
        style: AppTextStyles.s12w400.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}

