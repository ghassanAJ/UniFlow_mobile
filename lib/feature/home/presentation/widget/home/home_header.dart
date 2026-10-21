import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import '../../core/app_colors.dart';
import '../common/app_avatar.dart';
import '../common/app_icon_button.dart';
import '../common/app_search_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarUrl,
    this.greeting = 'Hi, Good Morning',
    this.onNotificationTap,
    this.onSearchChanged,
    this.onFilterTap,
  });

  final String userName, avatarUrl, greeting;
  final VoidCallback? onNotificationTap, onFilterTap;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppAvatar(url: avatarUrl, radius: 20, showOnlineDot: true),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(greeting,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11)),
                    Text(userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              AppIconButton(
                icon: Icons.notifications_none_rounded,
                showDot: true,
                onTap: onNotificationTap,
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppSearchBar(onChanged: onSearchChanged, onFilterTap: onFilterTap),
        ],
      ),
    );
  }
}
