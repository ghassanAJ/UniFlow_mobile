import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import '../../core/app_colors.dart';
import 'app_icon_button.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.hint = 'Search class, category, mentor...',
    this.onChanged,
    this.onFilterTap,
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 12, color: AppColors.textGrey),
                border: InputBorder.none,
              ),
            ),
          ),
          AppIconButton(
            icon: Icons.tune,
            color: AppColors.primary,
            backgroundColor: AppColors.primarySoft,
            onTap: onFilterTap,
          ),
        ],
      ),
    );
  }
}
