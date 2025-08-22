
class BusinessSignUpModel {
  final String businessName;
  final String firstName;
  final String lastName;
  final String eiinNumber;
  final String licenceNumber;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String role;
  final String category;
  final List<String> subCategories;


  BusinessSignUpModel(
      {
        required this.category,

        required this.licenceNumber,
        required this.phone,
        required this.firstName,
        required this.lastName,
      required this.businessName,
      required this.eiinNumber,
      required this.email,
      required this.password,
      required this.confirmPassword,
        required this.subCategories,

        required this.role});

  Map<String, dynamic> toJson() {
    return {
      "name":firstName,
      "lastName": lastName,
      "businessName": businessName,
      "category": category,
      'subCategories': subCategories,
      "eiin": eiinNumber,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmPassword": confirmPassword,
      "license": licenceNumber,
      "role": "business",
    };
  }
}
