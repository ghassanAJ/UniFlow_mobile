import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
int liquidGlassAlpha(double opacity) =>
    (opacity.clamp(0.0, 1.0) * 255).round();

/// حاوية بتأثير Liquid Glass: blur للخلفية + تدرّج أبيض شفاف + حد لامع.
///
/// - على خلفية ملوّنة/صور يظهر التأثير بوضوح (blur حقيقي).
/// - للتحكم بالشكل: [tint] و[tintOpacity] و[blur] و[borderOpacity].
/// - للدائرة: مرّر borderRadius كبير (مثلاً 999) مع عرض = ارتفاع.
class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.blur = 20,
    this.tint = Colors.white,
    this.tintOpacity = .22,
    this.borderOpacity = .55,
    this.padding,
    this.shadow = false,
    this.onTap,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final Color tint;
  final double tintOpacity;
  final double borderOpacity;
  final EdgeInsetsGeometry? padding;
  final bool shadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius.r);

    Widget glass = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            // تدرّج: أفتح بالزاوية العلوية لإحساس "اللمعان"
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                tint.withAlpha(liquidGlassAlpha(tintOpacity + .14)),
                tint.withAlpha(liquidGlassAlpha(tintOpacity * .6)),
              ],
            ),
            border: Border.all(
              color: Colors.white.withAlpha(liquidGlassAlpha(borderOpacity)),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );

    if (shadow) {
      glass = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(28),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: glass,
      );
    }

    if (onTap != null) {
      glass = GestureDetector(onTap: onTap, child: glass);
    }
    return glass;
  }
}
