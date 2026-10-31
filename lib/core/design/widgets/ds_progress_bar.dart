import 'package:flutter/material.dart';
import 'package:uniflow/core/design/app_spacing.dart';
import 'package:uniflow/core/design/ds_theme.dart';

/// Rounded linear progress. [value] is clamped to 0..1.
class DsProgressBar extends StatelessWidget {
  const DsProgressBar({
    super.key,
    required this.value,
    this.color,
    this.trackColor,
    this.height = 6,
    this.radius = AppSpacing.radiusXs,
  });

  final double value;
  final Color? color;
  final Color? trackColor;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.ds.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: trackColor ?? colors.primarySoft,
        valueColor: AlwaysStoppedAnimation(color ?? colors.primary),
      ),
    );
  }
}
