import 'dart:io';

class Course {
  final String courseId;
  final String courseName;

  Course({
    required this.courseId,
    required this.courseName,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    final String defaultLocale = Platform.localeName.substring(0, 2);
    late final String name;
    if (json['course_name'][defaultLocale] != null && json['course_name'][defaultLocale] != "") {
      name = json['course_name'][defaultLocale];
    } else if (json['course_name']['en'] != null && json['course_name']['en'] != "") {
      name = json['course_name']['en'];
    } else {
      name = json['course_name'][json['course_name'].keys.first];
    }
    return Course(
      courseId: json['course_id'],
      courseName: name,
    );
  }
}