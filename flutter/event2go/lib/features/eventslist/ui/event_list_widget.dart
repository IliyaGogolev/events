// import 'package:event2go/login/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:event2go/features/addevent/add_event_widget.dart';

class EventListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventListState();
}

class EventListState extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
//    return Text("AA");
    return new Scaffold(
      body: Text("EVENTS TAB"),
      floatingActionButton: eventsFab()

    );
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

}

