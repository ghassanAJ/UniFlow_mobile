class TeacherCourse {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  final String? tag;
  final String institute;
  final String department;
  final String instructor;
  final int instructorCourses;
  final int lectures;
  final num tuitionFee;
  final String currency;

  const TeacherCourse({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    this.tag,
    required this.institute,
    required this.department,
    required this.instructor,
    required this.instructorCourses,
    required this.lectures,
    required this.tuitionFee,
    this.currency = 'S.P',
  });
}
