import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
class PlayCircleButton extends StatelessWidget {
  const PlayCircleButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: const BoxDecoration(
          color: AppColors.ligthGray,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.play_arrow_rounded,
            size: 20.sp, color: AppColors.textBlack),
      ),
    );
  }
}
