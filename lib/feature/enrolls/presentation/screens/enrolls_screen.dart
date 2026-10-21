import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/feature/enrolls/data/models/enroll_item.dart';
import 'package:uniflow/feature/enrolls/presentation/widget/enroll_status_style.dart';
import 'package:uniflow/feature/enrolls/presentation/widget/enroll_status_tabs.dart';
import 'package:uniflow/feature/enrolls/presentation/widget/enrolls_app_bar.dart';
import 'package:uniflow/feature/enrolls/presentation/widget/enrolls_list.dart';

/// الشاشة الرئيسية: تجمع الـ widgets وتدير الـ TabController فقط.
class EnrollsScreen extends StatefulWidget {
  const EnrollsScreen({super.key});

  @override
  State<EnrollsScreen> createState() => _EnrollsScreenState();
}

class _EnrollsScreenState extends State<EnrollsScreen>
    with SingleTickerProviderStateMixin {
  // ترتيب الحالات = ترتيب التابات
  static const _statuses = EnrollStatus.values;

  late final TabController _tabController =
      TabController(length: _statuses.length, vsync: this);

  // بيانات تجريبية — استبدلها بالـ API
  static const _items = <EnrollItem>[
    EnrollItem(
      id: '1',
      title: 'UX & UI Design Masterclass',
      category: 'Design & Innovation',
      status: EnrollStatus.active,
      watchedVideos: 31,
      totalVideos: 40,
      icon: Icons.brush_rounded,
      iconColor: Color(0xFFE8552A),
      tileColor: Color(0xFFFFF5E1),
    ),
    EnrollItem(
      id: '2',
      title: 'Full-Stack Web Architecture',
      category: 'Coding & Cloud Systems',
      status: EnrollStatus.active,
      watchedVideos: 18,
      totalVideos: 36,
      icon: Icons.code_rounded,
      iconColor: Color(0xFF3B82F6),
      tileColor: Color(0xFFE8F2FF),
    ),
    EnrollItem(
      id: '3',
      title: 'AI & Machine Learning Lab',
      category: 'Artificial Intelligence',
      status: EnrollStatus.active,
      watchedVideos: 3,
      totalVideos: 12,
      icon: Icons.smart_toy_rounded,
      iconColor: Color(0xFF6366F1),
      tileColor: Color(0xFFEEEEFF),
    ),
    EnrollItem(
      id: '4',
      title: 'Cybersecurity & Data Privacy',
      category: 'Security & Compliance',
      status: EnrollStatus.active,
      watchedVideos: 3,
      totalVideos: 12,
      icon: Icons.shield_rounded,
      iconColor: Color(0xFF10B981),
      tileColor: Color(0xFFE6F8F1),
    ),
    EnrollItem(
      id: '5',
      title: 'Intro to Product Management',
      category: 'Business',
      status: EnrollStatus.completed,
      watchedVideos: 20,
      totalVideos: 20,
      icon: Icons.insights_rounded,
      iconColor: Color(0xFFF59E0B),
      tileColor: Color(0xFFFFF5E1),
    ),
    EnrollItem(
      id: '6',
      title: 'Mobile App Development',
      category: 'Coding & Cloud Systems',
      status: EnrollStatus.suspended,
      watchedVideos: 8,
      totalVideos: 30,
      icon: Icons.phone_iphone_rounded,
      iconColor: Color(0xFF3B82F6),
      tileColor: Color(0xFFE8F2FF),
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<EnrollItem> _byStatus(EnrollStatus s) =>
      _items.where((e) => e.status == s).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const EnrollsAppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: EnrollStatusTabs(
              controller: _tabController,
              labels: [for (final s in _statuses) s.label],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                for (final s in _statuses)
                  EnrollsList(
                    items: _byStatus(s),
                    emptyMessage: 'No ${s.label.toLowerCase()} courses',
                    onItemTap: (item) {},
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
