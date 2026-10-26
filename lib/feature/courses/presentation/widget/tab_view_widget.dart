import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/core/design/app_spacing.dart';
// import 'package:uniflow/core/spacing/app_spacing.dart'; // عدّلي المسار حسب مشروعك
import 'package:uniflow/core/style/app_text_styles.dart';
// import 'package:uniflow/core/text_styles/app_text_styles.dart'; // عدّلي المسار حسب مشروعك

/// ───────────── Models ─────────────
class CourseLesson {
  const CourseLesson({
    required this.title,
    required this.minutes,
    this.isFreePreview = false,
  });
  final String title;
  final int minutes;
  final bool isFreePreview;
}

class CourseSection {
  const CourseSection({required this.title, required this.lessons});
  final String title;
  final List<CourseLesson> lessons;
  int get minutes => lessons.fold(0, (sum, l) => sum + l.minutes);
}

/// ───────────── Widget ─────────────
/// CourseDetailsView(
///   sections: [...], price: 1800000,
///   onEnroll: () {}, onLessonTap: (lesson) {},
///   about: MyAboutWidget(), reviews: MyReviewsWidget(),
/// )
///
/// التابات: DefaultTabController. الأقسام المفتوحة: ValueNotifier.
/// لا يوجد أي استدعاء لـ setState.
class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({
    super.key,
    required this.sections,
    required this.price,
    required this.onEnroll,
    this.onLessonTap,
    this.currency = 'S.P',
    this.about = const Center(child: Text('About')),
    this.reviews = const Center(child: Text('Reviews')),
  });

  final List<CourseSection> sections;
  final int price;
  final String currency;
  final VoidCallback onEnroll;
  final ValueChanged<CourseLesson>? onLessonTap;
  final Widget about, reviews;

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  late final _expanded = ValueNotifier<Set<int>>({0});

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }

  void _toggle(int i) {
    final next = {..._expanded.value};
    if (!next.remove(i)) next.add(i);
    _expanded.value = next;
  }

  void _toggleAll() => _expanded.value = _expanded.value.isNotEmpty
      ? <int>{}
      : {for (var i = 0; i < widget.sections.length; i++) i};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPage,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const _Tabs(),
              Expanded(
                child: TabBarView(
                  children: [
                    _Syllabus(
                      sections: widget.sections,
                      expanded: _expanded,
                      onToggle: _toggle,
                      onToggleAll: _toggleAll,
                      onLessonTap: widget.onLessonTap,
                    ),
                    widget.about,
                    widget.reviews,
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _EnrollBar(
          price: widget.price,
          currency: widget.currency,
          onEnroll: widget.onEnroll,
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs();

  @override
  Widget build(BuildContext context) {
    return TebsBarswidget();
  }
}

class TebsBarswidget extends StatelessWidget {
  const TebsBarswidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.track,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          labelColor: AppColors.textWhite,
          unselectedLabelColor: AppColors.textGrey,
          labelStyle: AppTextStyles.s14w600,
          unselectedLabelStyle: AppTextStyles.s14w500,
          indicator: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: .35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          tabs: const [
            Tab(height: AppSpacing.huge, text: 'chapter'),
            Tab(height: AppSpacing.huge, text: 'About'),
            Tab(height: AppSpacing.huge, text: 'Reviews'),
          ],
        ),
      ),
    );
  }
}

class _Syllabus extends StatelessWidget {
  const _Syllabus({
    required this.sections,
    required this.expanded,
    required this.onToggle,
    required this.onToggleAll,
    required this.onLessonTap,
  });

