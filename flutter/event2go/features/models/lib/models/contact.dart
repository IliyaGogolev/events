import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.birthday,
  });

  String? firstName, lastName, id;
  Map<String, String>? email;
  Map<String, String>? phone;
  Uri? avatar;
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
