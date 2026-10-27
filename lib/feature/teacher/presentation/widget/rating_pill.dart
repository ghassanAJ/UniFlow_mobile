import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// Pill داكنة شفافة فوق الصور: ★ 4.2 (320)
class RatingPill extends StatelessWidget {
  const RatingPill({super.key, required this.rating, this.count});

  final double rating;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(140),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: 13.sp,
            color: AppColors.messageWarning,
          ),
          SizedBox(width: 3.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
            ),
          ),
          if (count != null) ...[
            SizedBox(width: 3.w),
            Text(
              '($count)',
              style: AppTextStyles.s12w400.copyWith(
                fontSize: 10.sp,
                color: AppColors.textWhite.withAlpha(200),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
