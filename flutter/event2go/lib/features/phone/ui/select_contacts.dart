import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:event2go/features/phone/data/phone_contact.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

class SelectContactsWidget extends StatefulWidget {
  static String tag = '/phone_contacts';

  @override
  _SelectContactsState createState() => new _SelectContactsState();
}

class _SelectContactsState extends State<SelectContactsWidget> {
  TextEditingController controller = new TextEditingController();

  List<Contact> _contacts;
//  List<PhoneContact> _allContacts = List<PhoneContact>();
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
        appBar: new AppBar(
            title: new Text('Select Friends '),

        ),
//      floatingActionButton: new FloatingActionButton(
//          child: new Icon(Icons.add),
//          onPressed: () {
//            Navigator.of(context).pushNamed("/add");
//          }),
        body: //new SafeArea(
            //child:
            new Column(
          children: <Widget>[
            new Container(
//              color: Theme.of(context).primaryColor,
              child:
//            new Padding(
//                padding: const EdgeInsets.all(8.0),
//                child:
                  new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
//              ),
            ),
            new Expanded(
              child: (!_isLoading && _uiCustomContacts != null)
                  ? new ListView.builder(
                      itemCount: _uiCustomContacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        PhoneContact contact = _uiCustomContacts[index];

                        return _buildListTile(
                            contact, contact.contact.phones.toList());
                      },
                    )
                  : new Center(child: new CircularProgressIndicator()),
            )
          ],
        )
        //),
        );
  }

  GestureDetector _buildListTile(PhoneContact c, List<Item> list) {
    return new GestureDetector(
      child: new ListTile(
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
      ),
      onTap: () {
        setState(() {
          c.isChecked = !c.isChecked;
        });
      },
    );
  }

  void onSearchTextChanged(String text) async {

    if (text.isEmpty) {
      _populateContacts(_contacts);
      return;
    }

    _uiCustomContacts = _contacts
        .where((i) => i.displayName.toLowerCase().contains(text.toLowerCase()))
        .map((contact) => PhoneContact(contact: contact))
        .toList();

    setState(() {});
  }

  void _populateContacts(Iterable<Contact> contacts) {

    _contacts = contacts.where((item) => item.displayName != null).toList();

    _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));

    _uiCustomContacts =
        _contacts.map((contact) => PhoneContact(contact: contact)).toList();

    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> getContactsPermission() =>
      SimplePermissions.requestPermission(Permission.ReadContacts);
}
