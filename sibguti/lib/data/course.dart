class Course {
  final String id;
  final String name_course;
  final String description_course;
  final String teacher_course;
  final String number_course;
  Course(
      {required this.id,
      required this.name_course,
      required this.description_course,
      required this.teacher_course,
      required this.number_course});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name_course: json['name_course'] as String,
      description_course: json['description_course'] as String,
      teacher_course: json['teacher_course'] as String,
      number_course: json['number_course'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_course': name_course,
        'description_course': description_course,
        'teacher_course': teacher_course,
        'number_course': number_course,
      };
}
