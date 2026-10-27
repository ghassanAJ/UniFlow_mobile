import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
class LessonMeta extends StatelessWidget {
  const LessonMeta({super.key, required this.minutes, this.watchedPercent});

  final int minutes;
  final int? watchedPercent;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.s12w400.copyWith(
      fontSize: 10.sp,
      color: AppColors.textGrey,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time_rounded, size: 12.sp, color: AppColors.textGrey),
        SizedBox(width: 4.w),
        Text('$minutes Mins', style: style),
        if (watchedPercent != null) ...[
          Text('  •  ', style: style),
          Text(
            '$watchedPercent% Watched',
            style: style.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ],
    );
  }
}

