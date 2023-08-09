import 'dart:io';

class Grade {
  final String id;
  final String name;
  final double? grade;

  Grade({
    required this.id,
    required this.name,
    required this.grade,
  });

  String get gradeString => grade != null ? grade.toString() : '?';

  factory Grade.fromJson(String id, Map<String, dynamic> jsonGrade, Map<String, dynamic> jsonSubject) {
    final String defaultLocale = Platform.localeName.substring(0, 2);
    return Grade(
        id: id,
        name: jsonSubject[id]['name'][defaultLocale] ?? jsonSubject[id]['name']['en'] ?? jsonSubject[id]['name'].first,
        grade: jsonGrade['course_grades'].last.values.first != null
            ? double.tryParse(jsonGrade['course_grades'].last.values.first['value_symbol'].replaceAll(',', '.'))
            : null);
  }

  @override
  String toString() {
    return 'Grade{id: $id, name: $name, grade: $grade}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
    };
  }
}
