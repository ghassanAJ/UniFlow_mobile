import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

class NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const NavItem(this.label, this.icon, this.activeIcon);
}

class AppBottomNav extends StatelessWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: AppColors.backgroundWhiteWidget,
      indicatorColor: AppColors.primarySoft,
      elevation: 8,
      labelTextStyle: WidgetStatePropertyAll(
        AppTextStyles.s12w400.copyWith(fontSize: 11.sp),
      ),
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.icon, color: AppColors.iconGrey),
            selectedIcon: Icon(item.activeIcon, color: AppColors.primary),
            label: item.label,
          ),
      ],
    );
  }
}
