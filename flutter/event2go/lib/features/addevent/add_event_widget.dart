import 'package:flutter/material.dart';
import 'package:event2go/features/phone//ui/select_contacts.dart';
import 'event_time_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';

class AddEventWidget extends StatefulWidget {
  static String tag = '/addeventwidget';

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEventWidget> {
//  TextEditingController _controller;

  var _inviteText = "Invite People";

  List<Contact> _selectedContacts = new List<Contact>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
        ),
        body: new SingleChildScrollView(
            child: new Column(children: <Widget>[
              new ListTile(
                leading: const Icon(Icons.title),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Name",
                  ),
                ),
              ),
              new ListTile(
                  leading: const Icon(Icons.date_range),
                  title: new EventTimeItem()),
              new ListTile(
                  leading: new Text("todo"), title: new EventTimeItem()),
              new ListTile(
                leading: const Icon(Icons.person_pin_circle),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Location",
                  ),
                ),
              ),
              new GestureDetector(
                  child: new ListTile(
                    leading: const Icon(Icons.people),
                    title: new Text('$_inviteText',
                      style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  onTap: () =>  _onInviteClicked(context)
              ),
              const Divider(
                height: 40.0,
              ),
              new ListTile(
                  title: new RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.lightBlue,
                      child: const Text('Create Event'),
                      onPressed: () {})),
            ])));
  }

  Future _onInviteClicked(BuildContext context) async {
    print("_onInviteClicked");


  final result = await Navigator.push(context,
  MaterialPageRoute(builder: (context) => SelectContactsWidget(_selectedContacts)));
//    final result = await Navigator.pushNamed(context, SelectContactsWidget.tag);

//    selectedContacts = result
//  After the Selection Screen returns a result, show it in a Snackbar!
//  Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    print("Result: $result");
    _selectedContacts = result;
//    setState(() {
      if (_selectedContacts != null && _selectedContacts.length > 0) {
        int size = _selectedContacts.length;
        _inviteText = "$size people";
      } else {
        _inviteText = "Invite People";
      }
//    });

  }
}
