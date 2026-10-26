import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/feature/courses/presentation/screens/course_datails.dart';
import 'package:uniflow/feature/courses/presentation/screens/course_details.dart';
import 'package:uniflow/feature/courses/presentation/widget/category_chips.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_card.dart';
import 'package:uniflow/feature/courses/presentation/widget/courses_app_bar.dart';
import 'package:uniflow/feature/courses/presentation/widget/section_header.dart';
import 'package:uniflow/feature/courses/presentation/widget/session_filter_bar.dart';

import '../../data/models/course.dart';

/// الشاشة الرئيسية: تجمع كل الـ widgets وتدير الـ state فقط.
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int _category = 0;
  final Set<String> _bookmarked = {};

  static const _categories = [
    'Architecture',
    'Civil Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Electronics & Communication',
    'Information Technology',
    'Interior Design',
    'Pharmaceutical',
    'Dentistry',
  ];

  static const _courses = [
    Course(
      id: '2',
      title: 'Course Title \\ Name',
      university: 'College-University',
      imageUrl: 'https://picsum.photos/seed/struct/600/400',
      enrolledLabel: '890 Enrolled',
      department: 'Structural Eng',
      term: 'Semester 2',
      rating: 4.2,
      tuitionFee: 1800000,
    ),
    Course(
      id: '3',
      title: 'Course Title \\ Name',
      university: 'College-University',
      imageUrl: 'https://picsum.photos/seed/elec/600/400',
      enrolledLabel: '2.1k Enrolled',
      department: 'Electrical Lab',
      term: 'Full Year',
      rating: 4.2,
      tuitionFee: 1800000,
    ),
    Course(
      id: '4',
      title: 'Course Title \\ Name',
      university: 'College-University',
      imageUrl: 'https://picsum.photos/seed/mech/600/400',
      enrolledLabel: '640 Enrolled',
      department: 'Mechanical',
      term: 'Spring 2025',
      rating: 4.2,
      tuitionFee: 1800000,
    ),
    Course(
      id: '5',
      title: 'Course Title \\ Name',
      university: 'College-University',
      imageUrl: 'https://picsum.photos/seed/pharma/600/400',
      enrolledLabel: '3.2k Enrolled',
      department: 'Pharmacy & Bio',
      term: 'Full Program',
      rating: 4.2,
      tuitionFee: 1800000,
    ),
  ];

  void _toggleBookmark(String id) {
    setState(() {
      _bookmarked.contains(id) ? _bookmarked.remove(id) : _bookmarked.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: CoursesAppBar(onSearch: () {}, onFilter: () {}, onProfile: () {}),
      body: CustomScrollView(
        slivers: [
          // ---------- الهيدر (يسكرول مع القائمة) ----------
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SessionFilterBar(
                    time: '10:00',
                    sessionLabel: 'Morning Session',
                    activeFilters: 3,
                    onFilterTap: () {},
                  ),
                ),
                const SizedBox(height: 12),
                CategoryChips(
                  categories: _categories,
                  selectedIndex: _category,
                  onSelected: (i) => setState(() => _category = i),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SectionHeader(
                    title: 'Showing ${_courses.length} Featured Courses',
                    // trailing: 'Verified Syllabus',
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // ---------- قائمة الكورسات (lazy) ----------
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                final course = _courses[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CourseCard(
                    course: course,
                    isBookmarked: _bookmarked.contains(course.id),
                    onBookmark: () => _toggleBookmark(course.id),
                    onEnroll: () {},
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDatailScreen(),
                        ),
                      );
                    },
                  ),
                );
              }, childCount: _courses.length),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.giant)),
        ],
      ),
    );
  }
}
