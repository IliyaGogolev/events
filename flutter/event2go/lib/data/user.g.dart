// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$UserFromJson(Map<String, dynamic> json) {
  return MyUser(
    token: json['token'] as String,
    uid: json['uid'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(MyUser instance) => <String, dynamic>{
      'token': instance.token,
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
