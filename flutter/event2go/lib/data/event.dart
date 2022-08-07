import 'dart:math';

import 'package:event2go/data/user.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

/// This allows the `Event` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'event.g.dart';

@JsonSerializable()
class Event {

//  User({this.token, this.test = "111"});
  Event(this.name, this.startAt, this.endAt);

//  final String test;

  String? name;
  DateTime? startAt;
  DateTime? endAt;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
//  List<User> users;

  @override
  String toString() {
    return "$name, {$startAt} - {$endAt}";
  }
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
