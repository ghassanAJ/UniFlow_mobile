class ProfileData {
  final String fullName;
  final String email;
  final String university;
  final String college;
  final String yearLabel;
  final String badge;
  final String? avatarUrl;
  final String semester;
  final int overallPercent;
  final String grade;
  final String standingNote;
  final int quizzesPassed;
  final int quizzesTotal;
  final int quizzesAvgPercent;
  final int videosWatched;
  final int videosTotal;
  final int streakDays;
  final double studyHours;
  final int savedCourses;
  final String downloadsSize;

  const ProfileData({
    required this.fullName,
    required this.email,
    required this.university,
    required this.college,
    required this.yearLabel,
    required this.badge,
    this.avatarUrl,
    required this.semester,
    required this.overallPercent,
    required this.grade,
    required this.standingNote,
    required this.quizzesPassed,
    required this.quizzesTotal,
    required this.quizzesAvgPercent,
    required this.videosWatched,
    required this.videosTotal,
    required this.streakDays,
    required this.studyHours,
    required this.savedCourses,
    required this.downloadsSize,
  });

  double get quizzesRatio =>
      quizzesTotal == 0 ? 0 : quizzesPassed / quizzesTotal;

  double get videosRatio => videosTotal == 0 ? 0 : videosWatched / videosTotal;

  String get initials => fullName
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}

const demoProfile = ProfileData(
  fullName: 'User Full Name',
  email: 'student.id@university.edu',
  university: 'University Name',
  college: 'College Name',
  yearLabel: 'Year: 3rd',
  badge: "Dean's List",
  semester: 'Fall Semester',
  overallPercent: 92,
  grade: 'Grade A+',
  standingNote: 'Top 5% of Department cohort',
  quizzesPassed: 18,
  quizzesTotal: 20,
  quizzesAvgPercent: 90,
  videosWatched: 84,
  videosTotal: 102,
  streakDays: 14,
  studyHours: 46.5,
  savedCourses: 12,
  downloadsSize: '2.4 GB',
);
