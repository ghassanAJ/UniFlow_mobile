class Course {
  final String id;
  final String title;
  final String university;
  final String imageUrl;
  final String enrolledLabel; // e.g. "1.4k Enrolled"
  final String department; // e.g. "Architecture Dept"
  final String term; // e.g. "Fall 2024"
  final double rating;
  final num tuitionFee;
  final String currency;

  const Course({
    required this.id,
    required this.title,
    required this.university,
    required this.imageUrl,
    required this.enrolledLabel,
    required this.department,
    required this.term,
    required this.rating,
    required this.tuitionFee,
    this.currency = 'S.P',
  });
}
