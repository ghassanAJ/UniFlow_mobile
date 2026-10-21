import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

/// Tabs على شكل pills، مرتبطة بـ TabController (تدعم السحب والضغط).
class EnrollStatusTabs extends StatelessWidget {
  final TabController controller;
  final List<String> labels;

  const EnrollStatusTabs({
    super.key,
    required this.controller,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation ?? controller,
      builder: (_, __) {
        final selected =
            (controller.animation?.value ?? controller.index.toDouble())
                .round();
        return Row(
          children: [
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0) SizedBox(width: 8.w),
              Expanded(
                child: _TabPill(
                  label: labels[i],
                  selected: i == selected,
                  onTap: () => controller.animateTo(i),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.buttonPrimary : AppColors.ligthGray,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.s14w600.copyWith(
            color: selected ? AppColors.textWhite : AppColors.textBlack,
          ),
        ),
      ),
    );
  }
}
