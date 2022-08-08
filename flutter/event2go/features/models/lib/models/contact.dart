import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Contact extends Equatable {

  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.birthday,
    this.displayName
  });

  String? firstName, lastName, id;
  Map<String, String>? email;
  Map<String, String>? phone;
  // TODO check how to save contact image URI
  Uint8List? avatar;
  String? displayName;
  DateTime? birthday;

  @override
  List<Object?> get props => [firstName, lastName, email, phone, avatar, birthday];
}
//
// class Contact {
//   String identifier,
//       displayName,
//       givenName,
//       middleName,
//       prefix,
//       suffix,
//       familyName,
//       company,
//       jobTitle,
//       note;
//
//   Contact(this.givenName, this.middleName, this.prefix, this.suffix,
//       this.familyName, this.company, this.jobTitle, this.note);
// }
