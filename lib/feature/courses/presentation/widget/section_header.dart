import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
        ),
        const Spacer(),
        if (trailing != null)
          Text(
            trailing!,
            style: AppTextStyles.s12w400.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
              decoration: TextDecoration.underline,
            ),
          ),
      ],
    );
  }
}