  final List<CourseSection> sections;
  final ValueNotifier<Set<int>> expanded;
  final ValueChanged<int> onToggle;
  final VoidCallback onToggleAll;
  final ValueChanged<CourseLesson>? onLessonTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('syllabus'),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(
                  'Course Content',
                  style: AppTextStyles.s18w600.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder<Set<int>>(
                  valueListenable: expanded,
                  builder: (_, open, __) => TextButton(
                    onPressed: onToggleAll,
                    child: Text(
                      open.isNotEmpty ? 'Collapse All' : 'Expand All',
                      style: AppTextStyles.s14w600.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          sliver: SliverList.separated(
            itemCount: sections.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.listItemGap),
            itemBuilder: (_, i) => ValueListenableBuilder<Set<int>>(
              valueListenable: expanded,
              builder: (_, open, __) => _SectionCard(
                index: i,
                section: sections[i],
                isOpen: open.contains(i),
                onTap: () => onToggle(i),
                onLessonTap: onLessonTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.index,
    required this.section,
    required this.isOpen,
    required this.onTap,
    required this.onLessonTap,
  });

  final int index;
  final CourseSection section;
  final bool isOpen;
  final VoidCallback onTap;
  final ValueChanged<CourseLesson>? onLessonTap;

  static const _d = Duration(milliseconds: 260);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _d,
      curve: Curves.easeOutCubic,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: isOpen
              ? AppColors.primary.withValues(alpha: .35)
              : AppColors.borderBrand,
        ),
        boxShadow: isOpen
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: .08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Row(
                children: [
                  Container(
                    width: AppSpacing.huge,
                    height: AppSpacing.huge,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Text(
                      '${index + 1}'.padLeft(2, '0'),
                      style: AppTextStyles.s14w600.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: AppTextStyles.s14w600.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${section.lessons.length} Videos • ${section.minutes} Mins',
                          style: AppTextStyles.s12w400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? .5 : 0,
                    duration: _d,
                    curve: Curves.easeOutCubic,
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.iconGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: _d,
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: isOpen
                ? ColoredBox(
                    color: AppColors.ligthPrimary,
                    child: Column(
                      children: [
                        for (var i = 0; i < section.lessons.length; i++) ...[
                          if (i > 0)
                            const Divider(
                              height: 1,
                              indent: AppSpacing.lg,
                              endIndent: AppSpacing.lg,
                              color: AppColors.borderBrand,
                            ),
                          _LessonTile(
                            number: i + 1,
                            lesson: section.lessons[i],
                            onTap: onLessonTap == null
                                ? null
                                : () => onLessonTap!(section.lessons[i]),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({
    required this.number,
    required this.lesson,
    required this.onTap,
  });

  final int number;
  final CourseLesson lesson;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final free = lesson.isFreePreview;

    return InkWell(
      onTap: free ? onTap : null,
      child: Padding(
        padding: AppSpacing.listItemPadding,
        child: Row(
          children: [
            Container(
              width: AppSpacing.xxxl,
              height: AppSpacing.xxxl,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: free ? AppColors.primary : AppColors.iconCircle,
              ),
              child: Icon(
                free ? Icons.play_arrow_rounded : Icons.lock_rounded,
                size: free ? AppSpacing.iconMd : AppSpacing.iconSm,
                color: free ? AppColors.iconWhite : AppColors.lightGrey,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'$number'.padLeft(2, '0')}. ${lesson.title}',
                    style:
                        (free ? AppTextStyles.s14w600 : AppTextStyles.s14w500)
                            .copyWith(
                              color: free
                                  ? AppColors.primary
                                  : AppColors.textBlack,
                            ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    free
                        ? '${lesson.minutes} Mins • Free Preview'
                        : '${lesson.minutes} Mins',
                    style: AppTextStyles.s12w400.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (free)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs + 1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  'PREVIEW',
                  style: AppTextStyles.s12w400.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .8,
                    color: AppColors.primary,
                  ),
                ),
              )
            else
              Text(
                'Locked',
                style: AppTextStyles.s12w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EnrollBar extends StatelessWidget {
  const _EnrollBar({
    required this.price,
    required this.currency,
    required this.onEnroll,
  });

  final int price;
  final String currency;
  final VoidCallback onEnroll;

  @override
  Widget build(BuildContext context) {
    final grouped = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhiteWidget,
        border: Border(top: BorderSide(color: AppColors.borderBrand)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL PRICE',
                    style: AppTextStyles.s12w400.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: grouped,
                          style: AppTextStyles.s20w600.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textBlack,
                          ),
                        ),
                        TextSpan(
                          text: ' $currency',
                          style: AppTextStyles.s12w400.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: .35),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    onPressed: onEnroll,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      foregroundColor: AppColors.textWhite,
                      minimumSize: const Size.fromHeight(AppSpacing.giant),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLg,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Get Your Enrollment Code !',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.s16w600.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: AppSpacing.iconMd,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
