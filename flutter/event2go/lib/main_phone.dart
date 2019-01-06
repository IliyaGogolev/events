import 'package:event2go/application.dart';
//import 'package:event2go/features/selectcontacts/ui/phone_contact_List.dart';
import 'package:event2go/features/phone/ui/select_contacts.dart';
import 'package:flutter/material.dart';
import 'features/phone//ui/add_contact_page.dart';
import 'package:contacts_service/contacts_service.dart';

void main() => runApp(new ApplicationWidget());

class DemoApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: <String, WidgetBuilder>{
          '/add': (BuildContext context) => new AddContactPage()
        },
        home: new SelectContactsWidget(null)
    );
  }
}

class _ContactDetails extends StatelessWidget{

  _ContactDetails(this._contact);
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(_contact.displayName ?? ""),
            actions: <Widget>[new FlatButton(child:new Icon(Icons.delete), onPressed: (){ContactsService.deleteContact(_contact);})]
        ),
        body: new SafeArea(
          child: new ListView(
            children: <Widget>[
              new ListTile(title: new Text("Name"),trailing: new Text(_contact.givenName ?? "")),
              new ListTile(title: new Text("Middle name"),trailing: new Text(_contact.middleName ?? "")),
              new ListTile(title: new Text("Family name"),trailing: new Text(_contact.familyName ?? "")),
              new ListTile(title: new Text("Prefix"),trailing: new Text(_contact.prefix ?? "")),
              new ListTile(title: new Text("Suffix"),trailing: new Text(_contact.suffix ?? "")),
              new ListTile(title: new Text("Company"),trailing: new Text(_contact.company ?? "")),
              new ListTile(title: new Text("Job"),trailing: new Text(_contact.jobTitle ?? "")),
              new _AddressesTile(_contact.postalAddresses),
              new ItemsTile("Phones", _contact.phones),
              new ItemsTile("Emails", _contact.emails)
            ],
          ),
        )
    );
  }
}

class _AddressesTile extends StatelessWidget{

  _AddressesTile(this._addresses);
  final Iterable<PostalAddress> _addresses;

  Widget build(BuildContext context){
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(title : new Text("Addresses")),
          new Column(
              children: _addresses.map((a) => new Padding(
                padding : const EdgeInsets.symmetric(horizontal: 16.0),
                child: new Column(
                  children: <Widget>[
                    new ListTile(title : new Text("Street"), trailing: new Text(a.street)),
                    new ListTile(title : new Text("Postcode"), trailing: new Text(a.postcode)),
                    new ListTile(title : new Text("City"), trailing: new Text(a.city)),
                    new ListTile(title : new Text("Region"), trailing: new Text(a.region)),
                    new ListTile(title : new Text("Country"), trailing: new Text(a.country)),
                  ],
                ),
              )).toList()
          )
        ]
    );
  }
}

class ItemsTile extends StatelessWidget{

  ItemsTile(this._title, this._items);
  Iterable<Item> _items;
  String _title;

  @override
  Widget build(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(title : new Text(_title)),
          new Column(
              children: _items.map((i) => new Padding(
                  padding : const EdgeInsets.symmetric(horizontal: 16.0),
                  child: new ListTile(title: new Text(i.label ?? ""), trailing: new Text(i.value ?? "")))).toList()
          )
        ]
    );
  }
}

