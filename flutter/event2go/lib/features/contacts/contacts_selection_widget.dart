import 'package:event2go/features/contacts/bloc/contacts_bloc.dart';
import 'package:event2go/features/navigator/app_navigator.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/repositories/groups_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:event2go/utils/extensions.dart';
import 'package:models/models/contact.dart' as modelContact;

class ContactsSelectionWidget extends StatefulWidget {
  const ContactsSelectionWidget({
    required this.onContactsSelected,
    required this.onBackPressed,
  });

  static const String tag = 'chat_list_view';
  final void Function(List<modelContact.Contact> contacts) onContactsSelected;
  final VoidCallback onBackPressed;

  @override
  ContactsSelectionState createState() => ContactsSelectionState();
}

class ContactsSelectionState extends State<ContactsSelectionWidget> {
  double selectedContactWidth = 80.0;
  ScrollController _scrollController = ScrollController();
  String _searchFilterText = "";
  String _toolbarSubtitle = "";
  var _searchTextFieldController = TextEditingController();

  late ContactsBloc _contactsBloc;

  @override
  void initState() {
    super.initState();
    print("[ContactsSelectionState][initState]");
    _contactsBloc = context.read<ContactsBloc>();
    // _repository = context.read<Repositories>();
    initContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
        bloc: _contactsBloc,
        builder: (context, state) {
          print("[ContactsSelectionState][build] selectUsersWidget, state $state");
          updateToolbarSubtitle();
          return selectUsersWidget();
        });
  }

  initContacts() async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted) {
      await Permission.contacts.request();
      PermissionStatus permission = await Permission.contacts.status;
      if (permission == PermissionStatus.granted) {
        loadContactsPermissionGranted(context);
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
      loadContactsPermissionGranted(context);
    }
  }

  void loadContactsPermissionGranted(BuildContext context) async {
    var contacts = await ContactsService.getContacts();
    print("[ContactsSelectionState][loadContactsPermissionGranted] contacts: ${contacts.length}");
    _contactsBloc.add(ContactsLoadedEvent(contacts: contacts));
  }

  Widget selectUsersWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
            leading: BackButton(
              onPressed: () {
                widget.onBackPressed();
              },
            ),
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(text: "Add Participants", style: TextStyle(fontSize: 20), children: <TextSpan>[
                TextSpan(
                  text: _toolbarSubtitle.isEmpty ? "" : "\n$_toolbarSubtitle",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ]),
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
                  onPressed: () {
                    onNextButtonClick();
                  })
            ]),
        body: Column(
            children: <Widget?>[createSearchEditText(), addSelectedContacts(context), createContactsList()]
                .notNulls()
                .cast<Widget>()));
  }

  LayoutBuilder? addSelectedContacts(BuildContext context) {
    print(
        "[ContactsSelectionState][addSelectedContacts] selectedContacts.length ${_contactsBloc.selectedContacts.length}");
    return _contactsBloc.selectedContacts.isNotEmpty
        ? LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: viewportConstraints.maxWidth),
                  child: Row(
                    children: _contactsBloc.selectedContacts
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
                                          contact.displayName ?? "",
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
    var contacts = _contactsBloc.contacts;
    Iterable<Contact>? filteredContacts;
    if (contacts.isNotEmpty) {
      filteredContacts = contacts
          .where((element) => element.displayName?.toLowerCase()?.startsWith(_searchFilterText.toLowerCase()) ?? false)
          .toList();
    } else {
      filteredContacts = null;
    }
    return new Expanded(
      child: filteredContacts != null
          ? new ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact? filteredContact = filteredContacts!.elementAt(index);
                return new ListTile(
                  onTap: () {
                    addContactToSelectedContacts(filteredContact);
                    // Navigator.of(context)
                    //     .push(new MaterialPageRoute(builder: (BuildContext context) => new ContactDetails(c)));
                  },
                  leading: contactCircleAvatar(filteredContact),
                  // child: new Text(c2.displayName.length > 1 ? c.displayName?.substring(0, 2) : "")),
                  title: new Text(filteredContact.displayName ?? ""),
                );
              },
            )
          : new Center(child: new CircularProgressIndicator()),
    );
  }

  CircleAvatar contactCircleAvatar(Contact c) {
    return (c.avatar != null && c.avatar!.length > 0)
        ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar!))
        : new CircleAvatar(child: Icon(Icons.person));
  }

  void scrollSelectedListToEnd() {
    double width = MediaQuery.of(context).size.width;
    var selectedContacts = _contactsBloc.selectedContacts;
    if (selectedContactWidth * (selectedContacts.length) > width) {
      _scrollController.animateTo(selectedContactWidth * (selectedContacts.length),
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
  dispose() {
    super.dispose();
    // Closes the [Event] and [State] [Stream]s.
    //   _contactsBloc.close();
  }

  void addContactToSelectedContacts(Contact contact) {
    if (!_contactsBloc.selectedContacts.contains(contact)) {
      print("selectedContacts : ${contact.displayName}");
      _contactsBloc.add(ContactSelectedEvent(contact: contact, selected: true));
      scrollSelectedListToEnd();
      updateToolbarSubtitle();
      hideKeyboard();
    }
  }

  void removeSelectedContact(Contact contact) {
    print("removeSelectedContact ${contact.displayName}");
    var selectedContacts = _contactsBloc.selectedContacts;
    if (selectedContacts.contains(contact)) {
      _contactsBloc.add(ContactSelectedEvent(contact: contact, selected: false));
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
      updateToolbarSubtitle();
      hideKeyboard();
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void updateToolbarSubtitle() {
    if (_contactsBloc.contacts.isEmpty) {
      _toolbarSubtitle = "";
    } else {
      _toolbarSubtitle = "${_contactsBloc.selectedContacts.length}/${_contactsBloc.contacts.length}";
    }
  }

  void onNextButtonClick() {
    setState(() {
      List<modelContact.Contact> contacts =
          _contactsBloc.selectedContacts.map((phoneContact) => phoneContact.toContact()).toList();
      widget.onContactsSelected(contacts);
    });
  }
}
