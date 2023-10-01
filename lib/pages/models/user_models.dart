class UserModel {
  String name;
  String email;
  String password;
  String route;


  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.route

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      route: json['route'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    'route':route,
  };
}