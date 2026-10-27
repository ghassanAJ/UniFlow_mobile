class TeacherProfile {
  final String name;
  final String title;
  final String college;
  final String bio;
  final String avatarUrl;
  final int coursesCount;
  final int studentsCount;
  final double rating;
  final int reviewsCount;
  final bool isVerified;

  const TeacherProfile({
    required this.name,
    required this.title,
    required this.college,
    required this.bio,
    required this.avatarUrl,
    required this.coursesCount,
    required this.studentsCount,
    required this.rating,
    required this.reviewsCount,
    this.isVerified = true,
  });
}
