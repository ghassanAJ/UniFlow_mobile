import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uniflow/core/widget/app_bottom_nav.dart';
import 'package:uniflow/core/widget/app_shell.dart';
import 'package:uniflow/feature/courses/presentation/screens/courses_screen.dart';
import 'package:uniflow/feature/enrolls/presentation/screens/enrolls_screen.dart';
import 'package:uniflow/feature/home/presentation/screen/home_screen.dart';
import 'package:uniflow/feature/profile/presentation/screen/profile_page.dart';

/// لإضافة شاشة جديدة: أضف ShellTab واحد هنا فقط.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuild nav labels when locale changes.
    context.locale;

    return AppShell(
      initialIndex: 0,
      tabs: [
        ShellTab(
          item: BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'nav.home'.tr(),
          ),
          builder: (_) => const HomeScreen(),
        ),
        ShellTab(
          item: BottomNavItem(
            icon: Icons.menu_book_outlined,
            activeIcon: Icons.menu_book_rounded,
            label: 'nav.courses'.tr(),
          ),
          builder: (_) => const CoursesScreen(),
        ),
        ShellTab(
          item: BottomNavItem(
            icon: Icons.assignment_outlined,
            activeIcon: Icons.assignment_rounded,
            label: 'nav.enrolls'.tr(),
          ),
          builder: (_) => const EnrollsScreen(),
        ),
        ShellTab(
          item: BottomNavItem(
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: 'nav.profile'.tr(),
          ),
          builder: (_) => const ProfileScreen(),
        ),
      ],
    );
  }
}
