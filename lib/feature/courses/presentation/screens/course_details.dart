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
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;

        Widget chip({
          required IconData icon,
          required Color iconColor,
          required String label,
          TextStyle? labelStyle,
          bool expand = false,
        }) {
          final text = Text(
            label,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ??
                AppTextStyles.s12w400.copyWith(color: AppColors.titleGrey),
          );

          return Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 18.sp),
              SizedBox(width: 4.w),
              if (expand) Expanded(child: text) else text,
            ],
          );
        }

        final rating = chip(
          icon: Icons.star_rounded,
          iconColor: AppColors.accent,
          label: '4.2',
          labelStyle: AppTextStyles.cardTitle,
        );
        final students = chip(
          icon: Icons.download_done_rounded,
          iconColor: AppColors.titleGrey,
          label: '2,450 Students',
          expand: !compact,
        );
        final duration = chip(
          icon: Icons.hourglass_bottom_rounded,
          iconColor: AppColors.titleGrey,
          label: '28 video · 20 Hours',
          expand: !compact,
        );

        if (compact) {
          return Wrap(
            spacing: AppSpacing.md.w,
            runSpacing: AppSpacing.sm.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [rating, students, duration],
          );
        }

        return Row(
          children: [
            rating,
            SizedBox(width: AppSpacing.sm.w),
            Expanded(child: students),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(child: duration),
          ],
        );
      },
    );
  }
}

class RowNameCoursAndDescWidget extends StatelessWidget {
  const RowNameCoursAndDescWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: const Color(0xffFFF5F0),
                border: Border.all(color: const Color(0xffFFE9E0), width: 0.5),
              ),
              child: Text(
                'UI /UX Design',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s14w600.copyWith(
                  color: AppColors.appBarBlack,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Flexible(
          child: Text(
            'Design Academy Institute',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTextStyles.s14w500.copyWith(
              fontSize: 12.sp,
              color: AppColors.textGrey,
            ),
          ),
        ),
      ],
    );
  }
}


