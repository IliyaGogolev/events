import 'package:event2go/features/contacts/bloc/contacts_bloc.dart';
import 'package:event2go/features/contacts/contacts_selection_widget.dart';
import 'package:event2go/features/group/bloc/group_bloc.dart';
import 'package:event2go/features/group/group_widget.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

const routeGroupSetupPrefix = 'group';
const routeGroupSetupStart = '/group/$routeGroupSelectContactsPage';
const routeGroupSelectContactsPage = 'select_contacts';
const routeGroupProfilePage = 'profile';

@immutable
class GroupFlow extends StatefulWidget {
  static GroupFlowState? of(BuildContext context) {
    return context.findAncestorStateOfType<GroupFlowState>();
  }

  const GroupFlow({
    required this.initialPageRoute,
  });

  final String initialPageRoute;

  @override
  GroupFlowState createState() => GroupFlowState();
}

class GroupFlowState extends State<GroupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void _onContactsSelected(List<Contact> contacts) {
    _navigatorKey.currentState!.pushNamed(routeGroupProfilePage, arguments: contacts);
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitGroup(Object? data) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        // appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialPageRoute,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeGroupSelectContactsPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (_) => ContactsBloc(),
                child: ContactsSelectionWidget(onContactsSelected: _onContactsSelected)));

      case routeGroupProfilePage:
        List<Contact> contacts = settings.arguments as List<Contact>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => GroupBloc(
                    group: Group(contacts: contacts, title: ''),
                    groupsRepository: context.read<RepositoriesProvider>().groupsRepository),
                child: GroupWidget(finish: _exitGroup)));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
