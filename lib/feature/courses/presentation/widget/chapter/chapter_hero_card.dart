import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/liquid_glass.dart';
import 'package:uniflow/feature/courses/data/models/chapter_models.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/glass_pill.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/glass_stat_chip.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/thin_progress_bar.dart';
/// الكرت البرتقالي الرئيسي (الفصل الحالي) مع chips زجاجية.
class ChapterHeroCard extends StatelessWidget {
  const ChapterHeroCard({super.key, required this.info});

  final ChapterInfo info;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(26.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(70),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
          child: Stack(
            children: [
              // دوائر زخرفية خلف الزجاج (تعطي عمق لتأثير الـ blur)
              Positioned(
                top: -40.r,
                right: -30.r,
                child: _GlowCircle(size: 140, opacity: .18),
              ),
              Positioned(
                bottom: -50.r,
                left: -30.r,
                child: _GlowCircle(size: 120, opacity: .12),
              ),
              Padding(
                padding: EdgeInsets.all(18.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GlassPill(label: info.moduleLabel),
                        const Spacer(),
                        Text(
                          '${(info.progress * 100).round()}% Completed',
                          style: AppTextStyles.s12w400.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      info.title,
                      style: AppTextStyles.s20w600.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: AppColors.textWhite,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      info.description,
                      style: AppTextStyles.s12w400.copyWith(
                        height: 1.5,
                        color: AppColors.textWhite.withAlpha(225),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    ThinProgressBar(
                      value: info.progress,
                      color: AppColors.textWhite,
                      trackColor: Colors.white.withAlpha(70),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: GlassStatChip(
                            icon: Icons.play_circle_outline_rounded,
                            label: '${info.videosCount} Videos',
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: GlassStatChip(
                            icon: Icons.access_time_rounded,
                            label: '${info.totalMinutes} Mins',
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: GlassStatChip(
                            icon: Icons.check_circle_outline_rounded,
                            label: '${info.quizzesCount} Quiz',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(liquidGlassAlpha(opacity)),
      ),
    );
  }
}

