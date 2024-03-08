import 'package:usos/data/models/course.dart';

class Grade {
  final Course course;
  final double? grade;
  final int? ectsPoints;

  Grade({
    required this.course,
    required this.grade,
    required this.ectsPoints,
  });

  String get gradeString => grade != null ? grade.toString() : '?';

  String get ectsString => ectsPoints != null ? ectsPoints.toString() : '?';

  factory Grade.fromJson(Course course, Map<String, dynamic>? jsonGrade, String? ectsPoints) {
    return Grade(
        course: course,
        ectsPoints: ectsPoints != null ? double.tryParse(ectsPoints.replaceAll(',', '.'))?.toInt() : null,
        grade: jsonGrade == null
            ? null
            : jsonGrade['course_grades'].last.values.first != null
                ? double.tryParse(jsonGrade['course_grades'].last.values.first['value_symbol'].replaceAll(',', '.'))
                : null);
  }

  @override
  String toString() {
    return 'Grade{id: ${course.courseId}, name: ${course.courseName}, grade: $grade, ectsPoints: $ectsPoints}';
  }

  Map<String, dynamic> toJson() {
    return {
      'course': course,
      'grade': grade,
      'ectsPoints': ectsPoints,
    };
  }
}
