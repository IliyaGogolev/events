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
          children: <Widget>[
            createSearchEditText(),
            createContactsList()
          ],
        ));
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
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (BuildContext context) => new ContactDetails(c)));
                  },
                  leading: (c.avatar != null && c.avatar.length > 0)
                      ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar))
                      : new CircleAvatar(
                          child: Icon(Icons.person)),
                          // child: new Text(c2.displayName.length > 1 ? c.displayName?.substring(0, 2) : "")),
                  title: new Text(c.displayName ?? ""),
                );
              },
            )
          : new Center(child: new CircularProgressIndicator()),
    );
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
}
