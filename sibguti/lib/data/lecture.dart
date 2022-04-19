class Lecture {
  final String course_id;
  final String name_lecture;
  final String link_lecture;
  final String isOpen;
  Lecture({
    required this.course_id,
    required this.name_lecture,
    required this.link_lecture,
    required this.isOpen,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      course_id: json['course_id'] as String,
      name_lecture: json['name_lecture'] as String,
      link_lecture: json['link_lecture'] as String,
      isOpen: json['isOpen'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'course_id': course_id,
        'name_lecture': name_lecture,
        'link_lecture': link_lecture,
        'isOpen': isOpen,
      };
}
