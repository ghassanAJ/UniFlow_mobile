import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import '../../core/app_colors.dart';
// import '../../core/app_text_styles.dart';

/// عنوان قسم + رابط اختياري (See all / View All / Resume ...).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.actionColor = AppColors.primary,
    this.onActionTap,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final Color actionColor;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.title),
              if (subtitle != null) Text(subtitle!, style: AppTextStyles.body),
            ],
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionLabel!,
                style: AppTextStyles.link.copyWith(color: actionColor)),
          ),
      ],
    );
  }
}
