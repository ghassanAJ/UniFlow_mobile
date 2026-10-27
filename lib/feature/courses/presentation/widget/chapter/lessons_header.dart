import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
class LessonsHeader extends StatelessWidget {
  const LessonsHeader({super.key, required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.s16w600.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textBlack,
            ),
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

