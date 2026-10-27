import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/widget/liquid_glass.dart';
class GlassTabItem {
  final String label;
  final IconData icon;
  final int? count;
  const GlassTabItem(this.label, this.icon, {this.count});
}

/// تبديل Videos / Files — إطار زجاجي + مؤشر برتقالي ينزلق مع السحب.
/// يعتمد على DefaultTabController (أو controller يدوي).
class GlassTabSwitcher extends StatelessWidget {
  const GlassTabSwitcher({
    super.key,
    required this.items,
    this.controller,
    this.onTap,
  });

  final List<GlassTabItem> items;
  final TabController? controller;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final c = controller ?? DefaultTabController.maybeOf(context);
    assert(c != null, 'GlassTabSwitcher يحتاج DefaultTabController فوقه.');
    final n = items.length;

    return LiquidGlass(
      borderRadius: 28,
      blur: 18,
      tint: AppColors.backgroundWhiteWidget,
      tintOpacity: .6,
      borderOpacity: .9,
      shadow: true,
      padding: EdgeInsets.all(4.r),
      child: SizedBox(
        height: 44.h,
        child: AnimatedBuilder(
          animation: c!.animation ?? c,
          builder: (_, __) {
            final value = c.animation?.value ?? c.index.toDouble();
            final current = value.round();
            return Stack(
              children: [
                // المؤشر: يتبع قيمة السحب بشكل مستمر
                Align(
                  alignment: Alignment(n <= 1 ? 0 : -1 + 2 * value / (n - 1), 0),
                  child: FractionallySizedBox(
                    widthFactor: 1 / n,
                    heightFactor: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(80),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var i = 0; i < n; i++)
                      Expanded(
                        child: _GlassTab(
                          item: items[i],
                          selected: i == current,
                          onTap: () {
                            c.animateTo(i);
                            onTap?.call(i);
                          },
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GlassTab extends StatelessWidget {
  const _GlassTab({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final GlassTabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.textWhite : AppColors.textGrey;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 16.sp, color: color),
          SizedBox(width: 6.w),
          Text(
            item.label,
            style: AppTextStyles.s14w600.copyWith(fontSize: 13.sp, color: color),
          ),
          if (item.count != null) ...[
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withAlpha(60)
                    : AppColors.ligthGray,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${item.count}',
                style: AppTextStyles.s12w400.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.textWhite : AppColors.textGrey,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

