class News {
  final String id;
  final String heading;
  final String description;
  final String date_created;
  final String image;
  News(
      {required this.id,
      required this.heading,
      required this.description,
      required this.date_created,
      required this.image});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String,
      heading: json['heading'] as String,
      description: json['description'] as String,
      date_created: json['date_created'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'heading': heading,
        'description': description,
        'date_created': date_created,
        'image': image,
      };
}
