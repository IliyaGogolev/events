import 'package:flutter/material.dart';
import 'package:event2go/features/selectcontacts/ui/phone_contact_list.dart';
import 'event_time_widget.dart';

class AddEventWidget extends StatefulWidget {
  static String tag = '/addeventwidget';

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEventWidget> {
//  TextEditingController _controller;

  var _inviteText = "Invite People";

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
                  onTap: () => _onInviteClicked(context)
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

  void _onInviteClicked(BuildContext context) {
    print("_onInviteClicked");
    Navigator.pushNamed(context, PhoneContactListWidget.tag);

  }
}
