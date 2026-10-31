import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';

/// Segmented tab bar for course details, styled with design-system tokens.
class CourseDetailsTabs extends StatelessWidget {
  const CourseDetailsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg.w,
        AppSpacing.md.h,
        AppSpacing.lg.w,
        AppSpacing.sm.h,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceMuted,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xs.r),
          child: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            labelColor: colors.onPrimary,
            unselectedLabelColor: colors.textSecondary,
            labelStyle: context.ds.typography.label.copyWith(
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: context.ds.typography.label,
            labelPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            tabs: [
              Tab(height: 40.h, text: 'Chapter'),
              Tab(height: 40.h, text: 'About'),
              Tab(height: 40.h, text: 'Reviews'),
            ],
          ),
        ),
      ),
    );
  }
}
