import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
class ChapterStatusRow extends StatelessWidget {
  const ChapterStatusRow({
    super.key,
    required this.statusText,
    required this.courseTitle,
  });

  final String statusText;
  final String courseTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.r,
          height: 6.r,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            statusText.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 10.sp,
              letterSpacing: .8,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          courseTitle,
          style: AppTextStyles.s12w400.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }
}

