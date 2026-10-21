import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/style/formatters.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

// import '../core/formatters.dart';

class TuitionFee extends StatelessWidget {
  final num amount;
  final String currency;
  final String caption;

  const TuitionFee({
    super.key,
    required this.amount,
    this.currency = 'S.P',
    this.caption = 'TUITION FEE',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          caption,
          style: AppTextStyles.s12w400.copyWith(
            fontSize: 9.sp,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            color: AppColors.textGrey,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${formatNumber(amount)} $currency',
          style: AppTextStyles.s14w600.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
