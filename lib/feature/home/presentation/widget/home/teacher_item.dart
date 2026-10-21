import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../core/app_colors.dart';
// import '../../core/app_text_styles.dart';
// import '../../models/models.dart';
import '../common/app_avatar.dart';

class TeacherItem extends StatelessWidget {
  const TeacherItem({super.key, required this.teacher, this.onTap});

  final Teacher teacher;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            AppAvatar(
                url: teacher.imageUrl,
                radius: 28,
                borderColor: AppColors.primary),
            const SizedBox(height: 6),
            Text(teacher.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 12)),
            Text('${teacher.coursesCount} Courses',
                style: AppTextStyles.body.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
