import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

import 'package:uniflow/feature/enrolls/data/models/enroll_item.dart';

/// ألوان ونصوص كل حالة — عدّلها من مكان واحد.
extension EnrollStatusStyle on EnrollStatus {
  String get label => switch (this) {
        EnrollStatus.active => 'Active',
        EnrollStatus.completed => 'Completed',
        EnrollStatus.suspended => 'Suspended',
      };

  Color get color => switch (this) {
        EnrollStatus.active => AppColors.primary,
        EnrollStatus.completed => AppColors.textGreen,
        EnrollStatus.suspended => AppColors.textRed,
      };

  Color get softColor => color.withAlpha(28);
}
