import 'package:flutter/material.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/design/ds_theme.dart';
import 'package:uniflow/core/design/tokens/typography_tokens.dart';
import 'package:uniflow/core/design/widgets/ds_text.dart';

/// Title row with an optional subtitle and a trailing widget or action.
class DsSectionHeader extends StatelessWidget {
  const DsSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.titleRole = DsTextRole.titleSmall,
    this.subtitleRole = DsTextRole.caption,
    this.titleColor,
    this.subtitleColor,
    this.actionColor,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;
  final DsTextRole titleRole;
  final DsTextRole subtitleRole;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? actionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DsText(title, role: titleRole, color: titleColor),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                DsText(subtitle!, role: subtitleRole, color: subtitleColor),
              ],
            ],
          ),
        ),
        if (trailing != null)
          trailing!
        else if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: DsText(
              actionLabel!,
              role: DsTextRole.label,
              color: actionColor ?? context.ds.colors.primary,
            ),
          ),
      ],
    );
  }
}
