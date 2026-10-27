import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';

/// زر مربع بحدود وأيقونة فقط (حفظ / مشاركة).
class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 46,
    this.active = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhiteWidget,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderBrand),
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: active ? AppColors.primary : AppColors.textBlack,
        ),
      ),
    );
  }
}
