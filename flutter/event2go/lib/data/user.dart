import 'package:json_annotation/json_annotation.dart';

/// the star denotes the source file name.
part 'user.g.dart';

@JsonSerializable()
class MyUser {

//  User({this.token, this.test = "111"});
  MyUser({this.token, this.uid, this.phoneNumber, this.email});

//  final String test;

  String token;
  String uid;
  String phoneNumber;
  String email;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

//  final String phoneNumber;
//  final String name;
//  final String email;
//  final String imageUrl;
//
//  User(this.name,
//      this.email,
//      this.phoneNumber,
//      this.imageUrl);

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
