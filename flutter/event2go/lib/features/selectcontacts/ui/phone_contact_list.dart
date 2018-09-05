import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:event2go/features/selectcontacts/ui/data/phone_contact.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

class PhoneContactListWidget extends StatefulWidget {
  static String tag = '/phone_contacts';

  @override
  _PhoneContactListState createState() => new _PhoneContactListState();
}

class _PhoneContactListState extends State<PhoneContactListWidget> {
  List<Contact> _contacts;
  List<PhoneContact> _allContacts = List<PhoneContact>();
  List<PhoneContact> _uiCustomContacts = List<PhoneContact>();
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    getContactsPermission().then((granted) async {
      if (granted) {
        var contacts = await ContactsService.getContacts();
        setState(() {
          _populateContacts(contacts);
//          _contacts = contacts;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Oops!'),
                content: const Text(
                    'Looks like permission to read contacts is not granted.'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Contacts List')),
//      floatingActionButton: new FloatingActionButton(
//          child: new Icon(Icons.add),
//          onPressed: () {
//            Navigator.of(context).pushNamed("/add");
//          }),
      body: new SafeArea(
        child: !_isLoading && _contacts != null
            ? new ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  PhoneContact contact = _uiCustomContacts[index];

                  return _buildListTile(
                      contact, contact.contact.phones.toList());
                },
              )
//
//                  return new ListTile(
//                    // todo onTap
////              onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new _ContactDetails(c)));},
//                    leading: (contact.contact.avatar != null && contact.contact.avatar.length > 0)
//                        ? new CircleAvatar(
//                            backgroundImage: new MemoryImage(contact.contact.avatar))
//                        : new CircleAvatar(
//                            child: new Text((contact.contact.displayName != null && contact.contact.displayName.length > 1)
//                                ? contact.contact.displayName.substring(0, 2)
//                                : "")),
//                    title: new Text(contact.contact.displayName ?? ""),
//
//                    trailing: Checkbox(
//                        activeColor: Colors.green,
//                        value: false,
//                        onChanged: (bool value) {
//                          setState(() {
//                            contact.isChecked = value;
//                          });
//                        }),
//                  );
//                },
//              )
            : new Center(child: new CircularProgressIndicator()),
      ),
    );
  }

  ListTile _buildListTile(PhoneContact c, List<Item> list) {
    return ListTile(
      leading: (c.contact.avatar != null)
          ? CircleAvatar(backgroundImage: MemoryImage(c.contact.avatar))
          : CircleAvatar(
              child: Text(
                  (c.contact.displayName[0] +
                      c.contact.displayName[1].toUpperCase()),
                  style: TextStyle(color: Colors.white)),
            ),
      title: Text(c.contact.displayName ?? ""),
      subtitle: list.length >= 1 && list[0]?.value != null
          ? Text(list[0].value)
          : Text(''),
      trailing: Checkbox(
          activeColor: Colors.green,
          value: c.isChecked,
          onChanged: (bool value) {
            setState(() {
              c.isChecked = value;
            });
          }),
    );
  }

  void _populateContacts(Iterable<Contact> contacts) {
    _contacts = contacts.where((item) => item.displayName != null).toList();

//    _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));

    _allContacts =
        _contacts.map((contact) => PhoneContact(contact: contact)).toList();

    setState(() {
      _uiCustomContacts = _allContacts;
      _isLoading = false;
    });
  }

  Future<bool> getContactsPermission() =>
      SimplePermissions.requestPermission(Permission.ReadContacts);
}
