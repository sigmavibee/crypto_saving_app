import 'package:intl/intl.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String createdAt;
  final String name;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      createdAt: DateFormat('MMMM d, y')
          .format(DateTime.parse(json['created_at']).toLocal()),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'created_at': createdAt,
        'name': name,
      };
}
