// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

enum AvatarSize { xs, sm, md, lg, xl }

enum AvatarShape { circle, rounded }

enum AvatarStatus { online, busy, away, offline }

@immutable
class AvatarTokens extends ThemeExtension<AvatarTokens> {
  const AvatarTokens({
    this.xs = 24,
    this.sm = 32,
    this.md = 40,
    this.lg = 56,
    this.xl = 80,
    this.radius = 12,
    this.backgroundColor = const Color(0xFFE8EAF0),
    this.foregroundColor = const Color(0xFF303544),
    this.borderColor = const Color(0xFFFFFFFF),
    this.onlineColor = const Color(0xFF22C55E),
    this.busyColor = const Color(0xFFEF4444),
    this.awayColor = const Color(0xFFF59E0B),
    this.offlineColor = const Color(0xFF9CA3AF),
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double radius;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  final Color onlineColor;
  final Color busyColor;
  final Color awayColor;
  final Color offlineColor;

  double sizeOf(AvatarSize size) => switch (size) {
    AvatarSize.xs => xs,
    AvatarSize.sm => sm,
    AvatarSize.md => md,
    AvatarSize.lg => lg,
    AvatarSize.xl => xl,
  };

  Color statusColor(AvatarStatus status) => switch (status) {
    AvatarStatus.online => onlineColor,
    AvatarStatus.busy => busyColor,
    AvatarStatus.away => awayColor,
    AvatarStatus.offline => offlineColor,
  };

  @override
  AvatarTokens copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? radius,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    Color? onlineColor,
    Color? busyColor,
    Color? awayColor,
    Color? offlineColor,
  }) {
    return AvatarTokens(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      radius: radius ?? this.radius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      onlineColor: onlineColor ?? this.onlineColor,
      busyColor: busyColor ?? this.busyColor,
      awayColor: awayColor ?? this.awayColor,
      offlineColor: offlineColor ?? this.offlineColor,
    );
  }

  @override
  AvatarTokens lerp(covariant AvatarTokens? other, double t) {
    if (other == null) return this;

    return AvatarTokens(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      radius: _lerp(radius, other.radius, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      onlineColor: Color.lerp(onlineColor, other.onlineColor, t)!,
      busyColor: Color.lerp(busyColor, other.busyColor, t)!,
      awayColor: Color.lerp(awayColor, other.awayColor, t)!,
      offlineColor: Color.lerp(offlineColor, other.offlineColor, t)!,
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}

class DsAvatar extends StatelessWidget {
  const DsAvatar({
    Key? key,
    this.size = AvatarSize.md,
    this.customSize,
    this.shape = AvatarShape.circle,
    this.imageUrl,
    this.imageProvider,
    this.assetPath,
    this.initials,
    this.child,
    this.status,
    this.showBorder = false,
    this.borderWidth = 2,
    this.semanticLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  // : assert(
  //           [imageUrl, imageProvider, assetPath]
  //                   .where((value) => value != null)
  //                   .length <=
  //               1,
  //           'Provide only one image source.',
  //         );

  final AvatarSize size;
  final double? customSize;
  final AvatarShape shape;

  final String? imageUrl;
  final ImageProvider? imageProvider;
  final String? assetPath;

  final String? initials;
  final Widget? child;
  final AvatarStatus? status;

  final bool showBorder;
  final double borderWidth;
  final String? semanticLabel;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = theme.extension<AvatarTokens>() ?? const AvatarTokens();

    final dimension = customSize ?? tokens.sizeOf(size);
    final isCircle = shape == AvatarShape.circle;

    final radius = isCircle
        ? dimension / 2
        : tokens.radius.clamp(0.0, dimension / 2);

    final bg = backgroundColor ?? tokens.backgroundColor;
    final fg = foregroundColor ?? tokens.foregroundColor;

    final content = _buildContent(context, dimension, bg, fg, tokens);

    final avatar = SizedBox.square(
      dimension: dimension,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isCircle ? null : BorderRadius.circular(radius),
                border: showBorder
                    ? Border.all(color: tokens.borderColor, width: borderWidth)
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: content,
              ),
            ),
          ),
          if (status != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: dimension * 0.28,
                height: dimension * 0.28,
                decoration: BoxDecoration(
                  color: tokens.statusColor(status!),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: dimension * 0.04,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return Semantics(
      label: semanticLabel,
      image: true,
      child: onTap == null
          ? avatar
          : GestureDetector(onTap: onTap, child: avatar),
    );
  }

  Widget _buildContent(
    BuildContext context,
    double dimension,
    Color background,
    Color foreground,
    AvatarTokens tokens,
  ) {
    Widget fallback() {
      if (child != null) return child!;

      final text = initials?.trim();

      if (text != null && text.isNotEmpty) {
        return Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              maxLines: 1,
              style: TextStyle(
                color: foreground,
                fontSize: dimension * 0.36,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
      return Container();
      // return Icon(
      //   Icons.person_rounded,
      //   size: dimension * 0.58,
      //   color: foreground,
      // );
    }

    Widget image;

    if (imageProvider != null) {
      image = Image(
        image: imageProvider!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback(),
      );
    } else if (assetPath != null) {
      image = Image.asset(
        assetPath!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback(),
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      image = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback(),
      );
    } else {
      return fallback();
    }

    return SizedBox.expand(child: image);
  }
}
