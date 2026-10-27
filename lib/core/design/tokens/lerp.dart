import 'package:flutter/material.dart';

double dsLerp(double a, double b, double t) => a + (b - a) * t;

Color? dsLerpColor(Color? a, Color? b, double t) {
  if (a == null && b == null) return null;
  if (a == null) return t < 0.5 ? null : b;
  if (b == null) return t < 0.5 ? a : null;
  return Color.lerp(a, b, t);
}

Gradient? dsLerpGradient(Gradient? a, Gradient? b, double t) {
  if (a == null && b == null) return null;
  return t < 0.5 ? a : b;
}
