/// User class
/// phone number is unique and used as a User key
class User {

  final String phoneNumber;
  final String name;
  final String email;
  final String imageUrl;

  User(this.name,
      this.email,
      this.phoneNumber,
      this.imageUrl);

//  User.fromJson(Map<String, dynamic> json)
//      : name = json['name'],
//        email = json['email'];
//
//  Map<String, dynamic> toJson() =>
//      {
//        'name': name,
//        'email': email,
//      };
}