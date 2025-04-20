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
      createdAt: json['created_at'],
      name: json['name'],
    );
  }
}
