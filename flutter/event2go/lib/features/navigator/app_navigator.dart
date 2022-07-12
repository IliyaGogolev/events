import 'package:event2go/features/contacts/bloc/contacts_bloc.dart';
import 'package:event2go/features/contacts/contacts_selection_widget.dart';
import 'package:event2go/features/group/group_widget.dart';
import 'package:event2go/features/group/viewmodel/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

void navigateToSelectContactsWidget(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => BlocProvider(create: (_) => ContactsBloc(), child: ContactsSelectionWidget())),
  );
}

void navigateToCreateGroupWidget(BuildContext context, List<Contact> contacts) {
  Navigator.push(
    context,
    MaterialPageRoute(
      // builder: (context) => BlocProvider.value(value: _contactsBloc, child: GroupWidget())
        builder: (context) => BlocProvider(create: (_) => GroupBloc(Group(contacts: contacts)), child: GroupWidget())),
  );
}

void navigateToGroupWidget(BuildContext context, Group group) {
  Navigator.push(
    context,
    MaterialPageRoute(
        // builder: (context) => BlocProvider.value(value: _contactsBloc, child: GroupWidget())
        builder: (context) => BlocProvider(create: (_) => GroupBloc(group), child: GroupWidget())),
    );
}