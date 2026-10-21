import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

import 'package:uniflow/feature/enrolls/data/models/enroll_item.dart';
import 'enroll_status_style.dart';

class EnrollStatusBadge extends StatelessWidget {
  final EnrollStatus status;
  const EnrollStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: status.softColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.s12w400.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: status.color,
        ),
      ),
    );
  }
}
