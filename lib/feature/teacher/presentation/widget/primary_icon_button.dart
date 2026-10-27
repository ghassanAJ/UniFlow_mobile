import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// زر برتقالي ممتلئ مع أيقونة (Follow Mentor).
class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.height = 46,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18.sp),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          textStyle: AppTextStyles.s14w600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
      ),
    );
  }
}
