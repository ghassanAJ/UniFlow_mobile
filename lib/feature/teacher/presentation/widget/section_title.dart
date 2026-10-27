import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// عنوان قسم + وصف + نص جانبي.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.s16w600.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle!,
                  style: AppTextStyles.s12w400.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: AppTextStyles.s12w400.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}
