import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/teacher/data/models/teacher_course.dart';
import 'package:uniflow/feature/teacher/data/models/teacher_profile.dart';
import 'package:uniflow/feature/teacher/presentation/widget/profile_tab_bar.dart';
import 'package:uniflow/feature/teacher/presentation/widget/section_title.dart';
import 'package:uniflow/feature/teacher/presentation/widget/teacher_app_bar.dart';
import 'package:uniflow/feature/teacher/presentation/widget/teacher_course_card.dart';
import 'package:uniflow/feature/teacher/presentation/widget/teacher_profile_header.dart';

/// الشاشة: تجمع الـ widgets وتدير الـ state فقط.
/// ملاحظة: لا يوجد bottom nav هنا — الـ AppShell هو المسؤول عنه.
class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key, this.bottomSpace = 24});

  /// مساحة سفلية إضافية (مثلاً AppBottomNav.floatingSpace إذا استخدمت الـ nav العائم).
  final double bottomSpace;

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  bool _following = false;
  bool _saved = false;
  final Set<String> _bookmarked = {};

  // بيانات تجريبية — استبدلها بالـ API
  static const _profile = TeacherProfile(
    name: 'Harry Holland',
    title: 'Senior Product Design Lead & Academic Mentor',
    college: 'College of Computing & Digital Arts',
    bio:
        "Bio About Teacher's Experience And Specialization or Subjects. "
        'Dedicated mentor with over 9 years in human-centered design, '
        'helping students turn ideas into shipped products.',
    avatarUrl: 'https://i.pravatar.cc/300?img=12',
    coursesCount: 4,
    studentsCount: 1273,
    rating: 4.9,
    reviewsCount: 148,
  );

  static const _courses = <TeacherCourse>[
    TeacherCourse(
      id: '1',
      title: 'UX for Beginner: Zero to Hero',
      imageUrl: 'https://picsum.photos/seed/ux/600/400',
      rating: 4.2,
      ratingCount: 320,
      tag: 'Bestseller',
      institute: 'College-University',
      department: 'Dept of Tech & Design',
      instructor: 'Harry Holland',
      instructorCourses: 4,
      lectures: 16,
      tuitionFee: 1800000,
    ),
    TeacherCourse(
      id: '2',
      title: 'Complete Web Development Bootcamp',
      imageUrl: 'https://picsum.photos/seed/webdev/600/400',
      rating: 4.9,
      ratingCount: 489,
      tag: 'Popular Cohort',
      institute: 'College-University',
      department: 'Dept of Tech & Design',
      instructor: 'Harry Holland',
      instructorCourses: 4,
      lectures: 32,
      tuitionFee: 2400000,
    ),
    TeacherCourse(
      id: '3',
      title: 'Advanced Figma & Design Systems',
      imageUrl: 'https://picsum.photos/seed/figma/600/400',
      rating: 4.8,
      ratingCount: 214,
      institute: 'College-University',
      department: 'Dept of Tech & Design',
      instructor: 'Harry Holland',
      instructorCourses: 4,
      lectures: 20,
      tuitionFee: 1650000,
    ),
  ];

  void _toggleBookmark(String id) => setState(() {
    _bookmarked.contains(id) ? _bookmarked.remove(id) : _bookmarked.add(id);
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: TeacherAppBar(onMore: () {}, onProfile: () {}),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                child: TeacherProfileHeader(
                  profile: _profile,
                  isFollowing: _following,
                  isSaved: _saved,
                  onFollow: () => setState(() => _following = !_following),
                  onSave: () => setState(() => _saved = !_saved),
                  onShare: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: ProfileTabBar(
                  items: [
                    ProfileTabItem('Courses', count: _courses.length),
                    const ProfileTabItem('About'),
                    ProfileTabItem('Reviews', count: _profile.reviewsCount),
                  ],
                ),
              ),
            ),
            _TabContent(
              courses: _courses,
              profile: _profile,
              bookmarked: _bookmarked,
              onBookmark: _toggleBookmark,
              bottomSpace: widget.bottomSpace,
            ),
          ],
        ),
      ),
    );
  }
}

/// محتوى التاب الحالي (Sliver) — يقرأ DefaultTabController.
class _TabContent extends StatelessWidget {
  const _TabContent({
    required this.courses,
    required this.profile,
    required this.bookmarked,
    required this.onBookmark,
    required this.bottomSpace,
  });

  final List<TeacherCourse> courses;
  final TeacherProfile profile;
  final Set<String> bookmarked;
  final ValueChanged<String> onBookmark;
  final double bottomSpace;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        switch (controller.index) {
          case 0:
            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                    child: SectionTitle(
                      title: 'Available Courses',
                      subtitle: 'Structured cohorts and on-demand syllabus',
                      trailing: '${courses.length} Enrolling Now',
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, bottomSpace.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final c = courses[i];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: TeacherCourseCard(
                          course: c,
                          isBookmarked: bookmarked.contains(c.id),
                          onBookmark: () => onBookmark(c.id),
                          onEnroll: () {},
                          onTap: () {},
                        ),
                      );
                    }, childCount: courses.length),
                  ),
                ),
              ],
            );
          case 1:
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, bottomSpace.h),
                child: Text(
                  profile.bio,
                  style: AppTextStyles.s14w400.copyWith(
                    height: 1.6,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            );
          default:
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, bottomSpace.h),
                child: Center(
                  child: Text(
                    'Reviews (${profile.reviewsCount}) — قريباً',
                    style: AppTextStyles.s14w500.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
