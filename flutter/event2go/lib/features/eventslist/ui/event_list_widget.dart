// import 'package:event2go/login/ui/signup.dart';
import 'package:event2go/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:event2go/features/addevent/add_event_widget.dart';
import 'package:models/models/contact.dart';

class EventListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventListState();
}

class EventListState extends State<EventListWidget> {
  final Contact _contact = new Contact(
    id: "firstName",
    firstName: "firstName",
    lastName: "lastName",
    email: null,
    phone: null,
    avatar: null,
    birthday: null
    // "familyName",
    // "company",
    // "jobTitle",
    // "note",
  );

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SafeArea(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                  title: new Text("First Name"),
                  trailing: new Text(_contact.firstName ?? "")),
              new ListTile(
                  title: new Text("Last name"),
                  trailing: new Text(_contact.lastName ?? "")),
              // new ListTile(
              //     title: new Text("Family name"),
              //     trailing: new Text(_contact.familyName ?? "")),
              // new ListTile(
              //     title: new Text("Prefix"),
              //     trailing: new Text(_contact.prefix ?? "")),
              // new ListTile(
              //     title: new Text("Suffix"),
              //     trailing: new Text(_contact.suffix ?? "")),
              // new ListTile(
              //     title: new Text("Company"),
              //     trailing: new Text(_contact.company ?? "")),
              // new ListTile(
              //     title: new Text("Job"),
              //     trailing: new Text(_contact.jobTitle ?? "")),
              // new ListTile(
              //     title: new Text("Name"),
              //     trailing: new Text(_contact.givenName ?? "")),
              // new ListTile(
              //     title: new Text("Middle name"),
              //     trailing: new Text(_contact.middleName ?? "")),
              // new ListTile(
              //     title: new Text("Family name"),
              //     trailing: new Text(_contact.familyName ?? "")),
              // new ListTile(
              //     title: new Text("Prefix"),
              //     trailing: new Text(_contact.prefix ?? "")),
              // new ListTile(
              //     title: new Text("Suffix"),
              //     trailing: new Text(_contact.suffix ?? "")),
              // new ListTile(
              //     title: new Text("Company"),
              //     trailing: new Text(_contact.company ?? "")),
              // new ListTile(
              //     title: new Text("Job"),
              //     trailing: new Text(_contact.jobTitle ?? "")),
            ],
          ),
        ),
        floatingActionButton: eventsFab());
  }

  Widget eventsFab() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: _onFabButtonClicked,
      tooltip: 'Toggle',
      child: Icon(Icons.create),
    );
  }

  void _onFabButtonClicked() {
    // Putting our code inside "setState" tells the app ®that our state has changed, and
    // it will automatically re-render the list
    Navigator.pushNamed(context, AddEventWidget.tag);
//    Navigator.of(context).pushNamed(AddEventWidget.tag);
//    setState(() {
//
////      int index = _todoItems.length;
////      _todoItems.add('Item ' + index.toString());
//    });
  }

  void loadEvents() async {
    ApiProvider p = new ApiProvider();
    var events = await p.getEvents();
    for (final e in events) {
      print("Event $e");
    }
  }
}
