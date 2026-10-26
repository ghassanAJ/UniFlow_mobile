import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/avatar_widget.dart';
import 'package:uniflow/feature/courses/presentation/widget/tab_view_widget.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.screenHorizontal,
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 220.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: const Color.fromARGB(255, 231, 229, 229),
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              RowNameCoursAndDescWidget(),
              SizedBox(height: AppSpacing.lg),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  'UX for Beginner : Complete Design System & Prototype',
                  style: AppTextStyles.title.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              RowCourseInfoWidget(),
              SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const DsAvatar(
                        assetPath: 'assets/images/avatar.png',
                        size: AvatarSize.md,
                        shape: AvatarShape.rounded,
                        showBorder: true,
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alex Johnson', style: AppTextStyles.cardTitle),
                          Text(
                            'Senior UX Lead at Spotify',
                            style: AppTextStyles.s14w500.copyWith(
                              color: const Color.fromARGB(179, 115, 115, 115),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'view profile',
                    style: AppTextStyles.link.copyWith(
                      color: AppColors.appBarBlack,
                    ),
                  ),
                ],
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TebsBarswidget(),
                    SizedBox(
                      child: TabBarView(
                        children: [
                          Container(
                            color: Colors.amberAccent,
                            width: double.infinity,
                            height: 500,
                          ),
                        ],
                      ),
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

class RowCourseInfoWidget extends StatelessWidget {
  const RowCourseInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: AppColors.accent, size: 18),
              Text('4.2', style: AppTextStyles.cardTitle),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.download_done_rounded,
                color: AppColors.titleGrey,
                size: 18,
              ),
              Text(
                '2,450 Students',
                style: AppTextStyles.s12w400.copyWith(
                  color: AppColors.titleGrey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.hourglass_bottom_rounded,
                color: AppColors.titleGrey,
                size: 18,
              ),
              Row(
                children: [
                  Text(
                    '28 video ',
                    style: AppTextStyles.s12w400.copyWith(
                      color: AppColors.titleGrey,
                    ),
                  ),
                  Icon(Icons.circle, color: AppColors.textSilver, size: 6),
                  Text(
                    ' 20 Hours ',
                    style: AppTextStyles.s12w400.copyWith(
                      color: AppColors.titleGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RowNameCoursAndDescWidget extends StatelessWidget {
  const RowNameCoursAndDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Color(0xffFFF5F0),
            border: Border.all(color: Color(0xffFFE9E0), width: 0.5),
          ),
          child: Text(
            'UI /UX Design',
            style: AppTextStyles.s14w600.copyWith(
              color: AppColors.appBarBlack,
              fontSize: 10.sp,
            ),
          ),
        ),
        Text(
          'Design Academy Institute',
          style: AppTextStyles.s14w500.copyWith(
            fontSize: 12.sp,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}


