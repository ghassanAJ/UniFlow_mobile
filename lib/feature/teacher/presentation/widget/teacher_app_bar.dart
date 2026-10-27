import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// AppBar: سهم رجوع + عنوان + قائمة + صورة المستخدم.
class TeacherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TeacherAppBar({
    super.key,
    this.title = 'Course Overview',
    this.onBack,
    this.onMore,
    this.onProfile,
    this.avatar,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onMore;
  final VoidCallback? onProfile;
  final ImageProvider? avatar;

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
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textBlack),
      ),
      title: Text(
        title,
        style: AppTextStyles.s16w600.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textBlack,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onMore,
          icon: const Icon(Icons.more_vert_rounded, color: AppColors.textBlack),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: GestureDetector(
            onTap: onProfile,
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: AppColors.primary,
              backgroundImage: avatar,
              child: avatar == null
                  ? Icon(Icons.person, size: 16.sp, color: AppColors.iconWhite)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
