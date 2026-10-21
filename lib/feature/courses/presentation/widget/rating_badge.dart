import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.ligthPrimary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
          SizedBox(width: 3.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.s12w400.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}
