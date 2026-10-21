import 'package:flutter/material.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../models/models.dart';
import '../common/app_card.dart';
import 'teacher_item.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({super.key, required this.teachers, this.onTeacherTap});

  final List<Teacher> teachers;
  final ValueChanged<Teacher>? onTeacherTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final t in teachers)
            TeacherItem(teacher: t, onTap: () => onTeacherTap?.call(t)),
        ],
      ),
    );
  }
}
