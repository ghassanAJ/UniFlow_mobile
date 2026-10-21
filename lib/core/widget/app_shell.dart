import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';

import 'app_bottom_nav.dart';

/// تاب واحد = عنصر nav + الشاشة التابعة له.
class ShellTab {
  final BottomNavItem item;
  final WidgetBuilder builder;
  const ShellTab({required this.item, required this.builder});
}

/// الهيكل الأساسي: يعرض الـ nav العائم ويبدّل بين الشاشات.
/// - يحافظ على حالة كل شاشة (IndexedStack).
/// - لا يبني الشاشة إلا عند أول زيارة (lazy).
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.tabs, this.initialIndex = 0})
    : assert(tabs.length >= 2);

  final List<ShellTab> tabs;
  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;
  late final Set<int> _visited = {widget.initialIndex};

  void _select(int i) => setState(() {
    _index = i;
    _visited.add(i);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      extendBody: true, // يخلّي المحتوى يمتد خلف الزجاج
      body: IndexedStack(
        index: _index,
        children: [
          for (var i = 0; i < widget.tabs.length; i++)
            _visited.contains(i)
                ? widget.tabs[i].builder(context)
                : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        items: [for (final t in widget.tabs) t.item],
        currentIndex: _index,
        onTap: _select,
      ),
    );
  }
}
