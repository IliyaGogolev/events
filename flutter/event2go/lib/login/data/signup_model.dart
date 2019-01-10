import 'package:flutter/widgets.dart';

class SignUpModel extends InheritedModel<String> {

  SignUpModel({@required Widget child}) : super(child: child);

  String verificationId;

  @override
  bool updateShouldNotify(SignUpModel old) => false;

//    return user.token.compareTo(old.user.token) != 0

  @override
  bool updateShouldNotifyDependent(SignUpModel old, Set<String> aspects) =>
      false;

//    return (user.token != old.user.token && aspects.contains('user'));
//  }

  static SignUpModel of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(SignUpModel);
}
