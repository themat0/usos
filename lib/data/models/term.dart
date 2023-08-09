import 'dart:io';

class Term {
  final String termId;
  final String name;

  const Term({
    required this.termId,
    required this.name,
  });

  factory Term.fromJson(Map<String, dynamic> json) {
    final String defaultLocale = Platform.localeName.substring(0, 2);
    return Term(
      termId: json['id'],
      name: json['name'][defaultLocale] ?? json['name']['en'] ?? json['name'].first,
    );
  }

  @override
  String toString() {
    return 'Term{termId: $termId, name: $name}';
  }
}
