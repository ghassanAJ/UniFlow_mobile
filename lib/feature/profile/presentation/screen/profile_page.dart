import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/profile/data/models/profile_data.dart';
import 'package:uniflow/feature/profile/presentation/widget/profile_header_card.dart';
import 'package:uniflow/feature/profile/presentation/widget/profile_standing_card.dart';
import 'package:uniflow/feature/profile/presentation/widget/profile_stat_card.dart';
import 'package:uniflow/feature/profile/presentation/widget/profile_streak_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.data = demoProfile,
    this.onEdit,
    this.onLogout,
    this.onNotifications,
    this.onSavedCourses,
    this.onDownloads,
    this.onPrivacy,
    this.onTerms,
    this.onAbout,
    this.onDarkModeChanged,
  });

  final ProfileData data;
  final VoidCallback? onEdit;
  final VoidCallback? onLogout;
  final VoidCallback? onNotifications;
  final VoidCallback? onSavedCourses;
  final VoidCallback? onDownloads;
  final VoidCallback? onPrivacy;
  final VoidCallback? onTerms;
  final VoidCallback? onAbout;
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dark = false;

  void _toggleLanguage() {
    final isArabic = context.locale.languageCode == 'ar';
    context.setLocale(Locale(isArabic ? 'en' : 'ar'));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final d = widget.data;
    // `.tr()` doesn't subscribe to locale changes; reading it here does.
    context.locale;

    final pagePad = context.pagePadding;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                pagePad.left,
                AppSpacing.sm.h,
                pagePad.right,
                AppSpacing.sm.h,
              ),
              child: DsSectionHeader(
                title: 'profile.title'.tr(),
                titleRole: DsTextRole.headline,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DsIconButton(
                      icon: Icons.notifications_none_rounded,
                      variant: DsIconButtonVariant.ghost,
                      onPressed: widget.onNotifications,
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    DsAvatar(
                      size: AvatarSize.sm,
                      imageUrl: d.avatarUrl,
                      initials: d.initials,
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  pagePad.left,
                  AppSpacing.xs.h,
                  pagePad.right,
                  context.bottomNavClearance,
                ),
                children: [
                  DsSectionHeader(
                    title: 'profile.settings'.tr(),
                    trailing: DsButton(
                      label: 'profile.edit'.tr(),
                      leading: Icons.edit_outlined,
                      variant: DsButtonVariant.secondary,
                      size: DsButtonSize.sm,
                      onPressed: widget.onEdit,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  ProfileHeaderCard(data: d),
                  SizedBox(height: AppSpacing.lg.h),
                  DsSectionHeader(
                    title: 'profile.academicPerformance'.tr(),
                    icon: Icons.show_chart_rounded,
                    trailing: DsBadge(
                      label: d.semester,
                      backgroundColor: colors.primarySoft,
                      foregroundColor: colors.accent,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  ProfileStandingCard(data: d),
                  SizedBox(height: AppSpacing.md.h),
                  DsResponsiveRow(
                    children: [
                      ProfileStatCard(
                        icon: Icons.quiz_outlined,
                        title: 'profile.quizzesPerformance'.tr(),
                        value: '${d.quizzesPassed}/${d.quizzesTotal}',
                        caption: 'profile.quizzesPassed'.tr(
                          args: ['${d.quizzesAvgPercent}'],
                        ),
                        ratio: d.quizzesRatio,
                        barColor: colors.primary,
                      ),
                      ProfileStatCard(
                        icon: Icons.play_circle_outline_rounded,
                        title: 'profile.watchedVideos'.tr(),
                        value: '${d.videosWatched}/${d.videosTotal}',
                        caption: 'profile.completion'.tr(
                          args: ['${(d.videosRatio * 100).round()}'],
                        ),
                        ratio: d.videosRatio,
                        barColor: colors.accent,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  ProfileStreakCard(data: d),
                  SizedBox(height: AppSpacing.lg.h),
                  DsSectionHeader(
                    title: 'profile.settingsPreferences'.tr(),
                    icon: Icons.tune_rounded,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  _group([
                    DsListTile(
                      icon: Icons.bookmark_border_rounded,
                      title: 'profile.savedCourses'.tr(),
                      trailing: DsBadge(
                        label: 'profile.coursesCount'.tr(
                          args: ['${d.savedCourses}'],
                        ),
                        backgroundColor: colors.surfaceMuted,
                        foregroundColor: colors.textSecondary,
                      ),
                      onTap: widget.onSavedCourses,
                    ),
                    DsListTile(
                      icon: Icons.download_for_offline_outlined,
                      title: 'profile.downloads'.tr(),
                      subtitle: 'profile.downloadsSubtitle'.tr(),
                      trailing: DsBadge(
                        label: d.downloadsSize,
                        backgroundColor: colors.surfaceMuted,
                        foregroundColor: colors.textSecondary,
                      ),
                      onTap: widget.onDownloads,
                    ),
                  ]),
                  SizedBox(height: AppSpacing.md.h),
                  _group([
                    DsListTile(
                      icon: Icons.language_rounded,
                      title: 'profile.languages'.tr(),
                      showChevron: false,
                      trailing: DsBadge(
                        label: 'profile.currentLanguage'.tr(),
                        backgroundColor: colors.primarySoft,
                        foregroundColor: colors.accent,
                      ),
                      onTap: _toggleLanguage,
                    ),
                    DsListTile(
                      icon: Icons.nightlight_round_outlined,
                      title: 'profile.colorsMode'.tr(),
                      subtitle: _dark
                          ? 'profile.darkActive'.tr()
                          : 'profile.lightActive'.tr(),
                      showChevron: false,
                      trailing: DsSwitch(
                        value: _dark,
                        onChanged: (v) {
                          setState(() => _dark = v);
                          widget.onDarkModeChanged?.call(v);
                        },
                      ),
                    ),
                  ]),
                  SizedBox(height: AppSpacing.md.h),
                  _group([
                    DsListTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'profile.privacyPolicy'.tr(),
                      onTap: widget.onPrivacy,
                    ),
                    DsListTile(
                      icon: Icons.description_outlined,
                      title: 'profile.terms'.tr(),
                      onTap: widget.onTerms,
                    ),
                    DsListTile(
                      icon: Icons.info_outline_rounded,
                      title: 'profile.aboutUs'.tr(),
                      onTap: widget.onAbout,
                    ),
                  ]),
                  SizedBox(height: AppSpacing.lg.h),
                  DsButton(
                    label: 'profile.logout'.tr(),
                    leading: Icons.logout_rounded,
                    variant: DsButtonVariant.secondary,
                    size: DsButtonSize.lg,
                    expanded: true,
                    foregroundColor: colors.accent,
                    onPressed: widget.onLogout,
                  ),
                  SizedBox(height: AppSpacing.md.h),
                  Center(
                    child: DsText(
                      'profile.appVersion'.tr(args: ['2.4.1 (Build 420)']),
                      role: DsTextRole.overline,
                      color: colors.textMuted,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _group(List<Widget> tiles) {
    return DsCard(
      padding: EdgeInsets.zero,
      child: Column(children: tiles),
    );
  }
}
