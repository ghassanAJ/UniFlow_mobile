import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/feature/home/data/model/models.dart';
// import '../../core/app_colors.dart';
// import '../../core/app_text_styles.dart';
// import '../../models/models.dart';
import '../common/app_card.dart';
import '../common/app_image.dart';
import '../common/info_tag.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement, this.onTap});

  final Announcement announcement;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          AppImage(url: announcement.imageUrl, width: 64, height: 64),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InfoTag(label: announcement.tag),
                    const SizedBox(width: 6),
                    Text('• ${announcement.duration} • ${announcement.date}',
                        style: AppTextStyles.body.copyWith(fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(announcement.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle),
                const SizedBox(height: 2),
                Text(announcement.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
