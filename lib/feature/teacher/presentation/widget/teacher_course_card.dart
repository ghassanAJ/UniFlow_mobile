import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/teacher/data/models/teacher_course.dart';
import 'package:uniflow/feature/teacher/presentation/widget/arrow_pill_button.dart';
import 'package:uniflow/feature/teacher/presentation/widget/circle_overlay_button.dart';
import 'package:uniflow/feature/teacher/presentation/widget/price_block.dart';
import 'package:uniflow/feature/teacher/presentation/widget/rating_pill.dart';
import 'package:uniflow/feature/teacher/presentation/widget/tag_pill.dart';

/// بطاقة دورة المدرّس.
class TeacherCourseCard extends StatelessWidget {
  const TeacherCourseCard({
    super.key,
    required this.course,
    this.isBookmarked = false,
    this.onTap,
    this.onEnroll,
    this.onBookmark,
  });

  final TeacherCourse course;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onEnroll;
  final VoidCallback? onBookmark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundWhiteWidget,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.borderBrand),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              Padding(
                padding: EdgeInsets.fromLTRB(6.w, 10.h, 6.w, 4.h),
                child: _buildInfo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              course.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.borderBrand,
                child: Icon(
                  Icons.image_outlined,
                  size: 32.sp,
                  color: AppColors.iconGrey,
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: RatingPill(
                rating: course.rating,
                count: course.ratingCount,
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: CircleOverlayButton(
                icon: isBookmarked
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                active: isBookmarked,
                onTap: onBookmark,
              ),
            ),
            if (course.tag != null)
              Positioned(
                bottom: 8.h,
                left: 8.w,
                child: TagPill(label: course.tag!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school_outlined, size: 13.sp, color: AppColors.textGrey),
            SizedBox(width: 5.w),
            Expanded(
              child: Text(
                '${course.institute} • ${course.department}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w400.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          course.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.s14w600.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${course.instructor} • ${course.instructorCourses} Courses • '
          '${course.lectures} Lectures',
          style: AppTextStyles.s12w400.copyWith(
            fontSize: 10.sp,
            color: AppColors.textGrey,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PriceBlock(amount: course.tuitionFee, currency: course.currency),
            const Spacer(),
            ArrowPillButton(onPressed: onEnroll),
          ],
        ),
      ],
    );
  }
}
