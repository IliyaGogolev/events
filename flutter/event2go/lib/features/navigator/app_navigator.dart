import 'package:event2go/features/contacts/bloc/contacts_bloc.dart';
import 'package:event2go/features/contacts/contacts_selection_widget.dart';
import 'package:event2go/features/group/group_widget.dart';
import 'package:event2go/features/group/bloc/group_bloc.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

void navigateToSelectContactsWidget(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => BlocProvider(create: (_) => ContactsBloc(),
            child: ContactsSelectionWidget())),
  );
}

void navigateToCreateGroupWidget(BuildContext context, List<Contact> contacts) {
  RepositoriesProvider repo = context.read<RepositoriesProvider>();
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => BlocProvider(create: (context) => GroupBloc(
            group: Group(contacts: contacts, title: ''),
            groupsRepository:  repo.groupsRepository
        ), child: GroupWidget())),
  );
}

void navigateToGroupWidget(BuildContext context, Group group) {
  RepositoriesProvider repo = context.read<RepositoriesProvider>();
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => BlocProvider(create: (_) => GroupBloc(
            group: group,
            groupsRepository:  repo.groupsRepository
        ), child: GroupWidget())
    ));
}

void navigatePopToRouteName(BuildContext context, String routeName) {
  Navigator.popUntil(context, ModalRoute.withName(routeName));
}