class User {
  final String email;
  final String id;

  User({
    required this.email,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
    };
  }

  // Méthode statique pour vérifier les credentials
  static bool validateCredentials(String email, String password) {
    return email == 'admin@gmail.com' && password == 'admin';
  }
}
