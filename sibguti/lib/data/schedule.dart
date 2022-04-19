class Schedule {
  final String id;
  final String number;
  final String name;
  final String auditorium;
  final String lecture;
  final String number_group;
  final String teacher;
  final String day_week;

  Schedule({
    required this.id,
    required this.number,
    required this.name,
    required this.auditorium,
    required this.lecture,
    required this.number_group,
    required this.teacher,
    required this.day_week,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      auditorium: json['auditorium'] as String,
      lecture: json['lecture'] as String,
      number_group: json['number_group'] as String,
      teacher: json['teacher'] as String,
      day_week: json['day_week'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'name': name,
        'auditorium': auditorium,
        'lecture': lecture,
        'number_group': number_group,
        'teacher': teacher,
        'day_week': day_week,
      };
}
