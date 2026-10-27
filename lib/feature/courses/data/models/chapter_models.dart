class ChapterInfo {
  final String statusText; // IN PROGRESS • 10:00 EST
  final String courseTitle;
  final String moduleLabel; // Current Module
  final double progress; // 0..1
  final String title;
  final String description;
  final int videosCount;
  final int totalMinutes;
  final int quizzesCount;

  const ChapterInfo({
    required this.statusText,
    required this.courseTitle,
    this.moduleLabel = 'Current Module',
    required this.progress,
    required this.title,
    required this.description,
    required this.videosCount,
    required this.totalMinutes,
    required this.quizzesCount,
  });
}

class ChapterQuiz {
  final String title;
  final bool isRequired;
  final int questions;
  final int points;
  final int minutes;

  const ChapterQuiz({
    required this.title,
    this.isRequired = true,
    required this.questions,
    required this.points,
    required this.minutes,
  });
}

class VideoLesson {
  final String id;
  final int part;
  final String title;
  final String thumbnailUrl;
  final int minutes;
  final String durationLabel; // 10:00
  final int? watchedPercent; // null = لم يبدأ
  final bool isCurrent;

  const VideoLesson({
    required this.id,
    required this.part,
    required this.title,
    required this.thumbnailUrl,
    required this.minutes,
    this.durationLabel = '',
    this.watchedPercent,
    this.isCurrent = false,
  });
}

class LessonFile {
  final String id;
  final String name;
  final String size;

  const LessonFile({required this.id, required this.name, required this.size});
}
