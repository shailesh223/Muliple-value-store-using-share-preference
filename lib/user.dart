class User {
  final String? password;
  final String? email;

  User({this.password, this.email});

  User.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'password': password,
        'email': email,
      };
}
