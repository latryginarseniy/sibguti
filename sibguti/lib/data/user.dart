class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String university_group;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.university_group,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      university_group: json['university_group'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'university_group': university_group,
      };
}
