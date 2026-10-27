import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/liquid_glass.dart';
class LessonThumbnail extends StatelessWidget {
  const LessonThumbnail({
    super.key,
    required this.url,
    this.width = 84,
    this.height = 68,
    this.radius = 14,
    this.durationLabel,
    this.highlightPlay = false,
    this.onPlay,
  });

  final String url;
  final double width;
  final double height;
  final double radius;
  final String? durationLabel;

  /// زر التشغيل برتقالي (للفيديو الحالي) بدل الزجاجي.
  final bool highlightPlay;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: SizedBox(
        width: width.w,
        height: height.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.borderBrand,
                child: Icon(Icons.image_outlined,
                    size: 24.sp, color: AppColors.iconGrey),
              ),
            ),
            Container(color: Colors.black.withAlpha(60)),
            Center(
              child: highlightPlay
                  ? Container(
                      width: 30.r,
                      height: 30.r,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                          size: 18.sp, color: AppColors.iconWhite),
                    )
                  : SizedBox(
                      width: 30.r,
                      height: 30.r,
                      child: LiquidGlass(
                        borderRadius: 999,
                        blur: 10,
                        tintOpacity: .25,
                        onTap: onPlay,
                        child: Icon(Icons.play_arrow_rounded,
                            size: 18.sp, color: AppColors.iconWhite),
                      ),
                    ),
            ),
            if (durationLabel != null && durationLabel!.isNotEmpty)
              Positioned(
                right: 6.w,
                bottom: 6.h,
                child: LiquidGlass(
                  borderRadius: 8,
                  blur: 8,
                  tint: Colors.black,
                  tintOpacity: .35,
                  borderOpacity: .2,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: Text(
                    durationLabel!,
                    style: AppTextStyles.s12w400.copyWith(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

