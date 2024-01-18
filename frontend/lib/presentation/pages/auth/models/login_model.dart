class LoginResponse {
  final String message;
  final int status;
  final String? error;
  final User data;

  LoginResponse({
    required this.message,
    required this.status,
    this.error,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      status: json['status'],
      error: json['error'],
      data: User.fromJson(json['data']),
    );
  }
}

class User {
  final String id;
  final String fullname;
  final String email;
  final String photo;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
