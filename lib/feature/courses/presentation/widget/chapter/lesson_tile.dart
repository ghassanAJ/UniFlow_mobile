import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/courses/data/models/chapter_models.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/lesson_meta.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/lesson_thumbnail.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/part_pill.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/play_circle_button.dart';

class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.lesson, this.onPlay});

  final VideoLesson lesson;
  final VoidCallback? onPlay;

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
          LessonThumbnail(
            url: lesson.thumbnailUrl,
            width: 64,
            height: 64,
            radius: 32,
            onPlay: onPlay,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PartPill(part: lesson.part),
                SizedBox(height: 6.h),
                Text(
                  lesson.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w600.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                LessonMeta(
                  minutes: lesson.minutes,
                  watchedPercent: lesson.watchedPercent,
                ),
              ],
            ),
          ),
          PlayCircleButton(onTap: onPlay),
        ],
      ),
    );
  }
}

