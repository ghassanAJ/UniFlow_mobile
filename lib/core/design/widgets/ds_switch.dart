import 'package:flutter/material.dart';
import 'package:uniflow/core/design/ds_theme.dart';

/// On/off toggle using the primary color for the active track.
class DsSwitch extends StatelessWidget {
  const DsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: colors.onPrimary,
      activeTrackColor: activeColor ?? colors.primary,
      inactiveThumbColor: colors.surface,
      inactiveTrackColor: inactiveColor ?? colors.surfaceMuted,
      trackOutlineColor: WidgetStatePropertyAll(colors.border),
    );
  }
}
