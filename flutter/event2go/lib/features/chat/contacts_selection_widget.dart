import 'dart:ffi';

import 'package:event2go/features/chat/no_glow_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'contact_details.dart';

class UsersSelectionWidget extends StatefulWidget {
  static String tag = 'chat_list_view';

  @override
  UsersSelectionState createState() => UsersSelectionState();
}

class UsersSelectionState extends State<UsersSelectionWidget> {
  // List<String> _chatList = [];
  Iterable<Contact> _contacts;
  List<Contact> _selectedContacts = [];
  double selectedContactWidth = 80.0;
  ScrollController _scrollController = ScrollController();

  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initContacts();
  }

  initContacts() async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      await Permission.contacts.request();
      PermissionStatus permission = await Permission.contacts.status;
      if (permission == PermissionStatus.granted) {
        loadContactsPermissionGranted();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Oops!'),
            content: const Text('Looks like permission to read contacts is not granted.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } else {
      loadContactsPermissionGranted();
    }
  }

  void loadContactsPermissionGranted() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      print("setState contacts: ${contacts.length}");
      _contacts = contacts;
    });
  }

  Widget selectUsersWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(title: new Text('Add Participants'), actions: <Widget>[
          new TextButton(
              child: new Text(
                'Next',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {})
        ]),
        body: Column(
          children: <Widget>[createSearchEditText(), addSelectedContacts(), createContactsList()].notNulls(),
        ));
  }

  SingleChildScrollView addSelectedContacts() {
    return _selectedContacts.isNotEmpty
        ? SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: _selectedContacts
                  .map((contact) => InkWell(
                        onTap: () => removeSelectedContact(contact),
                        child: Container(
                          width: selectedContactWidth,
                          child: Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  contactCircleAvatar(contact),
                                  Text(
                                    contact.displayName,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(child: Align(alignment: Alignment(1, -1), child: Icon(Icons.close, size: 18)))
                          ]),
                        ),
                      ))
                  .toList(),
            ),
          )
        : null;
  }

  Expanded createContactsList() {
    return new Expanded(
      child: _contacts != null
          ? new ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact c = _contacts?.elementAt(index);
                var c2 = c;
                return new ListTile(
                  onTap: () {
                    addContactToSelectedContacts(c);
                    // Navigator.of(context)
                    //     .push(new MaterialPageRoute(builder: (BuildContext context) => new ContactDetails(c)));
                  },
                  leading: contactCircleAvatar(c),
                  // child: new Text(c2.displayName.length > 1 ? c.displayName?.substring(0, 2) : "")),
                  title: new Text(c.displayName ?? ""),
                );
              },
            )
          : new Center(child: new CircularProgressIndicator()),
    );
  }

  void addContactToSelectedContacts(Contact c) {
    if (!_selectedContacts.contains(c)) {
      setState(() {
        print("selectedContacts : ${c.displayName}");
        _selectedContacts.add(c);
        scrollSelectedListToEnd();
      });
    }
  }

  CircleAvatar contactCircleAvatar(Contact c) {
    return (c.avatar != null && c.avatar.length > 0)
        ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar))
        : new CircleAvatar(child: Icon(Icons.person));
  }

  void scrollSelectedListToEnd() {
    _scrollController.animateTo(selectedContactWidth * (_selectedContacts.length - 1),
        duration: Duration(milliseconds: 1000), curve: Curves.ease);
  }

  Container createSearchEditText() {
    return Container(
      // padding: const Edge.only(left: 8, top: 8, right: 8, bottom: 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      // decoration: const BoxDecoration(
      //   border: const Border(
      //     bottom: BorderSide(
      //       color: CupertinoColors.inactiveGray,
      //     ),
      //   ),
      // ),
      child: const ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          Icons.search,
          // color: Colors.black,
          size: 28,
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              // color: Colors.black,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return selectUsersWidget();
  }

  @override
  dispose() {
    super.dispose();
  }

  removeSelectedContact(Contact contact) {
    print("removeSelectedContact ${contact.displayName}");
    if (_selectedContacts.contains(contact)) {
      setState(() {
        _selectedContacts.remove(contact);
        scrollSelectedListToEnd();
      });
    }
  }
}

extension NotNulls on List {
  ///Returns items that are not null, for UI Widgets/PopupMenuItems etc.
  notNulls() {
    return where((e) => e != null).toList();
  }
}
