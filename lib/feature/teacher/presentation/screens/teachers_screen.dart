import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/avatar_widget.dart';
import 'package:uniflow/feature/teacher/presentation/widget/category_tab_bar.dart';
import 'package:uniflow/feature/teacher/presentation/widget/search_filter_bar.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: SearchFilterBar(),
          ),
          // SizedBox(height: AppSpacing.sm),
          CategoryTabBar(labels: ['All', 'Design', 'Develpoment', 'Business']),
          SizedBox(height: AppSpacing.buttonContentGap),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RowTitleTeacherWidget(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: SizedBox(
                child: ListView.separated(
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      height: 190.h,
                      decoration: BoxDecoration(
                        color: AppColors.appBarWhite,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          // AvatarTokens()
                          Row(
                            children: [
                              DsAvatar(size: AvatarSize.lg),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. Harry Holland',
                                    style: AppTextStyles.s14w600,
                                  ),
                                  Text(
                                    'Senior Product Design Lead & Mentor',
                                    style: AppTextStyles.s12w400.copyWith(
                                      color: AppColors.textSilver,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // height: 16.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        999.r,
                                      ),
                                      color: const Color.fromARGB(
                                        255,
                                        231,
                                        229,
                                        229,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.book_rounded,
                                          color: AppColors.borderOrange,
                                          size: 14,
                                        ),
                                        Text(
                                          '4 Course',
                                          style: AppTextStyles.s12w400.copyWith(
                                            color: Color(0xff5A413A),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    // height: 16.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        999.r,
                                      ),
                                      color: const Color.fromARGB(
                                        255,
                                        231,
                                        229,
                                        229,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person_pin_circle_rounded,
                                          color: AppColors.borderOrange,
                                          size: 14,
                                        ),
                                        Text(
                                          '1,276 students',
                                          style: AppTextStyles.s12w400.copyWith(
                                            color: Color(0xff5A413A),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //TODO: rating
                            ],
                          ),

                          Expanded(
                            child: Text(
                              'Dedicated mentor with over 9 years in human-centered design and UI systems helping students…',
                              style: AppTextStyles.s12w400.copyWith(
                                color: AppColors.textSilver,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, _) =>
                      SizedBox(height: AppSpacing.lg),
                  itemCount: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowTitleTeacherWidget extends StatelessWidget {
  const RowTitleTeacherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Faculty & Mentors', style: AppTextStyles.s14w600),
            Text(
              'Learn from vetted university teachers',
              style: AppTextStyles.s12w400.copyWith(
                color: AppColors.textSilver,
              ),
            ),
          ],
        ),
        Container(
          // height: 16.h,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999.r),
            color: const Color.fromARGB(255, 231, 229, 229),
          ),
          child: Text(
            '6 Available',
            style: AppTextStyles.s12w400.copyWith(
              color: Color(0xff5A413A),
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}
