import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// زر Enroll Now (pill برتقالية مع سهم).
class ArrowPillButton extends StatelessWidget {
  const ArrowPillButton({
    super.key,
    required this.onPressed,
    this.label = 'Enroll Now',
    this.icon = Icons.arrow_forward_rounded,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16.sp),
      iconAlignment: IconAlignment.end,
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        textStyle: AppTextStyles.s14w600.copyWith(fontSize: 12.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
