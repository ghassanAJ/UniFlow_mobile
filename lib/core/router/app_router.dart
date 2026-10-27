import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uniflow/core/router/app_routes.dart';
import 'package:uniflow/feature/Auth/presentation/screens/create_account_screen.dart';
import 'package:uniflow/feature/Auth/presentation/screens/sign_up_page.dart';
import 'package:uniflow/feature/courses/presentation/screens/chapter_details.dart';
import 'package:uniflow/feature/courses/presentation/screens/course_datails.dart';
import 'package:uniflow/feature/courses/presentation/screens/courses_screen.dart';
import 'package:uniflow/feature/courses/presentation/screens/quiz_screen.dart';
import 'package:uniflow/feature/home/presentation/screen/main_screen.dart';
import 'package:uniflow/feature/teacher/presentation/screens/teacher_details.dart';
import 'package:uniflow/feature/teacher/presentation/screens/teachers_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.chapterDetails,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.createAccount,
      name: 'create-account',
      builder: (context, state) => const CreateAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.courses,
      name: 'courses',
      builder: (context, state) => const CoursesScreen(),
    ),
    GoRoute(
      path: AppRoutes.courseDetails,
      name: 'course-details',
      builder: (context, state) => const CourseDatailScreen(),
    ),
    GoRoute(
      path: AppRoutes.teachers,
      name: 'teachers',
      builder: (context, state) => const TeachersScreen(),
    ),
    GoRoute(
      path: AppRoutes.teacherDetails,
      name: 'teacher-details',
      builder: (context, state) => const TeacherProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.quiz,
      name: 'quiz',
      builder: (context, state) => const QuizScreen(),
    ),
    GoRoute(
      path: AppRoutes.chapterDetails,
      name: 'chapter-details',
      builder: (context, state) => const ChapterOverviewScreen(),
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
);
