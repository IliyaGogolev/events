import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage>{

  Contact contact = new Contact();
  PostalAddress address = new PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add a contact"),
        actions: <Widget>[
          new FlatButton(
              onPressed: (){
                _formKey.currentState?.save();
                contact.postalAddresses = [address];
                ContactsService.addContact(contact);
                Navigator.of(context).pop();
              },
              child: new Icon(Icons.save, color: Colors.white)
          )
        ],
      ),
      body: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Form(
            key: _formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(decoration: const InputDecoration(labelText: 'First name'), onSaved: (v) => contact.givenName = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Middle name'), onSaved: (v) => contact.middleName = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Last name'), onSaved: (v) => contact.familyName = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Prefix'), onSaved: (v) => contact.prefix = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Suffix'), onSaved: (v) => contact.suffix = v),
                new TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    onSaved: (v) => contact.phones = [new Item(label: "mobile", value: v)],
                    keyboardType: TextInputType.phone
                ),
                new TextFormField(
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    onSaved: (v) => contact.emails = [new Item(label: "work", value: v)],
                    keyboardType: TextInputType.emailAddress
                ),
                new TextFormField(decoration: const InputDecoration(labelText: 'Company'), onSaved: (v) => contact.company = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Job'), onSaved: (v) => contact.jobTitle = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Street'), onSaved: (v) => address.street = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'City'), onSaved: (v) => address.city = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Region'), onSaved: (v) => address.region = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Postal code'), onSaved: (v) => address.postcode = v),
                new TextFormField(decoration: const InputDecoration(labelText: 'Country'), onSaved: (v) => address.country = v),
              ],
            )
        ),
      ),
    );
  }
}