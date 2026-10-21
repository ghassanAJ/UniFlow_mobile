import 'package:flutter/material.dart';

class ActiveCourse {
  final String title, college, instructor, imageUrl;
  final int watchedVideos, totalVideos;

  const ActiveCourse({
    required this.title,
    required this.college,
    required this.instructor,
    required this.imageUrl,
    required this.watchedVideos,
    required this.totalVideos,
  });

  double get progress => watchedVideos / totalVideos;
}

class Course {
  final String title, category, faculty, imageUrl, price;
  final double rating;

  const Course({
    required this.title,
    required this.category,
    required this.faculty,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}

class Teacher {
  final String name, imageUrl;
  final int coursesCount;

  const Teacher({
    required this.name,
    required this.imageUrl,
    required this.coursesCount,
  });
}

class CategoryItem {
  final String label;
  final IconData icon;

  const CategoryItem({required this.label, required this.icon});
}

class Announcement {
  final String tag, duration, date, title, description, imageUrl;

  const Announcement({
    required this.tag,
    required this.duration,
    required this.date,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
