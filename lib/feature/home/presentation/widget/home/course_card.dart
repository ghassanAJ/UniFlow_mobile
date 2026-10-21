import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../core/app_colors.dart';
// import '../../core/app_text_styles.dart';
// import '../../models/models.dart';
import '../common/app_card.dart';
import '../common/app_image.dart';
import '../common/rating_badge.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    this.width = 190,
    this.onTap,
    this.onAddTap,
    this.onBookmarkTap,
  });

  final Course course;
  final double width;
  final VoidCallback? onTap, onAddTap, onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppImage(
                    url: course.imageUrl,
                    width: double.infinity,
                    height: 110,
                    radius: 14),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: RatingBadge(rating: course.rating),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: onBookmarkTap,
                    child: const CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.bookmark,
                          size: 15, color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(course.category,
                style: AppTextStyles.link
                    .copyWith(fontSize: 10, letterSpacing: .4)),
            const SizedBox(height: 2),
            Text(course.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle),
            const SizedBox(height: 4),
            Text(course.faculty,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.copyWith(fontSize: 10)),
            const Spacer(),
            const Divider(height: 14, color: AppColors.border),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tuition',
                          style: AppTextStyles.body.copyWith(fontSize: 9)),
                      Text(course.price,
                          style: AppTextStyles.link.copyWith(fontSize: 11)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onAddTap,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add,
                        size: 16, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
