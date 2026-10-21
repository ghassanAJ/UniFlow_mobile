import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

class EnrollProgressBar extends StatelessWidget {
  final double value; // 0..1
  final Color color;
  final double height;

  const EnrollProgressBar({
    super.key,
    required this.value,
    this.color = AppColors.primary,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value.clamp(0, 1)),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (_, v, __) => LinearProgressIndicator(
          value: v,
          minHeight: height.h,
          backgroundColor: AppColors.track,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
