import 'package:flutter/material.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../models/models.dart';
import 'course_card.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
    required this.courses,
    this.onCourseTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final List<Course> courses;
  final ValueChanged<Course>? onCourseTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => CourseCard(
          course: courses[i],
          onTap: () => onCourseTap?.call(courses[i]),
        ),
      ),
    );
  }
}
