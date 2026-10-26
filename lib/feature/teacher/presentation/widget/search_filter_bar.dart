import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

/// شريط بحث مع زر فلتر دائري.
/// - للاستخدام كحقل بحث حقيقي: مرّر controller و onChanged / onSubmitted.
/// - للاستخدام كزر ينقل لشاشة البحث: readOnly: true مع onTap.
class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    this.hint = 'Search teacher, subject, mentor...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFilterTap,
    this.readOnly = false,
    this.activeFilters = 0,
    this.padding = EdgeInsets.zero,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final bool readOnly;

  /// عدد الفلاتر المفعّلة — إذا > 0 تظهر نقطة فوق زر الفلتر.
  final int activeFilters;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 56.h,
        padding: EdgeInsets.only(left: 18.w, right: 8.w),
        decoration: BoxDecoration(
          color: const Color.fromARGB(136, 241, 241, 241),
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 18.sp, color: AppColors.blackText),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                onTap: onTap,
                readOnly: readOnly,
                textInputAction: TextInputAction.search,
                cursorColor: AppColors.primary,
                style: AppTextStyles.s14w500.copyWith(
                  color: AppColors.textBlack,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            _FilterButton(onTap: onFilterTap, showDot: activeFilters > 0),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({this.onTap, this.showDot = false});

  final VoidCallback? onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 16.sp,
              color: AppColors.primary,
            ),
          ),
          if (showDot)
            Positioned(
              top: 2.r,
              right: 2.r,
              child: Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.ligthGray, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
