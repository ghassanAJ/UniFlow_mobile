import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/router/app_routes.dart';
import 'package:uniflow/feature/home/data/remote/mock_data.dart';
import 'package:uniflow/feature/home/presentation/widget/common/section_header.dart';
import 'package:uniflow/feature/home/presentation/widget/home/announcement_card.dart';
import 'package:uniflow/feature/home/presentation/widget/home/app_bottom_nav.dart';
import 'package:uniflow/feature/home/presentation/widget/home/category_list.dart';
import 'package:uniflow/feature/home/presentation/widget/home/continue_learning_card.dart';
import 'package:uniflow/feature/home/presentation/widget/home/course_list.dart';
import 'package:uniflow/feature/home/presentation/widget/home/home_header.dart';
import 'package:uniflow/feature/home/presentation/widget/home/promo_banner.dart';
import 'package:uniflow/feature/home/presentation/widget/home/teacher_list.dart';
// import '../core/app_colors.dart';
// import '../data/mock_data.dart';
// import '../widgets/common/section_header.dart';
// import '../widgets/home/announcement_card.dart';
// import '../widgets/home/app_bottom_nav.dart';
// import '../widgets/home/category_list.dart';
// import '../widgets/home/continue_learning_card.dart';
// import '../widgets/home/course_list.dart';
// import '../widgets/home/home_header.dart';
// import '../widgets/home/promo_banner.dart';
// import '../widgets/home/teacher_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _categoryIndex = 0;
  int _navIndex = 0;

  static const _pad = EdgeInsets.symmetric(horizontal: 20);
  static const _gap = SizedBox(height: 22);
  static const _smallGap = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(
              userName: 'Maya Lin',
              avatarUrl: 'https://i.pravatar.cc/150?img=5',
            ),
            _gap,
            const Padding(
              padding: _pad,
              child: SectionHeader(
                title: 'Continue Learning',
                actionLabel: 'Resume',
              ),
            ),
            _smallGap,
            const Padding(
              padding: _pad,
              child: ContinueLearningCard(course: MockData.activeCourse),
            ),
            _gap,
            const Padding(
              padding: _pad,
              child: PromoBanner(
                tag: 'SPRING TERM 2025',
                title: 'New Semester Electives Are Now Open!',
                subtitle:
                    'Register early for studio slots and earn\naccredited laboratory credits.',
                buttonLabel: 'Explore Catalog',
              ),
            ),
            _gap,
            // const Padding(
            //   padding: _pad,
            //   child: widget(child: SectionHeader(title: 'Category', actionLabel: 'See all')),
            // ),
            _smallGap,
            CategoryList(
              categories: MockData.categories,
              selectedIndex: _categoryIndex,
              onSelected: (i) => setState(() => _categoryIndex = i),
            ),
            _gap,
            Padding(
              padding: _pad,
              child: SectionHeader(
                title: 'Recommended Courses',
                subtitle: 'Curated for your academic degree',
                actionLabel: 'View All',
                onActionTap: () => context.push(AppRoutes.courses),
              ),
            ),
            _smallGap,
            const CourseList(courses: MockData.courses),
            _gap,
            Padding(
              padding: _pad,
              child: SectionHeader(
                onActionTap: () => context.push(AppRoutes.teachers),
                title: 'Top Teachers',
                actionLabel: 'See all',
              ),
            ),
            _smallGap,
             Padding(
              padding: _pad,
              child: TeacherList(teachers: MockData.teachers,onTeacherTap: (value) {
                context.push(AppRoutes.teacherDetails);
              },),
            ),
            _gap,
            const Padding(
              padding: _pad,
              child: SectionHeader(
                title: 'University Announcements',
                actionLabel: 'Latest Updates',
                actionColor: AppColors.textGrey,
              ),
            ),
            _smallGap,
            const Padding(
              padding: _pad,
              child: AnnouncementCard(announcement: MockData.announcement),
            ),
            SizedBox(height: AppSpacing.giant),
          ],
        ),
      ),
    );
  }
}
