part of 'contacts_bloc.dart';

@immutable
abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsStateInitial extends ContactsState {}

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
