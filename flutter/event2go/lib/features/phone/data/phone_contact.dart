import 'package:contacts_service/contacts_service.dart';

class PhoneContact {
  final Contact contact;
  bool isChecked;

  PhoneContact({
    required this.contact,
    this.isChecked = false,
  });
}