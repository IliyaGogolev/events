import 'package:event2go/features/chat/contactsbloc/contacts_bloc.dart';
import 'package:event2go/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupWidget extends StatefulWidget {
  @override
  GroupWidgetState createState() => GroupWidgetState();
}

class GroupWidgetState extends State<GroupWidget> {
  double contactWidth = 80.0;
  var _groupTitleTextFieldController = TextEditingController();
  ContactsBloc _contactsBloc;

  @override
  void initState() {
    super.initState();
    print("ContactsSelectionState initState");
    _contactsBloc = context.read<ContactsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
        bloc: _contactsBloc,
        builder: (context, state) {
      print("build selectUsersWidget, state $state");
      return createEditGroupWidget();
    });
  }

  Widget createEditGroupWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(text: "New Group", style: TextStyle(fontSize: 20), children: <TextSpan>[
                TextSpan(
                  text: "",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ]),
            ),
            actions: <Widget>[
              new TextButton(
                  child: new Text(
                    'Create',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              createGroupSubjectEditText(),
              Divider(color: Colors.black),
              createParticipantCountTextView(),
              Divider(color: Colors.black),
              addSelectedContacts(context)
            ].notNulls()));
  }

  Container createGroupSubjectEditText() {
    return Container(
        margin: EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(
            Icons.photo_size_select_actual,
            size: 60,
          ),
          title: createTitleEditBox(),
        ));
  }

  Padding createParticipantCountTextView() {
    return Padding(padding: EdgeInsets.only(left: 12, right: 12), child: FittedBox(child: Text("11 Participants")));
  }

  TextField createTitleEditBox() {
    return TextField(
        controller: _groupTitleTextFieldController,
        maxLength: 24,
        decoration: InputDecoration(hintText: 'Group Subject')
    );
  }

  LayoutBuilder addSelectedContacts(BuildContext context) {
    bool empty = _contactsBloc.selectedContacts.isEmpty;
    print("_contactsBloc.selectedContacts.isNotEmpty $empty");
    return _contactsBloc.selectedContacts.isNotEmpty
        ? LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Wrap(
                children: _contactsBloc.selectedContacts
                    .map((contact) => InkWell(
                          onTap: () => removeSelectedContact(contact),
                          child: Container(
                            width: contactWidth,
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
            );
          })
        : null;
  }

  CircleAvatar contactCircleAvatar(Contact c) {
    return (c.avatar != null && c.avatar.length > 0)
        ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar))
        : new CircleAvatar(child: Icon(Icons.person));
  }

  @override
  dispose() {
    super.dispose();
  }

  void removeSelectedContact(Contact contact) {
    print("removeSelectedContact ${contact.displayName}");
    var selectedContacts = _contactsBloc.selectedContacts;
    if (selectedContacts.contains(contact)) {
      // setState(() {
        // selectedContacts.remove(contact);
        _contactsBloc.add(ContactSelectedEvent(contact: contact, selected: false));
        // _contactsBloc.add(ContactSelectedEvent(contacts: contacts));
        hideKeyboard();
      // });
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onNextButtonClick() {}
}
