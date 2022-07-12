
import 'package:models/models/contact.dart';
import 'package:contacts_service/contacts_service.dart' as phoneContacts;

extension NotNulls on List {
  ///Returns items that are not null, for UI Widgets/PopupMenuItems etc.
  notNulls() {
    return where((e) => e != null).toList();
  }
}


extension PhontContactMapper on phoneContacts.Contact {
  Contact toContact() {
    return Contact(displayName: this.displayName, avatar: this.avatar);
  }
}
