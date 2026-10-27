import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

class EnrollsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onMore;

  const EnrollsAppBar({
    super.key,
    this.title = 'Enrolls',
    this.onBack,
    this.onMore,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundWhiteWidget,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: onBack ?? () {
          if (context.canPop()) context.pop();
        },
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textBlack),
      ),
      title: Text(
        title,
        style: AppTextStyles.s18w600.copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.textBlack,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: GestureDetector(
            onTap: onMore,
            child: Container(
              width: 34.r,
              height: 34.r,
              decoration: const BoxDecoration(
                color: AppColors.ligthGray,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.more_vert_rounded,
                  size: 18.sp, color: AppColors.textBlack),
            ),
          ),
        ),
      ],
    );
  }
}
