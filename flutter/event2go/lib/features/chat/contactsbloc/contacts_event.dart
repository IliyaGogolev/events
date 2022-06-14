part of 'contacts_bloc.dart';

@immutable
abstract class ContactsEvent extends Equatable {
  const ContactsEvent();
}

class ContactsLoadedEvent extends ContactsEvent {
  const ContactsLoadedEvent({@required this.contacts});

  final List<Contact> contacts;

  @override
  List<Object> get props => [contacts];

  @override
  String toString() => 'ContactsLoaded { contacts size: ${contacts.length} }';
}

class ContactSelectedEvent extends ContactsEvent {
  const ContactSelectedEvent({@required this.contact, @required this.selected});

  final Contact contact;
  final bool selected;

  @override
  List<Object> get props => [contact, selected];

  @override
  String toString() => 'Contact selected { contacts: $contact, selected $selected }';
}

