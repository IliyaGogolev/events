import 'package:dio/dio.dart';
import 'package:event2go/app_provider_container.dart';
import 'package:event2go/event2go_app.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:event2go/network/mock/mock_interceptor.dart';
import 'package:event2go/network/network_client.dart';
import 'package:event2go/network/services/groups_service.dart';
import 'package:event2go/repositories/groups_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';

import 'config/config.dart';

Future<void> main() async  {
  var configuredApp = Config(
    appDisplayName: "Event2Go",
    child: myApp(),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(configuredApp);
}

myApp() {
  NetworkClient network = NetworkClient(Dio());
  network.addInterceptor(MockInterceptor());
  return new AppProviderWidget(
    child: new Event2GoApp(repositoriesProvider: RepositoriesProvider(
        groupsRepository: GroupsRepositoryImp(groupsService: GroupsService(networkClient: network))
    )),
  );
}
