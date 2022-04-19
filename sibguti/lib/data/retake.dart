class Retake {
  final String id;
  final String number;
  final String name;
  final String auditorium;
  final String number_group;
  final String teacher;
  final String date_retake;

  Retake({
    required this.id,
    required this.number,
    required this.name,
    required this.auditorium,
    required this.number_group,
    required this.teacher,
    required this.date_retake,
  });

  factory Retake.fromJson(Map<String, dynamic> json) {
    return Retake(
      id: json['id'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      auditorium: json['auditorium'] as String,
      number_group: json['number_group'] as String,
      teacher: json['teacher'] as String,
      date_retake: json['date_retake'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'name': name,
        'auditorium': auditorium,
        'number_group': number_group,
        'teacher': teacher,
        'date_retake': date_retake,
      };
}
