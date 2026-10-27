import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
class ThinProgressBar extends StatelessWidget {
  const ThinProgressBar({
    super.key,
    required this.value,
    this.color = AppColors.primary,
    this.trackColor = AppColors.track,
    this.height = 5,
  });

  final double value;
  final Color color;
  final Color trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value.clamp(0, 1)),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        builder: (_, v, __) => LinearProgressIndicator(
          value: v,
          minHeight: height.h,
          backgroundColor: trackColor,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}

