import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/app_spacing.dart';

/// Breakpoints and helpers for responsive layouts.
abstract final class DsBreakpoints {
  static const double compact = 360;
  static const double medium = 600;
  static const double expanded = 840;
}

extension DsResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isCompact => screenWidth < DsBreakpoints.compact;

  bool get isMedium =>
      screenWidth >= DsBreakpoints.compact &&
      screenWidth < DsBreakpoints.medium;

  bool get isExpanded => screenWidth >= DsBreakpoints.medium;

  /// Horizontal page padding that grows slightly on wider screens.
  EdgeInsets get pagePadding {
    final horizontal = screenWidth >= DsBreakpoints.medium
        ? AppSpacing.xxl
        : AppSpacing.lg;
    return EdgeInsets.symmetric(horizontal: horizontal.w);
  }

  /// Bottom inset so content clears the floating bottom nav.
  double get bottomNavClearance {
    final safe = MediaQuery.paddingOf(this).bottom;
    return 100.h + safe;
  }
}

/// Lays children in a [Row] when there is room, otherwise stacks them.
class DsResponsiveRow extends StatelessWidget {
  const DsResponsiveRow({
    super.key,
    required this.children,
    this.breakpoint = DsBreakpoints.compact,
    this.spacing = AppSpacing.md,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final double breakpoint;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stack = constraints.maxWidth < breakpoint;

        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(height: spacing.h),
                children[i],
              ],
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(width: spacing.w),
                Expanded(child: children[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}
