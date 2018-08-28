// todo example of ui https://medium.com/flutterpub/create-beautiful-forms-with-flutter-47075cfe712
import 'package:flutter/material.dart';

class UserProfileWidget extends StatefulWidget {
  static String tag = '/addeventwidget';

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Add Event'),
        ),
        body: new SingleChildScrollView(
            child: new Column(children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          new ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Nick'),
            subtitle: const Text('None'),
          ),
          new ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Birthday'),
            subtitle: const Text('February 20, 1980'),
          ),
          new ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Contact group'),
            subtitle: const Text('Not specified'),
          )
        ])));
  }
}
