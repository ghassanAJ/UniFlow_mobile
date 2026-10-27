import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/liquid_glass.dart';
class GlassStatChip extends StatelessWidget {
  const GlassStatChip({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      borderRadius: 14,
      blur: 14,
      tintOpacity: .2,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.textWhite),
          SizedBox(width: 5.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

