import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/courses/data/models/chapter_models.dart';
class LessonFileTile extends StatelessWidget {
  const LessonFileTile({super.key, required this.file, this.onTap});

  final LessonFile file;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderBrand),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.picture_as_pdf_rounded,
                size: 22.sp, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w600.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  file.size,
                  style: AppTextStyles.s12w400.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: AppColors.ligthGray,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.download_rounded,
                  size: 18.sp, color: AppColors.textBlack),
            ),
          ),
        ],
      ),
    );
  }
}

