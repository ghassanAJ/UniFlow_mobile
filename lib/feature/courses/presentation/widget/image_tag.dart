import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

/// Small pill shown over images (enrolled count, department, term...).
class ImageTag extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color textColor;
  final IconData? icon;

  const ImageTag({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor = AppColors.textWhite,
    this.icon,
  });

  /// Orange variant used for the department label.
  const ImageTag.primary({super.key, required this.label, this.icon})
      : backgroundColor = AppColors.primary,
        textColor = AppColors.textWhite;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.black.withAlpha(140),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11.sp, color: textColor),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
