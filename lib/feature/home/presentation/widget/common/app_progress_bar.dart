import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import '../../core/app_colors.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key, required this.value, this.height = 5});

  final double value; // 0..1
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: AppColors.border,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}
