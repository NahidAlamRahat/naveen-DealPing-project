class SignUpModel {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;
  final String eiin;
  final String license;
  final String businessName;
  final String phone;
  final String address;
  final String city;
  final int zipCode;
  final Location location;

  SignUpModel({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
    required this.eiin,
    required this.license,
    required this.businessName,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": role,
      "eiin": eiin,
      "license": license,
      "businessName": businessName,
      "phone": phone,
      "address": address,
      "city": city,
      "zipCode": zipCode,
      "location": location.toJson(),
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}
