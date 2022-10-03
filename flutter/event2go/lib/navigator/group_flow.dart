import 'package:event2go/features/addevent/add_event_widget.dart';
import 'package:event2go/features/contacts/bloc/contacts_bloc.dart';
import 'package:event2go/features/contacts/contacts_selection_widget.dart';
import 'package:event2go/features/group/bloc/group_bloc.dart';
import 'package:event2go/features/group/group_widget.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models/contact.dart';
import 'package:models/models/group.dart';

const routeGroupSetupPrefix = '/group/';
const routeGroupSetupStart = '/group/$routeGroupSelectContactsPage';
// const load = 'load';
const routeGroupSelectContactsPage = 'select_contacts';
const routeGroupProfilePage = 'profile';

void navigateToCreateGroupWidget(BuildContext context) {
  Navigator.of(context).pushNamed(routeGroupSetupStart);
}

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

  void _onInitialized() {
    _navigatorKey.currentState!.pushNamed(routeGroupSelectContactsPage);
  }

  void _onContactsSelected(List<Contact> contacts) {
    _navigatorKey.currentState!.pushNamed(routeGroupProfilePage, arguments: contacts);
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  void _exitGroup(String? groupId, bool newGroupCreated) {
    Navigator.of(context).pop();
    if (newGroupCreated) {
      Navigator.of(context).pushNamed(AddEventWidget.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: _isExitDesired,
      // child:
    Scaffold(
        // appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialPageRoute,
          onGenerateRoute: onGenerateRoute,
        ),
      );
    // );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left), onPressed: () {  },
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeGroupSelectContactsPage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (_) => ContactsBloc(),
                child: ContactsSelectionWidget(onContactsSelected: _onContactsSelected, onBackPressed: _pop )));

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
