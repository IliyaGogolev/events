import 'package:event2go/features/group/bloc/group_bloc.dart';
import 'package:event2go/features/navigator/app_navigator.dart';
import 'package:event2go/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home_tabs_view.dart';
import 'package:models/models/contact.dart';

class GroupWidget extends StatelessWidget {
  static String tag = '/group';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GroupBloc>(context),
      child: GroupView()
    );
  }
}

class GroupView extends StatelessWidget {
  double contactWidth = 80.0;
  var _groupTitleTextFieldController = TextEditingController();

  // ContactsBloc _contactsBloc;
  late GroupBloc _groupBloc;

  @override
  Widget build(BuildContext context) {
    // return createEditGroupWidget(context);
    return BlocBuilder<GroupBloc, GroupState>(
        bloc: context.read<GroupBloc>(),
        builder: (context, state) {
          print("[GroupView][build] builder state $state");
          return createEditGroupWidget(context, state);
        });
  }

  Widget createEditGroupWidget(BuildContext context, GroupState state) {
    _groupBloc = context.read<GroupBloc>();
    print("[GroupView][createEditGroupWidget] state $state");
    if (state is GroupStateError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showAlertDialog('Error', state.message, context);
      });
    }

    if (state is GroupCreated) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showAlertDialog('Created', "", context);
        navigatePopToRouteName(context, HomeTabsView.tag);
      });
    }

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
                    onCreateButtonClick(context);
                  })
            ]),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget?>[
              createGroupSubjectEditText(),
              Divider(color: Colors.black),
              createParticipantCountTextView(),
              Divider(color: Colors.black),
              addSelectedContacts(context)
            ].notNulls().cast<Widget>()));
  }

  void showAlertDialog(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(title)),
            content: Text(message, textAlign: TextAlign.center),
            actions: <Widget>[
              Center(
                child: TextButton(
                    onPressed: () {
                      _dismissDialog(context);
                    },
                    child: Text('Dismiss')),
              ),
            ],
          );
        }).then((val){
          _groupBloc.add(ErrorDialogDismissedCreateGroupEvent());
      // Navigator.pop(context);
    });
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
          decoration: InputDecoration(hintText: 'Group Subject')),
    );
  }

  LayoutBuilder? addSelectedContacts(BuildContext context) {
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
                                      contact.displayName ?? "",
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
    return (c.avatar != null && c.avatar!.length > 0)
        ? new CircleAvatar(backgroundImage: new MemoryImage(c.avatar!))
        : new CircleAvatar(child: Icon(Icons.person));
  }

  _dismissDialog(context) {
    Navigator.pop(context);
    _groupBloc.add(ErrorDialogDismissedCreateGroupEvent());
  }
  // @override
  // dispose() {
  //   super.dispose();
  //   // _contactsBloc.close();
  // }

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

  void onCreateButtonClick(BuildContext context) {
    String title = _groupTitleTextFieldController.text;
    if (title.isEmpty) {
      showAlertDialog('Missing data', "Please enter a group subject", context);
      // Fluttertoast.showToast(
      //     msg: "Please enter a group subject",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.CENTER,
      //     fontSize: 16.0
      // );
    } else {
      _groupBloc.add(CreateGroupEvent(title: title));
    }
  }
}
