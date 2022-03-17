import 'package:flutter/material.dart';

export 'package:home/home_widget.dart';

class HomeWidget extends StatefulWidget {
  static String tag = 'home-widget';

  @override
  _HomeWidgetState createState() => new _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
//  Iterable<Contact> _contacts;

  String selectedCountry = "USA";

  @override
  initState() {
    super.initState();
//    initPlatformState();
  }

  initPlatformState() async {
//    var contacts = await ContactsService.getContacts();
//    setState(() {_contacts = contacts;});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        appBar: new AppBar(title: new Text('Event2Go')),
//      floatingActionButton: new FloatingActionButton(
//          child: new Icon(Icons.add),
//          onPressed: (){Navigator.of(context).pushNamed("/add");}
//      ),
        backgroundColor: Colors.grey,
        body: new Center(//new SafeArea(
          child:
          new DropdownButton<String>(
//              menuMargin: EdgeInsets.zero,
              items: <String>['USA', 'B', 'C', 'D'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              value: selectedCountry,
              onChanged: (s) {
                setState(() {
                  selectedCountry = s!;
//
                });
              }

          ),


//        child: _contacts != null?
//        new ListView.builder(
//          itemCount: _contacts?.length ?? 0,
//          itemBuilder: (BuildContext context, int index) {
//            Contact c = _contacts?.elementAt(index);
//            return new ListTile(
//              onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new _ContactDetails(c)));},
//              leading: (c.avatar != null && c.avatar.length > 0) ?
//              new CircleAvatar(backgroundImage: new MemoryImage(c.avatar)):
//              new CircleAvatar(child:  new Text(c.displayName?.length > 1 ? c.displayName?.substring(0, 2) : "")),
//              title: new Text(c.displayName ?? ""),
//            );
//          },
//        ):
//
//        new Center(child: new CircularProgressIndicator()),
        )
    );
  }
}
