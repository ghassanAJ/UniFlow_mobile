import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

class SessionFilterBar extends StatelessWidget {
  final String time;
  final String sessionLabel;
  final int activeFilters;
  final VoidCallback? onFilterTap;

  const SessionFilterBar({
    super.key,
    required this.time,
    required this.sessionLabel,
    this.activeFilters = 0,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhiteWidget,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderBrand),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    '$time · $sessionLabel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        OutlinedButton.icon(
          onPressed: onFilterTap,
          icon: Icon(Icons.filter_list_rounded, size: 16.sp),
          label: Text(
            activeFilters > 0 ? 'Filter ($activeFilters)' : 'Filter',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.borderPrimary),
            textStyle: AppTextStyles.s12w400.copyWith(
              fontWeight: FontWeight.w700,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            minimumSize: Size(0, 36.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
