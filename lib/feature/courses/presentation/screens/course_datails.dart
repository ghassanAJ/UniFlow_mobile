import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/design/design_system.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_about_tab.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_details_header.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_details_tabs.dart';
import 'package:uniflow/feature/courses/presentation/widget/course_reviews_tab.dart';

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
    final pagePad = context.pagePadding;

    return Scaffold(
      backgroundColor: colors.background,
      bottomNavigationBar: CourseDetailsEnrollBar(
        price: 1800000,
        onEnroll: () {},
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      pagePad.left,
                      AppSpacing.screenVertical.h,
                      pagePad.right,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusXl.r,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 220.h,
                            child: Image.network(
                              'https://picsum.photos/seed/uxcourse/900/600',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  ColoredBox(color: colors.surfaceMuted),
                            ),
                          ),
                        ),
                        SizedBox(height: AppSpacing.xl.h),
                        const CourseDetailsCategoryRow(
                          category: 'UI / UX Design',
                          provider: 'Design Academy Institute',
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        DsText(
                          'UX for Beginners: Complete Design System & Prototype',
                          role: DsTextRole.headline,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        const CourseDetailsStatsRow(
                          rating: '4.2',
                          studentsLabel: '2,450 Students',
                          videosLabel: '28 videos',
                          hoursLabel: '20 Hours',
                        ),
                        SizedBox(height: AppSpacing.md.h),
                        CourseDetailsInstructorRow(
                          name: 'Alex Johnson',
                          subtitle: 'Senior UX Lead at Spotify',
                          initials: 'AJ',
                          onViewProfile: () {},
                        ),
                        SizedBox(height: AppSpacing.sm.h),
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

class _ChapterList extends StatelessWidget {
  const _ChapterList({required this.chapters});

  final List<(String, String)> chapters;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;
    final pagePad = context.pagePadding;

    return CustomScrollView(
      key: const PageStorageKey('course-chapters'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            pagePad.left,
            AppSpacing.md.h,
            pagePad.right,
            AppSpacing.xxl.h,
          ),
          sliver: SliverList.separated(
            itemCount: chapters.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppSpacing.sm.h),
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              final number = (index + 1).toString().padLeft(2, '0');

              return DsCard(
                variant: DsCardVariant.outlined,
                borderColor: colors.border,
                padding: EdgeInsets.all(AppSpacing.md.r),
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd.r,
                        ),
                      ),
                      child: DsText(
                        number,
                        role: DsTextRole.label,
                        color: colors.primary,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DsText(
                            chapter.$1,
                            role: DsTextRole.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: AppSpacing.xxs.h),
                          DsText(chapter.$2, role: DsTextRole.caption),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20.sp,
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

  @override
  double get minExtent => 72;

  @override
  double get maxExtent => 72;

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
        child: CourseDetailsTabs(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedTabsHeaderDelegate oldDelegate) {
    return oldDelegate.background != background;
  }
}
