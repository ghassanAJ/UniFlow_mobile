import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/style/formatters.dart';

/// السعر: TUITION FEE + 1,800,000 S.P
class PriceBlock extends StatelessWidget {
  const PriceBlock({
    super.key,
    required this.amount,
    this.currency = 'S.P',
    this.caption = 'Tuition Fee',
  });

  final num amount;
  final String currency;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          caption,
          style: AppTextStyles.s12w400.copyWith(
            fontSize: 10.sp,
            color: AppColors.textGrey,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${formatPrice(amount)} $currency',
          style: AppTextStyles.s14w600.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
