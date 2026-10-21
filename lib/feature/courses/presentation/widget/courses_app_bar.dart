import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

class CoursesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;
  final VoidCallback? onProfile;
  final ImageProvider? avatar;

  const CoursesAppBar({
    super.key,
    this.title = 'Courses',
    this.onSearch,
    this.onFilter,
    this.onProfile,
    this.avatar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundWhiteWidget,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16.w,
      title: Row(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.school_rounded,
                size: 18.sp, color: AppColors.primary),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: AppTextStyles.s18w600.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onSearch,
          icon: const Icon(Icons.search_rounded, color: AppColors.textBlack),
        ),
        IconButton(
          onPressed: onFilter,
          icon: const Icon(Icons.tune_rounded, color: AppColors.textBlack),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12.w, left: 4.w),
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
