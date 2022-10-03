import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event2go/navigator/routes.dart';
import 'package:home/home_tabs_view.dart';
import 'config/config.dart';

class Event2GoApp extends StatelessWidget {
  const Event2GoApp({Key? key, required RepositoriesProvider repositoriesProvider})
      : _repositoriesProvider = repositoriesProvider,
        super(key: key);

  final RepositoriesProvider _repositoriesProvider;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(value: _repositoriesProvider, child: Event2GoView());
}

class Event2GoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isUserAuthorized = Config.of(context)?.isUserAuthorized ?? false;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isUserAuthorized ? HomeTabsView.tag : SIGN_IN_TAG,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
