import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

import 'package:uniflow/feature/enrolls/data/models/enroll_item.dart';
import 'enroll_card.dart';

/// قائمة كروت (lazy) مع حالة فاضية.
class EnrollsList extends StatelessWidget {
  final List<EnrollItem> items;
  final ValueChanged<EnrollItem>? onItemTap;
  final String emptyMessage;

  const EnrollsList({
    super.key,
    required this.items,
    this.onItemTap,
    this.emptyMessage = 'No courses here yet',
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 48.sp, color: AppColors.lightGrey),
            SizedBox(height: 8.h),
            Text(
              emptyMessage,
              style: AppTextStyles.s14w500.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 14.h),
      itemBuilder: (_, i) => EnrollCard(
        item: items[i],
        onTap: onItemTap == null ? null : () => onItemTap!(items[i]),
      ),
    );
  }
}
