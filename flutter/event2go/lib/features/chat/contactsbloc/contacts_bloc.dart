import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];

  List<Contact> get selectedContacts => _selectedContacts;
  List<Contact> get contacts => _contacts;

  ContactsBloc() : super(ContactsStateInitial()) {
    on<ContactsLoadedEvent>(_onContactsLoadedEvent);
    on<ContactSelectedEvent>(_onContactSelectedEvent);
  }

  void _onContactsLoadedEvent(
    ContactsLoadedEvent event,
    Emitter<ContactsState> emit,
  ) async {
    _contacts = event.contacts;
    print ("_onContactsLoadedEvent ${_contacts.length} ");
    emit(ContactsStateLoaded(_contacts, _selectedContacts));
  }

  void _onContactSelectedEvent(
    ContactSelectedEvent event,
    Emitter<ContactsState> emit,
  ) async {
    if (event.selected) {
      print ("contact added ${event.contact.displayName}");
      _selectedContacts.add(event.contact);
    } else {
      _selectedContacts.remove(event.contact);
    }
    emit(ContactsSelected(event.contact, event.selected));
  }
}
