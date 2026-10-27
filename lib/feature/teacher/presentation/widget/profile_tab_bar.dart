import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';

/// عنصر تاب (نص + رقم اختياري).
class ProfileTabItem {
  final String label;
  final int? count;
  const ProfileTabItem(this.label, {this.count});
}

/// تاب بار على شكل pills، يعتمد على DefaultTabController (أو controller يدوي).
class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    super.key,
    required this.items,
    this.controller,
    this.onTap,
  });

  final List<ProfileTabItem> items;
  final TabController? controller;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final c = controller ?? DefaultTabController.maybeOf(context);
    assert(c != null, 'ProfileTabBar يحتاج DefaultTabController فوقه.');

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.ligthGray,
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: AnimatedBuilder(
        animation: c!.animation ?? c,
        builder: (_, __) {
          final current = (c.animation?.value ?? c.index.toDouble()).round();
          return Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _ProfileTabPill(
                    item: items[i],
                    selected: i == current,
                    onTap: () {
                      c.animateTo(i);
                      onTap?.call(i);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileTabPill extends StatelessWidget {
  const _ProfileTabPill({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ProfileTabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? AppColors.textWhite : AppColors.textGrey;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 38.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.buttonPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.label,
              style: AppTextStyles.s14w600.copyWith(
                fontSize: 13.sp,
                color: textColor,
              ),
            ),
            if (item.count != null) ...[
              SizedBox(width: 6.w),
              if (selected)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(60),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${item.count}',
                    style: AppTextStyles.s12w400.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                )
              else
                Text(
                  '(${item.count})',
                  style: AppTextStyles.s12w400.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
