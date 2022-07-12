import 'package:event2go/app_provider_container.dart';
import 'package:event2go/event2go_app.dart';
import 'package:event2go/features/repositories/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // runApp(new Event2GoApp());
  runApp(new AppProviderWidget(
    child: new Event2GoApp(repositoriesProvider: RepositoriesProvider()),
  ));

}
