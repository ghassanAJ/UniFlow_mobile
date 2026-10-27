import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/style/app_text_styles.dart';
import 'package:uniflow/core/style/formatters.dart';
import 'package:uniflow/feature/teacher/data/models/teacher_profile.dart';
import 'package:uniflow/feature/teacher/presentation/widget/info_chip.dart';
import 'package:uniflow/feature/teacher/presentation/widget/primary_icon_button.dart';
import 'package:uniflow/feature/teacher/presentation/widget/square_icon_button.dart';
import 'package:uniflow/feature/teacher/presentation/widget/stats_row.dart';
import 'package:uniflow/feature/teacher/presentation/widget/teacher_avatar.dart';

/// بطاقة بروفايل المدرّس كاملة.
class TeacherProfileHeader extends StatelessWidget {
  const TeacherProfileHeader({
    super.key,
    required this.profile,
    this.isFollowing = false,
    this.isSaved = false,
    this.onFollow,
    this.onSave,
    this.onShare,
  });

  final TeacherProfile profile;
  final bool isFollowing;
  final bool isSaved;
  final VoidCallback? onFollow;
  final VoidCallback? onSave;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderBrand),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primarySoft, AppColors.backgroundWhiteWidget],
          stops: [0, .55],
        ),
      ),
      child: Column(
        children: [
          TeacherAvatar(
            imageUrl: profile.avatarUrl,
            verified: profile.isVerified,
          ),
          SizedBox(height: 12.h),
          Text(
            profile.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.s18w600.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            profile.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
          ),
          SizedBox(height: 10.h),
          InfoChip(label: profile.college),
          SizedBox(height: 16.h),
          StatsRow(
            items: [
              StatItem(value: '${profile.coursesCount}', label: 'COURSES'),
              StatItem(
                value: formatPrice(profile.studentsCount),
                label: 'STUDENTS',
              ),
              StatItem(
                value: profile.rating.toStringAsFixed(1),
                label: 'RATING',
                valueColor: AppColors.primary,
                valueIcon: Icons.star_rounded,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            profile.bio,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.s12w400.copyWith(
              height: 1.5,
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: PrimaryIconButton(
                  label: isFollowing ? 'Following' : 'Follow Mentor',
                  icon: isFollowing
                      ? Icons.check_rounded
                      : Icons.person_add_alt_1_rounded,
                  onPressed: onFollow,
                ),
              ),
              SizedBox(width: 10.w),
              SquareIconButton(
                icon: isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                active: isSaved,
                onTap: onSave,
              ),
              SizedBox(width: 10.w),
              SquareIconButton(icon: Icons.share_outlined, onTap: onShare),
            ],
          ),
        ],
      ),
    );
  }
}
