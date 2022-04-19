class AdsCourse {
  final String course_id;
  final String ads_heading;
  final String ads_description;
  final String date_created;
  AdsCourse({
    required this.course_id,
    required this.ads_heading,
    required this.ads_description,
    required this.date_created,
  });

  factory AdsCourse.fromJson(Map<String, dynamic> json) {
    return AdsCourse(
      course_id: json['course_id'] as String,
      ads_heading: json['ads_heading'] as String,
      ads_description: json['ads_description'] as String,
      date_created: json['date_created'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'course_id': course_id,
        'ads_heading': ads_heading,
        'ads_description': ads_description,
        'date_created': date_created,
      };
}
