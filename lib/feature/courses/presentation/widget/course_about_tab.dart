import 'package:flutter/material.dart';
import 'package:uniflow/core/design/design_system.dart';

/// Reusable About tab built with the design system and sliver builders.
class CourseAboutTab extends StatelessWidget {
  const CourseAboutTab({
    super.key,
    required this.description,
    this.outcomes = const [],
    this.requirements = const [],
    this.includes = const [],
    this.level,
    this.language,
    this.lastUpdated,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.xxl,
    ),
  });

  final String description;
  final List<String> outcomes;
  final List<String> requirements;
  final List<CourseAboutInclude> includes;
  final String? level;
  final String? language;
  final String? lastUpdated;
  final EdgeInsetsGeometry padding;

  List<_AboutEntry> get _entries {
    final entries = <_AboutEntry>[
      const _AboutEntry.header('About this course'),
      _AboutEntry.description(description),
    ];

    if (_hasMeta) {
      entries.add(
        _AboutEntry.meta(
          level: level,
          language: language,
          lastUpdated: lastUpdated,
        ),
      );
    }

    if (outcomes.isNotEmpty) {
      entries.add(const _AboutEntry.header('What you will learn'));
      for (final outcome in outcomes) {
        entries.add(_AboutEntry.outcome(outcome));
      }
    }

    if (requirements.isNotEmpty) {
      entries.add(const _AboutEntry.header('Requirements'));
      for (final requirement in requirements) {
        entries.add(_AboutEntry.requirement(requirement));
      }
    }

    if (includes.isNotEmpty) {
      entries.add(const _AboutEntry.header('This course includes'));
      entries.add(_AboutEntry.includes(includes));
    }

    return entries;
  }

  bool get _hasMeta =>
      (level != null && level!.isNotEmpty) ||
      (language != null && language!.isNotEmpty) ||
      (lastUpdated != null && lastUpdated!.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final entries = _entries;

    return CustomScrollView(
      key: const PageStorageKey('course-about'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: padding,
          sliver: SliverList.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              final bottom = index == entries.length - 1
                  ? 0.0
                  : switch (entry.kind) {
                      _AboutKind.header => AppSpacing.sm,
                      _AboutKind.description => AppSpacing.xl,
                      _AboutKind.meta => AppSpacing.xxl,
                      _AboutKind.outcome ||
                      _AboutKind.requirement => AppSpacing.sm,
                      _AboutKind.includes => 0.0,
                    };

              return Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: switch (entry.kind) {
                  _AboutKind.header => DsSectionHeader(
                    title: entry.text!,
                    titleRole: DsTextRole.titleSmall,
                  ),
                  _AboutKind.description => DsText(
                    entry.text!,
                    role: DsTextRole.body,
                  ),
                  _AboutKind.meta => _MetaCard(
                    level: entry.level,
                    language: entry.language,
                    lastUpdated: entry.lastUpdated,
                  ),
                  _AboutKind.outcome => _BulletRow(
                    icon: Icons.check_circle_rounded,
                    text: entry.text!,
                    emphasize: true,
                  ),
                  _AboutKind.requirement => _BulletRow(
                    icon: Icons.circle,
                    text: entry.text!,
                    iconSize: 8,
                  ),
                  _AboutKind.includes => Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      for (final item in entry.includes!)
                        DsChip(
                          label: item.label,
                          icon: item.icon,
                          size: DsChipSize.md,
                        ),
                    ],
                  ),
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CourseAboutInclude {
  const CourseAboutInclude({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

enum _AboutKind { header, description, meta, outcome, requirement, includes }

class _AboutEntry {
  const _AboutEntry._({
    required this.kind,
    this.text,
    this.level,
    this.language,
    this.lastUpdated,
    this.includes,
  });

  const _AboutEntry.header(String title)
    : this._(kind: _AboutKind.header, text: title);

  const _AboutEntry.description(String value)
    : this._(kind: _AboutKind.description, text: value);

  const _AboutEntry.meta({String? level, String? language, String? lastUpdated})
    : this._(
        kind: _AboutKind.meta,
        level: level,
        language: language,
        lastUpdated: lastUpdated,
      );

  const _AboutEntry.outcome(String value)
    : this._(kind: _AboutKind.outcome, text: value);

  const _AboutEntry.requirement(String value)
    : this._(kind: _AboutKind.requirement, text: value);

  const _AboutEntry.includes(List<CourseAboutInclude> value)
    : this._(kind: _AboutKind.includes, includes: value);

  final _AboutKind kind;
  final String? text;
  final String? level;
  final String? language;
  final String? lastUpdated;
  final List<CourseAboutInclude>? includes;
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({
    required this.icon,
    required this.text,
    this.emphasize = false,
    this.iconSize = 18,
  });

  final IconData icon;
  final String text;
  final bool emphasize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            icon,
            size: iconSize,
            color: emphasize ? colors.primary : colors.textSecondary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: DsText(
            text,
            role: DsTextRole.body,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({this.level, this.language, this.lastUpdated});

  final String? level;
  final String? language;
  final String? lastUpdated;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return DsCard(
      variant: DsCardVariant.filled,
      color: colors.primarySoft,
      child: Wrap(
        spacing: AppSpacing.xl,
        runSpacing: AppSpacing.md,
        children: [
          if (level != null && level!.isNotEmpty)
            _MetaItem(icon: Icons.signal_cellular_alt_rounded, label: level!),
          if (language != null && language!.isNotEmpty)
            _MetaItem(icon: Icons.language_rounded, label: language!),
          if (lastUpdated != null && lastUpdated!.isNotEmpty)
            _MetaItem(icon: Icons.update_rounded, label: lastUpdated!),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSpacing.iconSm, color: colors.primary),
        const SizedBox(width: AppSpacing.xs),
        DsText(label, role: DsTextRole.label, color: colors.textPrimary),
      ],
    );
  }
}
