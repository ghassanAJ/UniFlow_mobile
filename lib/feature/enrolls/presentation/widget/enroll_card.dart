import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_style/app_text_styles.dart';

import 'package:uniflow/feature/enrolls/data/models/enroll_item.dart';
import 'enroll_progress_bar.dart';
import 'enroll_status_badge.dart';
import 'enroll_status_style.dart';

class EnrollCard extends StatelessWidget {
  final EnrollItem item;
  final VoidCallback? onTap;

  const EnrollCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = item.status.color;

    return Material(
      color: AppColors.backgroundWhiteWidget,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderBrand),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconTile(
                    icon: item.icon,
                    iconColor: item.iconColor,
                    background: item.tileColor,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.s14w600.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            EnrollStatusBadge(status: item.status),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Container(
                              width: 6.r,
                              height: 6.r,
                              decoration: BoxDecoration(
                                color: item.iconColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(
                                item.category,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.s12w400
                                    .copyWith(color: AppColors.textGrey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              EnrollProgressBar(value: item.progress, color: statusColor),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    '${item.watchedVideos} Of ${item.totalVideos} Videos',
                    style: AppTextStyles.s12w400
                        .copyWith(fontSize: 11.sp, color: AppColors.textGrey),
                  ),
                  const Spacer(),
                  Text(
                    '${item.percent}% Completed',
                    style: AppTextStyles.s12w400.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color background;

  const _IconTile({
    required this.icon,
    required this.iconColor,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.r,
      height: 46.r,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(icon, size: 22.sp, color: iconColor),
    );
  }
}
