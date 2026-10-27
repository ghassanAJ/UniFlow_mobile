import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';

/// صورة دائرية مع إطار برتقالي وشارة توثيق.
class TeacherAvatar extends StatelessWidget {
  const TeacherAvatar({
    super.key,
    required this.imageUrl,
    this.size = 88,
    this.verified = true,
  });

  final String imageUrl;
  final double size;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.r,
      height: size.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.r,
            height: size.r,
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundWhiteWidget,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color.fromARGB(255, 248, 243, 242),
                  // child: Icon(
                  //   Icons.person_rounded,
                  //   size: (size * .5).sp,
                  //   color: AppColors.primary,
                  // ),
                ),
              ),
            ),
          ),
          if (verified)
            Positioned(
              right: 0,
              bottom: 2.r,
              child: Container(
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.backgroundWhiteWidget,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 13.sp,
                  color: AppColors.iconWhite,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
