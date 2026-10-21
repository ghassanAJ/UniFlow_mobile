import 'package:flutter/material.dart';

/// زر أيقونة مربّع مع نقطة تنبيه اختيارية.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.showDot = false,
    this.color = Colors.white,
    this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool showDot;
  final Color color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            if (showDot)
              Positioned(
                top: 9,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
