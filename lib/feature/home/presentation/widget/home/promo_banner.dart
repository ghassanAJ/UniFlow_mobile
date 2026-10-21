import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import '../../core/app_colors.dart';
import '../common/app_pill_button.dart';
import '../common/info_tag.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.icon = Icons.school_outlined,
    this.onButtonTap,
  });

  final String tag, title, subtitle, buttonLabel;
  final IconData icon;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoTag(
                  label: tag,
                  backgroundColor: Colors.white.withAlpha(60),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1.25)),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 10.5)),
                const SizedBox(height: 12),
                AppPillButton(
                  label: buttonLabel,
                  icon: Icons.arrow_forward,
                  onPressed: onButtonTap,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
