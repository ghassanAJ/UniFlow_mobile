import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/courses/presentation/screens/course_details.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_about_tab.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_reviews_tab.dart';
import 'package:uniflow/feature/courses/presentation/widget/tab_view_widget.dart';

class CourseDatailScreen extends StatefulWidget {
  const CourseDatailScreen({super.key});

  @override
  State<CourseDatailScreen> createState() => _CourseDatailScreenState();
}

class _CourseDatailScreenState extends State<CourseDatailScreen> {
  static const _chapters = [
    ('Introduction to UX Thinking', '12 min'),
    ('User Research Basics', '18 min'),
    ('Wireframing Fundamentals', '22 min'),
    ('Design Systems 101', '26 min'),
    ('Interactive Prototyping', '20 min'),
    ('Usability Testing', '16 min'),
    ('Handoff & Documentation', '14 min'),
    ('Portfolio Case Study', '24 min'),
    ('Final Project Brief', '10 min'),
    ('Course Wrap-up', '8 min'),
  ];

  static const _reviews = [
    CourseReview(
      author: 'Sara Ahmed',
      role: 'Product Designer',
      comment:
          'Clear lessons and strong practical examples. The design system module alone was worth it.',
      rating: 5,
      dateLabel: '2 weeks ago',
    ),
    CourseReview(
      author: 'Omar Khaled',
      role: 'CS Student',
      comment:
          'Great for beginners. I wish there were more Figma exercises, but the flow is easy to follow.',
      rating: 4,
      dateLabel: '1 month ago',
    ),
    CourseReview(
      author: 'Lina Faris',
      role: 'UI Intern',
      comment:
          'Loved the prototype section. Mentors explain decisions, not only tools.',
      rating: 5,
      dateLabel: '1 month ago',
    ),
    CourseReview(
      author: 'Yousef Nabil',
      comment:
          'Solid structure and good pacing. Would recommend for first UX course.',
      rating: 4.5,
      dateLabel: '2 months ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenHorizontal,
                      AppSpacing.screenVertical,
                      AppSpacing.screenHorizontal,
                      0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 220.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusXl.r,
                            ),
                            color: colors.surfaceMuted,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const RowNameCoursAndDescWidget(),
                        const SizedBox(height: AppSpacing.lg),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                          ),
                          child: DsText(
                            'UX for Beginner : Complete Design System & Prototype',
                            role: DsTextRole.title,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const RowCourseInfoWidget(),
                        const SizedBox(height: AppSpacing.lg),
                        const _InstructorRow(),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),
                ),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: _PinnedTabsHeaderDelegate(
                      background: colors.background,
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Builder(
                  builder: (context) => _ChapterList(chapters: _chapters),
                ),
                Builder(
                  builder: (context) => const CourseAboutTab(
                    description:
                        'A practical beginner UX course covering research, wireframing, design systems, and high-fidelity prototyping. Build a complete product flow from idea to interactive prototype.',
                    level: 'Beginner',
                    language: 'English',
                    lastUpdated: 'Updated Oct 2026',
                    outcomes: [
                      'Create user flows and wireframes with confidence',
                      'Build a reusable UI design system',
                      'Prototype interactive screens for usability testing',
                      'Present design decisions with clear rationale',
                    ],
                    requirements: [
                      'No prior UX experience required',
                      'A laptop with Figma installed',
                      'Willingness to practice weekly',
                    ],
                    includes: [
                      CourseAboutInclude(
                        icon: Icons.play_circle_outline_rounded,
                        label: '28 videos',
                      ),
                      CourseAboutInclude(
                        icon: Icons.access_time_rounded,
                        label: '20 hours',
                      ),
                      CourseAboutInclude(
                        icon: Icons.download_rounded,
                        label: 'Downloadable resources',
                      ),
                      CourseAboutInclude(
                        icon: Icons.phone_android_rounded,
                        label: 'Mobile & desktop',
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) => CourseReviewsTab(
                    averageRating: 4.6,
                    totalReviews: _reviews.length,
                    ratingDistribution: const {
                      5: 2,
                      4: 2,
                      3: 0,
                      2: 0,
                      1: 0,
                    },
                    reviews: _reviews,
                    onWriteReview: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstructorRow extends StatelessWidget {
  const _InstructorRow();

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Row(
      children: [
        const DsAvatar(
          assetPath: 'assets/images/avatar.png',
          size: AvatarSize.md,
          shape: AvatarShape.rounded,
          showBorder: true,
          initials: 'AJ',
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DsText(
                'Alex Johnson',
                role: DsTextRole.titleSmall,
                color: colors.textPrimary,
              ),
              DsText(
                'Senior UX Lead at Spotify',
                role: DsTextRole.caption,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
        DsText(
          'view profile',
          role: DsTextRole.label,
          color: colors.primary,
        ),
      ],
    );
  }
}

class _ChapterList extends StatelessWidget {
  const _ChapterList({required this.chapters});

  final List<(String, String)> chapters;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return CustomScrollView(
      key: const PageStorageKey('course-chapters'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
          ),
          sliver: SliverList.separated(
            itemCount: chapters.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              final number = (index + 1).toString().padLeft(2, '0');

              return DsCard(
                variant: DsCardVariant.outlined,
                borderColor: colors.primarySoft,
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusPill,
                        ),
                      ),
                      child: DsText(
                        number,
                        role: DsTextRole.label,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DsText(
                            chapter.$1,
                            role: DsTextRole.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          DsText(chapter.$2, role: DsTextRole.caption),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: colors.textMuted,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PinnedTabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PinnedTabsHeaderDelegate({required this.background});

  final Color background;

  static const double _height = 72;

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: background,
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: TebsBarswidget(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedTabsHeaderDelegate oldDelegate) {
    return oldDelegate.background != background;
  }
}
