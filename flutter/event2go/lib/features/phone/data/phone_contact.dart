import 'package:contacts_service/contacts_service.dart';

class PhoneContact {
  final Contact contact;
  bool isChecked;

  PhoneContact({
    this.contact,
    this.isChecked = false,
  });
}