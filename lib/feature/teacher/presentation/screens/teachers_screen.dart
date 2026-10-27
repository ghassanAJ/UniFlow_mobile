import 'package:flutter/material.dart';
import 'package:uniflow/core/design/design_system.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: DsSearchField(
              hint: 'Search teacher, subject, mentor...',
              trailing: DsIconButton(icon: Icons.tune_rounded),
            ),
          ),
          DsChoiceBar(
            options: ['All', 'Design', 'Develpoment', 'Business'],
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: DsSectionHeader(
              title: 'Faculty & Mentors',
              subtitle: 'Learn from vetted university teachers',
              trailing: DsBadge(label: '6 Available'),
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Expanded(child: _TeacherList()),
        ],
      ),
    );
  }
}

class _TeacherList extends StatelessWidget {
  const _TeacherList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        0,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),
      itemCount: 2,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.lg),
      itemBuilder: (context, index) => const _TeacherCard(),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  const _TeacherCard();

  @override
  Widget build(BuildContext context) {
    return const DsCard(
      variant: DsCardVariant.filled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DsAvatar(size: AvatarSize.lg),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DsText('Dr. Harry Holland', role: DsTextRole.titleSmall),
                    SizedBox(height: AppSpacing.xxs),
                    DsText(
                      'Senior Product Design Lead & Mentor',
                      role: DsTextRole.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            children: [
              DsChip(label: '4 Course', icon: Icons.book_rounded),
              DsChip(
                label: '1,276 students',
                icon: Icons.person_pin_circle_rounded,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          DsText(
            'Dedicated mentor with over 9 years in human-centered design and UI systems helping students…',
            role: DsTextRole.caption,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
