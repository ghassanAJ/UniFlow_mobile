import 'package:flutter/material.dart';
import 'package:uniflow/core/design/ds_theme.dart';

/// Thin separator line. Horizontal by default; set [vertical] inside a Row.
class DsDivider extends StatelessWidget {
  const DsDivider({
    super.key,
    this.vertical = false,
    this.length,
    this.thickness = 1,
    this.color,
  });

  final bool vertical;
  final double? length;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: vertical ? thickness : length,
      height: vertical ? length : thickness,
      color: color ?? context.ds.colors.border,
    );
  }
}
