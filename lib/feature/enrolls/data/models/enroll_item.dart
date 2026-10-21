import 'package:flutter/material.dart';

enum EnrollStatus { active, completed, suspended }

class EnrollItem {
  final String id;
  final String title;
  final String category;
  final EnrollStatus status;
  final int watchedVideos;
  final int totalVideos;
  final IconData icon;
  final Color iconColor;
  final Color tileColor;

  const EnrollItem({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.watchedVideos,
    required this.totalVideos,
    required this.icon,
    required this.iconColor,
    required this.tileColor,
  });

  double get progress => totalVideos == 0 ? 0 : watchedVideos / totalVideos;
  int get percent => (progress * 100).round();
}
