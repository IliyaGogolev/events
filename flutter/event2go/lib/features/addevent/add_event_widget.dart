import 'package:flutter/material.dart';

class AddEventWidget extends StatefulWidget {
  static String tag = '/addeventwidget';

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEventWidget> {
//  TextEditingController _controller;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
        ),
        body: new SingleChildScrollView(
            child: new Column(children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.event),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.date_range),
            title: new TextFormField(
              initialValue: new DateTime.now().toString(),
              decoration: new InputDecoration(
                hintText: "Date",
              ),

            ),
            onTap: () => showDatePicker(
                  context: context,
                  initialDate: new DateTime.now(),
                  firstDate:
                      new DateTime.now().subtract(new Duration(days: 30)),
                  lastDate: new DateTime.now().add(new Duration(days: 30)),
                ),
          ),
          new ListTile(
            leading: const Icon(Icons.person_pin_circle),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Location",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
        ])));
  }
}
