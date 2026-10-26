import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

/// تاب بار أفقي (chips) مبني على TabBar الأصلي.
/// يقرأ الـ TabController من أقرب DefaultTabController تلقائياً
/// (أو مرّر controller يدوياً).
///
/// عدد [labels] لازم يساوي length تبع DefaultTabController.
class CategoryTabBar extends StatefulWidget {
  CategoryTabBar({
    super.key,
    required this.labels,
    this.controller,
    this.onTap,
    this.padding = EdgeInsets.zero,
  });

  final List<String> labels;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final EdgeInsetsGeometry padding;

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  late int selected = 0;

  @override
  Widget build(BuildContext context) {
    // final c = controller ?? DefaultTabController.maybeOf(context);
    // assert(
    //   c != null,
    //   'CategoryTabBar يحتاج DefaultTabController فوقه أو controller يدوي.',
    // );
    // assert(
    //   c!.length == labels.length,
    //   'عدد labels (${labels.length}) لازم يساوي length التاب (${c.length}).',
    // );

    return SizedBox(
      // height: 55.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(4, (i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selected = i;
                  });
                },
                child: AnimatedContainer(
                  height: 42.h,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  duration: const Duration(milliseconds: 220),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected == i
                        ? AppColors.primary
                        : AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: selected == i
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(90),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : const [],
                  ),
                  child: Text(
                    widget.labels[i],
                    style: AppTextStyles.s12w400.copyWith(
                      color: selected == i
                          ? AppColors.textWhite
                          : AppColors.retingback,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      // child: TabBar(
      //   controller: c,
      //   isScrollable: true,
      //   tabAlignment: TabAlignment.start,
      //   padding: padding,
      //   onTap: onTap,
      //   // لا مؤشر ولا خط ولا ripple: الـ chip نفسه يرسم حالة الاختيار
      //   indicator: const BoxDecoration(),
      //   dividerColor: Colors.transparent,
      //   splashFactory: NoSplash.splashFactory,
      //   overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      //   labelPadding: EdgeInsets.only(right: 10.w),
      //   tabs: [
      //     for (var i = 0; i < labels.length; i++)
      //       Tab(
      //         height: 44.h,
      //         child: _CategoryChip(controller: c!, index: i, label: labels[i]),
      //       ),
      //   ],
      // ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.controller,
    required this.index,
    required this.label,
  });

  final TabController controller;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // animation يتحدّث أثناء السحب بين التابات أيضاً
      animation: controller.animation ?? controller,
      builder: (_, __) {
        final current =
            (controller.animation?.value ?? controller.index.toDouble())
                .round();
        final selected = current == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.primarySoft,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(70),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : const [],
          ),
          child: Text(
            label,
            style: AppTextStyles.s14w600.copyWith(
              color: selected ? AppColors.textWhite : AppColors.retingback,
            ),
          ),
        );
      },
    );
  }
}
