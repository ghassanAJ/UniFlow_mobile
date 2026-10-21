import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../core/app_colors.dart';
// import '../../core/app_text_styles.dart';
// import '../../models/models.dart';
import '../common/app_card.dart';
import '../common/app_image.dart';
import '../common/app_progress_bar.dart';
import '../common/info_tag.dart';

class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({super.key, required this.course, this.onTap});

  final ActiveCourse course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              const InfoTag(label: 'Active Course'),
              const Spacer(),
              const Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text('${course.watchedVideos} Of ${course.totalVideos} Videos',
                  style: AppTextStyles.body),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AppImage(url: course.imageUrl, width: 56, height: 56),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle),
                    const SizedBox(height: 2),
                    Text('${course.college} • ${course.instructor}',
                        style: AppTextStyles.body),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppProgressBar(value: course.progress),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text('${(course.progress * 100).round()}% Completed',
                style: AppTextStyles.link.copyWith(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
