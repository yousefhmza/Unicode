class AuthBody {
  String? email;
  String? password;

  AuthBody({this.email, this.password});

  void copyWith({
    String? email,
    String? password,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }
}
