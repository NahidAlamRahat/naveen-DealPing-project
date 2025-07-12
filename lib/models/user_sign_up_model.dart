class UserSignUpModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  UserSignUpModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.role});

  Map<String, dynamic> toJson() {
    return {
      "name": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": "user",
    };
  }

}
