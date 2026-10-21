import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';
// import 'package:uniflow/feature/home/data/model/models.dart';

// import '../models/course.dart';
import '../../data/models/course.dart';
import 'enroll_button.dart';
import 'image_tag.dart';
import 'rating_badge.dart';
import 'tuition_fee.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onEnroll;
  final VoidCallback? onBookmark;

  const CourseCard({
    super.key,
    required this.course,
    this.isBookmarked = false,
    this.onTap,
    this.onEnroll,
    this.onBookmark,
  });

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
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 3),
                blurRadius: 4,
                color: const Color.fromARGB(95, 212, 179, 162),
                spreadRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.circular(20.r),
            // border: Border.all(color: AppColors.borderBrand),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              Padding(
                padding: EdgeInsets.fromLTRB(6.w, 12.h, 6.w, 4.h),
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
        height: 180.h,

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
                  color: AppColors.iconGrey,
                  size: 32.sp,
                ),
              ),
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: ImageTag(
                label: course.enrolledLabel,
                icon: Icons.people_alt_rounded,
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: _BookmarkButton(active: isBookmarked, onTap: onBookmark),
            ),
            Positioned(
              bottom: 8.h,
              left: 8.w,
              child: ImageTag.primary(label: course.department),
            ),
            Positioned(
              bottom: 8.h,
              right: 8.w,
              child: ImageTag(label: course.term),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                course.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            RatingBadge(rating: course.rating),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          course.university,
          style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TuitionFee(amount: course.tuitionFee, currency: course.currency),
            const Spacer(),
            EnrollButton(onPressed: onEnroll),
          ],
        ),
      ],
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  final bool active;
  final VoidCallback? onTap;
  const _BookmarkButton({required this.active, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.r,
        height: 30.r,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhiteWidget.withAlpha(230),
          shape: BoxShape.circle,
        ),
        child: Icon(
          active ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: 16.sp,
          color: active ? AppColors.primary : AppColors.textBlack,
        ),
      ),
    );
  }
}
