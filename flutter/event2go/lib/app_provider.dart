import 'package:flutter/widgets.dart';
import 'package:event2go/data/user.dart';

class AppModel extends InheritedModel<String> {

  AppModel({
    required Widget child,
    required this.user
  }) : super(child: child);

  final MyUser user;

  @override
  bool updateShouldNotify(AppModel old) => false;

//    return user.token.compareTo(old.user.token) != 0

  @override
  bool updateShouldNotifyDependent(AppModel old, Set<String> aspects) => false;
//    return (user.token != old.user.token && aspects.contains('user'));
//  }

  static AppModel? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppModel>();

}
