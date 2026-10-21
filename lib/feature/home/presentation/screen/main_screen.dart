import 'package:flutter/material.dart';
import 'package:uniflow/core/widget/app_shell.dart';
import 'package:uniflow/feature/courses/presentation/screens/courses_screen.dart';
import 'package:uniflow/feature/enrolls/presentation/screens/enrolls_screen.dart';
import 'package:uniflow/feature/home/presentation/screen/home_screen.dart';

import '../../../../core/widget/app_bottom_nav.dart';

/// لإضافة شاشة جديدة: أضف ShellTab واحد هنا فقط.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      initialIndex: 2,
      tabs: [
        ShellTab(
          item: const BottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
          ),
          builder: (_) => HomeScreen(), // ← استبدلها بشاشة الـ Home
        ),
        // ShellTab(
        //   item: const BottomNavItem(
        //     icon: Icons.search_rounded,
        //     label: 'Search',
        //   ),
        //   builder: (_) => const _Placeholder('Search'),
        // ),
        ShellTab(
          item: const BottomNavItem(
            icon: Icons.menu_book_outlined,
            activeIcon: Icons.menu_book_rounded,
            label: 'Courses',
          ),
          builder: (_) => const CoursesScreen(),
        ),
        ShellTab(
          item: const BottomNavItem(
            icon: Icons.assignment_outlined,
            activeIcon: Icons.assignment_rounded,
            label: 'Enrolls',
          ),
          builder: (_) => const EnrollsScreen(),
        ),
        // ShellTab(
        //   item: const BottomNavItem(
        //     icon: Icons.person_outline_rounded,
        //     activeIcon: Icons.person_rounded,
        //     label: 'Profile',
        //   ),
        //   builder: (_) => const _Placeholder('Profile'),
        // ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder(this.title);

  @override
  Widget build(BuildContext context) => Center(child: Text(title));
}
