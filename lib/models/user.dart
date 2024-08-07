class User {
  final String name;
  final String email;
  final String number;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.number,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'number': number,
        'password': password,
      };
}