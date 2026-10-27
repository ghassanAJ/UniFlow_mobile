import 'package:flutter/material.dart';
import 'package:uniflow/core/design/widgets/ds_chip.dart';

/// Small status pill. A sized [DsChip] with the same overrides.
class DsBadge extends StatelessWidget {
  const DsBadge({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
  });

  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return DsChip(
      label: label,
      icon: icon,
      size: DsChipSize.sm,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconColor: iconColor,
    );
  }
}
