import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// عنصر إحصائية واحد (قيمة + عنوان).
class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = AppColors.textBlack,
    this.valueIcon,
  });

  final String value;
  final String label;
  final Color valueColor;
  final IconData? valueIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppTextStyles.s18w600.copyWith(
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
            if (valueIcon != null) ...[
              SizedBox(width: 3.w),
              Icon(valueIcon, size: 15.sp, color: valueColor),
            ],
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.s12w400.copyWith(
            fontSize: 9.sp,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}

/// صف إحصائيات مفصول بخطوط عمودية.
class StatsRow extends StatelessWidget {
  const StatsRow({super.key, required this.items});

  final List<StatItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget.withAlpha(210),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderBrand),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Expanded(child: Center(child: items[i])),
            if (i != items.length - 1)
              Container(width: 1, height: 28.h, color: AppColors.borderBrand),
          ],
        ],
      ),
    );
  }
}
