import 'package:equatable/equatable.dart';
import 'package:models/models/contact.dart';

class Group extends Equatable {

  String? id;
  String title;
  List<Contact> contacts;

  Group({this.id, required this.title, required this.contacts});

  @override
  List<Object?> get props => [title, contacts];

  Group.fromJson(Map<String, dynamic> json, this.title, this.contacts) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}
