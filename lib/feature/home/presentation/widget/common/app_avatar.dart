import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';


/// صورة دائرية، مع حدّ اختياري ونقطة "متصل".
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.url,
    this.radius = 22,
    this.borderColor,
    this.showOnlineDot = false,
  });

  final String url;
  final double radius;
  final Color? borderColor;
  final bool showOnlineDot;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: borderColor == null
                ? null
                : Border.all(color: borderColor!, width: 2),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.primarySoft,
            backgroundImage: NetworkImage(url),
          ),
        ),
        if (showOnlineDot)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
