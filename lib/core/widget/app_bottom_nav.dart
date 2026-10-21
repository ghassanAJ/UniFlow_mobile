import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

class BottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

/// شريط تنقّل سفلي عائم بتأثير Liquid Glass (blur + مؤشر سائل).
/// استخدمه مع Scaffold(extendBody: true) ليظهر المحتوى خلف الزجاج.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  /// المساحة التي يشغلها الشريط — أضفها لـ padding السفلي بالقوائم.
  static double get floatingSpace => 564.h + 12.h + 16.h;

  @override
  Widget build(BuildContext context) {
    final n = items.length;
    final radius = BorderRadius.circular(32.r);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: DecoratedBox(
          // الظل خارج الـ blur
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                height: 64.h,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withAlpha(170),
                      Colors.white.withAlpha(90),
                    ],
                  ),
                  border: Border.all(color: Colors.white.withAlpha(180)),
                ),
                child: Stack(
                  children: [
                    // المؤشر السائل الذي ينزلق بين العناصر
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 380),
                      curve: Curves.easeOutBack,
                      alignment: Alignment(
                        n <= 1 ? 0 : -1 + 2 * currentIndex / (n - 1),
                        0,
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 1 / n,
                        heightFactor: 1,
                        child: Padding(
                          padding: EdgeInsets.all(6.r),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26.r),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.secondary,
                                  AppColors.primary,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(90),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < n; i++)
                          Expanded(
                            child: _NavButton(
                              item: items[i],
                              selected: i == currentIndex,
                              onTap: () {
                                if (i != currentIndex) {
                                  HapticFeedback.selectionClick();
                                }
                                onTap(i);
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final BottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.textWhite : AppColors.textGrey;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: selected ? 1.12 : 1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(end: color),
              duration: const Duration(milliseconds: 250),
              builder: (_, c, __) => Icon(
                selected ? (item.activeIcon ?? item.icon) : item.icon,
                color: c,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 10.sp,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
            child: Text(item.label, maxLines: 1),
          ),
        ],
      ),
    );
  }
}
