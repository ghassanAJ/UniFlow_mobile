import 'package:flutter/material.dart';
import 'package:uniflow/feature/home/data/model/models.dart';

class MockData {
  MockData._();

  static const activeCourse = ActiveCourse(
    title: 'Advanced Structural Analysis & Modeling',
    college: 'College of Civil Engineering',
    instructor: 'Dr. Tariq',
    imageUrl: 'https://picsum.photos/seed/structure/200/200',
    watchedVideos: 10,
    totalVideos: 40,
  );

  static const categories = [
    CategoryItem(label: 'Architecture', icon: Icons.architecture),
    CategoryItem(label: 'Civil Engineering', icon: Icons.foundation),
    CategoryItem(label: 'Electrical', icon: Icons.bolt),
    CategoryItem(label: 'Information Tech', icon: Icons.computer),
    CategoryItem(label: 'Dentistry', icon: Icons.medical_services_outlined),
  ];

  static const courses = [
    Course(
      title: 'Modern Parametric Studio & BIM Theory',
      category: 'ARCHITECTURE',
      faculty: 'Faculty of Fine Arts',
      imageUrl: 'https://picsum.photos/seed/flutter/400/300',
      price: '1,800,000 S.P',
      rating: 4.9,
    ),
    Course(
      title: 'Clinical Endodontics & Dental Anatomy',
      category: 'DENTISTRY',
      faculty: 'University Medical Center',
      imageUrl: 'https://picsum.photos/seed/laptop/400/300',
      price: '2,400,000 S.P',
      rating: 4.8,
    ),
    Course(
      title: 'Clinical Endodontics & Dental Anatomy',
      category: 'DENTISTRY',
      faculty: 'University Medical Center',
      imageUrl: 'https://picsum.photos/seed/beach/400/300',
      price: '2,400,000 S.P',
      rating: 4.8,
    ),
    Course(
      title: 'Clinical Endodontics & Dental Anatomy',
      category: 'DENTISTRY',
      faculty: 'University Medical Center',
      imageUrl: 'https://picsum.photos/seed/car/400/300',
      price: '2,400,000 S.P',
      rating: 4.8,
    ),
  ];

  static const teachers = [
    Teacher(
      name: 'Dr. Nizar',
      coursesCount: 4,
      imageUrl: 'https://i.pravatar.cc/150?img=12',
    ),
    Teacher(
      name: 'Eng. Samer',
      coursesCount: 6,
      imageUrl: 'https://i.pravatar.cc/150?img=33',
    ),
    Teacher(
      name: 'Dr. Rania',
      coursesCount: 5,
      imageUrl: 'https://i.pravatar.cc/150?img=47',
    ),
    Teacher(
      name: 'Dr. Ziad',
      coursesCount: 3,
      imageUrl: 'https://i.pravatar.cc/150?img=15',
    ),
 
  ];

  static const announcement = Announcement(
    tag: 'Academic',
    duration: '4 Mins',
    date: '15 Oct, 2025',
    title: 'Mid-Term Examination Hall Allocations Published',
    description: 'Students can now check designated examination halls.',
    imageUrl: 'https://picsum.photos/seed/exam/200/200',
  );
}
