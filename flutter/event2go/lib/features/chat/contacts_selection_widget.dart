import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String _searchFilterText = "";
  String _toolbarSubtitle = "";
  var _searchTextFieldController = TextEditingController();

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
      updateToolbarSubtitle();
    });
  }

  Widget selectUsersWidget() {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(title:
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
              text: "Add Participants",
              style: TextStyle(fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text: _toolbarSubtitle.isEmpty ? "" : "\n$_toolbarSubtitle",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ]
          ),
        ),
            actions: <Widget>[
          new TextButton(
              child: new Text(
                'Next',
                textScaleFactor: 1.4,
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

  LayoutBuilder addSelectedContacts() {
    return _selectedContacts.isNotEmpty
        ? LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: viewportConstraints.maxWidth),
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
                                        SizedBox(height: 6),
                                        Text(
                                          contact.displayName,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child:
                                        Align(alignment: Alignment(1, -1), child: Icon(Icons.remove_circle, size: 18)),
                                  ))
                                ]),
                              ),
                            ))
                        .toList(),
                  ),
                ));
          })
        : null;
  }

  Expanded createContactsList() {
    Iterable<Contact> filteredContacts = _contacts != null
        ? _contacts
            .where((element) => element.displayName.toLowerCase().startsWith(_searchFilterText.toLowerCase()))
            .toList()
        : null;
    return new Expanded(
      child: filteredContacts != null
          ? new ListView.builder(
              itemCount: filteredContacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact c = filteredContacts?.elementAt(index);
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

  CircleAvatar contactCircleAvatar(Contact c) {
    return (c.avatar != null && c.avatar.length > 0)
        ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar))
        : new CircleAvatar(child: Icon(Icons.person));
  }

  void scrollSelectedListToEnd() {
    double width = MediaQuery.of(context).size.width;
    if (selectedContactWidth * (_selectedContacts.length) > width) {
      _scrollController.animateTo(selectedContactWidth * (_selectedContacts.length),
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    }
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
      child: TextField(
          controller: _searchTextFieldController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchFilterText = "";
                    _searchTextFieldController.clear();
                  });
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none),
          onChanged: (text) {
            print('search $text');
            setState(() {
              _searchFilterText = text;
            });
          }),
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

  void addContactToSelectedContacts(Contact c) {
    if (!_selectedContacts.contains(c)) {
      setState(() {
        print("selectedContacts : ${c.displayName}");
        _selectedContacts.add(c);
        scrollSelectedListToEnd();
        updateToolbarSubtitle();
        hideKeyboard();
      });
    }
  }

  void removeSelectedContact(Contact contact) {
    print("removeSelectedContact ${contact.displayName}");
    if (_selectedContacts.contains(contact)) {
      setState(() {
        _selectedContacts.remove(contact);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 1000), curve: Curves.ease
        );
        updateToolbarSubtitle();
        hideKeyboard();
      });
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void updateToolbarSubtitle() {
    if (_contacts.isEmpty) {
      _toolbarSubtitle = "";
    } else {
      _toolbarSubtitle = "${_selectedContacts.length}/${_contacts.length}";
    }
  }
}

extension NotNulls on List {
  ///Returns items that are not null, for UI Widgets/PopupMenuItems etc.
  notNulls() {
    return where((e) => e != null).toList();
  }
}
