// raw
import 'contact.dart';

class Group {

  String title;
  List<Contact> contacts;

  Group({this.title});

  Group.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    contacts = json['contacts'].map<Contact>((c) => Contact.fromJson(c)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['contacts'] = contacts;
    return data;
  }
}
