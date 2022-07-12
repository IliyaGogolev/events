// import 'package:event2go/features/chat/bloc/contacts_bloc.dart';
import 'package:event2go/features/group/viewmodel/group_bloc.dart';
import 'package:event2go/utils/extensions.dart';
import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models/contact.dart';

class GroupWidget extends StatefulWidget {
  @override
  GroupWidgetState createState() => GroupWidgetState();
}

class GroupWidgetState extends State<GroupWidget> {
  double contactWidth = 80.0;
  var _groupTitleTextFieldController = TextEditingController();
  // ContactsBloc _contactsBloc;
  GroupBloc _groupBloc;

  @override
  void initState() {
    super.initState();
    print("GroupWidgetState initState");
    // _contactsBloc = context.read<ContactsBloc>();
    _groupBloc = context.read<GroupBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
        bloc: _groupBloc,
        builder: (context, state) {
          print("build createEditGroupWidget, state $state");
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
                    onCreateButtonClick();
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
        margin: EdgeInsets.all(18),
        child: ListTile(
          leading: Icon(
            Icons.photo_size_select_actual,
            size: 60,
          ),
          title: createTitleEditBox(),
        ));
  }

  Padding createParticipantCountTextView() {
    return Padding(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: FittedBox(child: Text(" ${_groupBloc.group.contacts.length} Participants")));
  }

  Container createTitleEditBox() {
    return Container(
      height: 48,
      child: TextField(
        style: TextStyle(
          height: 0.8,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
          controller: _groupTitleTextFieldController,
          maxLength: 24,
          decoration: InputDecoration(hintText: 'Group Subject')
          ),
    );
  }

  LayoutBuilder addSelectedContacts(BuildContext context) {
    bool empty = _groupBloc.group.contacts.isEmpty;
    print("_contactsBloc.selectedContacts.isNotEmpty $empty");
    return _groupBloc.group.contacts.isNotEmpty
        ? LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Wrap(
                children: _groupBloc.group.contacts
                    .map((contact) => InkWell(
                          // onTap: () => removeSelectedContact(contact),
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
                              // Container(
                              //     child: Padding(
                              //   padding: const EdgeInsets.only(right: 10),
                              //   child: Align(alignment: Alignment(1, -1), child: Icon(Icons.remove_circle, size: 18)),
                              // ))
                            ]),
                          ),
                        ))
                    .toList(),
              ),
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
    // _contactsBloc.close();
  }

  // void removeSelectedContact(Contact contact) {
  //   print("removeSelectedContact ${contact.displayName}");
  //   var selectedContacts = _contactsBloc.selectedContacts;
  //   if (selectedContacts.contains(contact)) {
  //     // setState(() {
  //     // selectedContacts.remove(contact);
  //     _contactsBloc.add(ContactSelectedEvent(contact: contact, selected: false));
  //     // _contactsBloc.add(ContactSelectedEvent(contacts: contacts));
  //     hideKeyboard();
  //     // });
  //   }
  // }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onCreateButtonClick() {

  }
}
