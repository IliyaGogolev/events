import 'package:event2go/network/raw_models/contact.dart' as rawContact;
import 'package:event2go/network/raw_models/group.dart' as rawGroup;
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

extension RawGroupMapping on rawGroup.Group {
  Group toGroup() {
    return Group(title: this.title, contacts: this.contacts.map((e) => e.toContact()).toList());
  }
}

extension RawContactMapping on rawContact.Contact {
  Contact toContact() {
    return Contact(firstName: this.name);
  }
}

extension ContactToRawMapping on Contact {
  rawContact.Contact toRawContact() {
    return rawContact.Contact(name: this.displayName);
  }
}