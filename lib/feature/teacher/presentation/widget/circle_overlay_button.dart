import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';

/// زر دائري أبيض فوق الصور (حفظ).
class CircleOverlayButton extends StatelessWidget {
  const CircleOverlayButton({
    super.key,
    required this.icon,
    this.onTap,
    this.active = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.r,
        height: 30.r,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhiteWidget.withAlpha(235),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: active ? AppColors.primary : AppColors.textBlack,
        ),
      ),
    );
  }
}
