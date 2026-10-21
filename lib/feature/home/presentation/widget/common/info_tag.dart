import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
// import '../../core/app_colors.dart';

/// وسم صغير (Active Course / Academic / SPRING TERM ...).
class InfoTag extends StatelessWidget {
  const InfoTag({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.primarySoft,
    this.textColor = AppColors.primary,
  });

  final String label;
  final Color backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w700, color: textColor),
      ),
    );
  }
}
