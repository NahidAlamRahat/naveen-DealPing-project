class BusinessSignUpModel {
  final String businessName;
  final String eiinNumber;
  final String licenceNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;

  BusinessSignUpModel(
      {required this.licenceNumber,
      required this.businessName,
      required this.eiinNumber,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.role});

  Map<String, dynamic> toJson() {
    return {
      "businessName": businessName,
      "eiin": eiinNumber,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "license": licenceNumber,
      "role": "business",
    };
  }
}
