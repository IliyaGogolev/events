import 'package:flutter/widgets.dart';
import 'package:event2go/data/user.dart';

class AppProvider extends InheritedModel<String> {

  AppProvider({
    @required Widget child,
    this.user = const User()
  }) : assert(child != null),
        assert(user != null),
        super(child: child);

  final User user;

  @override
  bool updateShouldNotify(AppProvider old) => false;

//    return user.token.compareTo(old.user.token) != 0

  @override
  bool updateShouldNotifyDependent(AppProvider old, Set<String> aspects) => false;
//    return (user.token != old.user.token && aspects.contains('user'));
//  }

  static AppProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(AppProvider);

}
