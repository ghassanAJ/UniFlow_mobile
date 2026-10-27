import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uniflow/core/color/app_colors.dart';
import 'package:uniflow/feature/courses/data/models/chapter_models.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/chapter_app_bar.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/chapter_hero_card.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/chapter_quiz_card.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/chapter_status_row.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/current_lesson_card.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/glass_tab_switcher.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/lesson_file_tile.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/lesson_tile.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/lessons_header.dart';
import 'package:uniflow/feature/courses/presentation/widget/chapter/up_next_card.dart';

/// الشاشة: تجمع الـ widgets وتبدّل المحتوى حسب التاب.
class ChapterOverviewScreen extends StatelessWidget {
  const ChapterOverviewScreen({super.key, this.bottomSpace = 24});

  final double bottomSpace;

  static const _info = ChapterInfo(
    statusText: 'In Progress • 10:00 EST',
    courseTitle: 'Course’s Title',
    progress: .65,
    title: '01 Chapter - Chapter’s Title',
    description:
        'Master the core foundational concepts and hands-on '
        'exercises in this structured unit.',
    videosCount: 4,
    totalMinutes: 126,
    quizzesCount: 1,
  );

  static const _quiz = ChapterQuiz(
    title: 'Chapter Quiz',
    questions: 5,
    points: 10,
    minutes: 15,
  );

  static const _lessons = <VideoLesson>[
    VideoLesson(
      id: '1',
      part: 1,
      title: 'Video’s Title',
      thumbnailUrl: 'https://picsum.photos/seed/lesson1/400/300',
      minutes: 52,
      durationLabel: '10:00',
      watchedPercent: 80,
      isCurrent: true,
    ),
    VideoLesson(
      id: '2',
      part: 2,
      title: 'Video’s Title',
      thumbnailUrl: 'https://picsum.photos/seed/lesson2/400/300',
      minutes: 52,
    ),
    VideoLesson(
      id: '3',
      part: 3,
      title: 'Video’s Title',
      thumbnailUrl: 'https://picsum.photos/seed/lesson3/400/300',
      minutes: 52,
    ),
    VideoLesson(
      id: '4',
      part: 4,
      title: 'Video’s Title',
      thumbnailUrl: 'https://picsum.photos/seed/lesson4/400/300',
      minutes: 52,
    ),
  ];

  static const _files = <LessonFile>[
    LessonFile(id: 'f1', name: 'Chapter Slides.pdf', size: '2.4 MB'),
    LessonFile(id: 'f2', name: 'Exercises Sheet.pdf', size: '1.1 MB'),
    LessonFile(id: 'f3', name: 'Reading Notes.pdf', size: '860 KB'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: ChapterAppBar(onMore: () {}, onProfile: () {}),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Column(
                  children: [
                    ChapterStatusRow(
                      statusText: _info.statusText,
                      courseTitle: _info.courseTitle,
                    ),
                    SizedBox(height: 12.h),
                    const ChapterHeroCard(info: _info),
                    SizedBox(height: 16.h),
                    ChapterQuizCard(quiz: _quiz, onStart: () {}),
                    SizedBox(height: 18.h),
                    GlassTabSwitcher(
                      items: [
                        GlassTabItem(
                          'Videos',
                          Icons.play_circle_outline_rounded,
                          count: _lessons.length,
                        ),
                        GlassTabItem(
                          'Files',
                          Icons.insert_drive_file_outlined,
                          count: _files.length,
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                  ],
                ),
              ),
            ),
            const _TabContent(lessons: _lessons, files: _files),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, bottomSpace.h),
                child: UpNextCard(
                  title: 'Up Next: Chapter 02',
                  subtitle: 'Complete remaining quiz to unlock.',
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.lessons, required this.files});

  final List<VideoLesson> lessons;
  final List<LessonFile> files;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final isVideos = controller.index == 0;
        final count = isVideos ? lessons.length : files.length;

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
                child: LessonsHeader(
                  title: isVideos ? 'Chapter Video Lessons' : 'Chapter Files',
                  trailing: 'All available',
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  final Widget item;
                  if (isVideos) {
                    final l = lessons[i];
                    item = l.isCurrent
                        ? CurrentLessonCard(lesson: l, onPlay: () {})
                        : LessonTile(lesson: l, onPlay: () {});
                  } else {
                    item = LessonFileTile(file: files[i], onTap: () {});
                  }
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: item,
                  );
                }, childCount: count),
              ),
            ),
          ],
        );
      },
    );
  }
}
