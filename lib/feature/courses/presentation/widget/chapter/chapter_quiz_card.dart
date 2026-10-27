import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/courses/data/models/chapter_models.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/chapter_action_button.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/required_badge.dart';
class ChapterQuizCard extends StatelessWidget {
  const ChapterQuizCard({super.key, required this.quiz, this.onStart});

  final ChapterQuiz quiz;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    final meta = AppTextStyles.s12w400.copyWith(
      fontSize: 11.sp,
      color: AppColors.textGrey,
    );

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderBrand),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.quiz_rounded,
                    size: 22.sp, color: AppColors.iconWhite),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            quiz.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s14w600.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                        if (quiz.isRequired) ...[
                          SizedBox(width: 8.w),
                          const RequiredBadge(),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text.rich(
                      TextSpan(
                        style: meta,
                        children: [
                          TextSpan(text: '${quiz.questions} Questions'),
                          const TextSpan(text: '  •  '),
                          TextSpan(
                            text: '${quiz.points} Points',
                            style: meta.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textBlack,
                            ),
                          ),
                          const TextSpan(text: '  •  '),
                          TextSpan(text: '${quiz.minutes} Mins'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ChapterActionButton(
            label: 'Take Chapter Quiz',
            leadingIcon: Icons.play_circle_outline_rounded,
            trailingIcon: Icons.arrow_forward_rounded,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}

