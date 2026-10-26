import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/avatar_widget.dart';
import 'package:uniflow/feature/courses/presentation/screens/course_details.dart';
import 'package:uniflow/feature/courses/presentation/widget/tab_view_widget.dart';

class CourseDatailScreen extends StatefulWidget {
  const CourseDatailScreen({super.key});

  @override
  State<CourseDatailScreen> createState() => _CourseDatailScreenState();
}

class _CourseDatailScreenState extends State<CourseDatailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenVertical,
          vertical: AppSpacing.screenVertical,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
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
                              Text(
                                'Alex Johnson',
                                style: AppTextStyles.cardTitle,
                              ),
                              Text(
                                'Senior UX Lead at Spotify',
                                style: AppTextStyles.s14w500.copyWith(
                                  color: const Color.fromARGB(
                                    179,
                                    115,
                                    115,
                                    115,
                                  ),
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
                ],
              ),
            ),

            SliverFillRemaining(
              child: DefaultTabController(
                length: 3,
                initialIndex: 1,
                child: Column(
                  children: [
                    TebsBarswidget(),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.separated(
                            itemBuilder: (context, id) {
                              return Container(
                                padding: EdgeInsets.all(AppSpacing.md),
                                width: double.infinity,
                                // height: 66.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      255,
                                      241,
                                      208,
                                      204,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          // padding: EdgeInsets.all(AppSpacing.md),
                                          width: 36.h,
                                          height: 36.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFE9E0),
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                          ),
                                          child: Text(
                                            '0${id + 1}',
                                            style: AppTextStyles.cardTitle
                                                .copyWith(
                                                  color: AppColors
                                                      .appBarlightbottom,
                                                ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Alex Johnson',
                                              style: AppTextStyles.cardTitle,
                                            ),
                                            Text(
                                              'Senior UX Lead at Spotify',
                                              style: AppTextStyles.s14w500
                                                  .copyWith(
                                                    color: const Color.fromARGB(
                                                      150,
                                                      115,
                                                      115,
                                                      115,
                                                    ),
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: AppColors.lightGrey,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, _) =>
                                SizedBox(height: AppSpacing.lg),
                            itemCount: 10,
                          ),
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: const [
                              Text('About this course100000'),
                              SizedBox(height: 12),
                              Text('Learn the fundamentals of UX design.'),
                            ],
                          ),
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: const [
                              Text('About thise'),
                              SizedBox(height: 12),
                              Text('Learn the fundamentals of UX design.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
