import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:event2go/features/phone/data/phone_contact.dart';
import 'package:flutter/material.dart';
// import 'package:simple_permissions/simple_permissions.dart';

class SelectContactsWidget extends StatefulWidget {
  static String tag = '/selectContact';

  final List<Contact> selectedContacts;

  SelectContactsWidget(this.selectedContacts);

  @override
  _SelectContactsState createState() => new _SelectContactsState(selectedContacts);
}

class _SelectContactsState extends State<SelectContactsWidget> {
  TextEditingController controller = new TextEditingController();

  List<Contact> _contacts;
  Set<String> _argContacts = new Set();
  List<Contact> _argSelectedContacts;

//  List<PhoneContact> _allContacts = List<PhoneContact>();
  List<PhoneContact> _uiCustomContacts = List<PhoneContact>();
  bool _isLoading = false;

  String _toolbarText = "Select Friends ";
  int selectedCount = 0;

  _SelectContactsState(List<Contact> selectedContacts) {
    if (selectedContacts != null) {
      selectedCount = selectedContacts.length;
      for (var value in selectedContacts) {
        String phoneNumber = value.phones.first.value;
        _argContacts.add(phoneNumber);
        print("phoneNumber $phoneNumber");
      }

//      void iterateMapEntry(contact) {
//        print('$contact');//string interpolation in action
//      }

//      selectedContacts.forEach(iterateMapEntry);
//      _argContacts = Map.fromIterable(selectedContacts,
//          key: (item) => item.phones, value: (v) => v);
//      _argContacts = Map.fromIterable(selectedContacts,
//          key: (item) => item.phones[0], value: (v) => v);

      updateToolbarText();
    }
  }

  @override
  initState() {
    super.initState();
    // initPlatformState();
  }

  // TODO ILIYA commented out
//   initPlatformState() async {
//     getContactsPermission().then((permission) async {
//       if (permission == PermissionStatus.authorized) {
//         print("GetContacts !!!!");
//
//         var contacts = await ContactsService.getContacts();
//         setState(() {
//           _populateContacts(contacts);
// //          _contacts = contacts;
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: const Text('Oops!'),
//                 content: const Text(
//                     'Looks like permission to read contacts is not granted.'),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: const Text('OK'),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//         );
//       }
//     });
//   }
//   Future<PermissionStatus> getContactsPermission() =>
//       SimplePermissions.requestPermission(Permission.ReadContacts);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('$_toolbarText'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
//                  _formKey.currentState.save();
//                  contact.postalAddresses = [address];
//                  ContactsService.addContact(contact);

                  List<Contact> selectedContacts = getSelectedContacts();
                  Navigator.of(context).pop(selectedContacts);
                },
                child: Text("Save",
                    style: TextStyle(color: Colors.white, fontSize: 16.0)))
          ],
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
              onContactClicked(c);
            }
//    ,
//            onChanged: (bool value) {
//              setState(() {
//                c.isChecked = value;
//              });
//            }
            ),
      ),
      onTap: () {
        onContactClicked(c);
      },
    );
  }

  void onContactClicked(PhoneContact c) {
    setState(() {
      c.isChecked = !c.isChecked;

      selectedCount += c.isChecked ? 1 : -1;

      updateToolbarText();
    });
  }

  void updateToolbarText() {
    if (selectedCount > 0) {
      _toolbarText = "$selectedCount selected";
    } else {
      _toolbarText = "Select Friends";
    }
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

  List<Contact> getSelectedContacts() {
    List<Contact> selectedContacts = _uiCustomContacts
        .where((i) => i.isChecked)
        .map((i) => i.contact)
        .toList();

    return selectedContacts;
  }
}
