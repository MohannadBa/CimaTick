class UserDetails {
  late String fullName;
  late String email;
  late String dateOfBirth;
  late String phone;

  UserDetails({
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phone,
  });

  //Convert UserDetails object to a Mao
  Map<dynamic, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'phone': phone,
    };
  }

  //Create a UserDetails Object from a Map
  factory UserDetails.fromMap(Map<dynamic, dynamic> map) {
    return UserDetails(
      fullName: map['fullName'],
      email: map["email"],
      dateOfBirth: map['dateOfBirth'],
      phone: map['phone'],
    );
  }
}
