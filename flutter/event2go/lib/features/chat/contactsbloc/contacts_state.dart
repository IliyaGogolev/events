part of 'contacts_bloc.dart';

@immutable
abstract class ContactsState extends Equatable {
  const ContactsState();
}

class ContactsStateInitial extends ContactsState {

  @override
  List<Object> get props => [];
}

class ContactsStateLoaded extends ContactsState {
  const ContactsStateLoaded(this.contacts, this.selectedContacts);

  final List<Contact> contacts;
  final List<Contact> selectedContacts;

  @override
  List<Object> get props => [contacts, selectedContacts];

  @override
  String toString() => 'ContactsStateLoaded { contacts [${contacts.length}], '
      'selected [${selectedContacts.length}] }';
}

class ContactsSelected extends ContactsState {
  const ContactsSelected(this.contact, this.selected);

  final Contact contact;
  final bool selected;

  @override
  List<Object> get props => [contact, selected];

}

//
// class MyContact extends Equatable {
//   MyContact(this.name);
//
//   String name;
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [name];
// }
