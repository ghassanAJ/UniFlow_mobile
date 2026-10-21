import 'package:flutter/material.dart';
import 'package:uniflow/core/color/app_colors.dart';


/// صورة من الشبكة مع placeholder عند الفشل.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.radius = 12,
  });

  final String url;
  final double? width, height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: AppColors.primarySoft,
          child: const Icon(Icons.image_outlined, color: AppColors.primary),
        ),
      ),
    );
  }
}
