import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
class PartPill extends StatelessWidget {
  const PartPill({super.key, required this.part});

  final int part;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.ligthGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        'Part $part',
        style: AppTextStyles.s12w400.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blackText,
        ),
      ),
    );
  }
}

