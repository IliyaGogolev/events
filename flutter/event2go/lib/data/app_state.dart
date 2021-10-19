import 'package:event2go/data/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final MyUser user;

  AppState(this.user);

  bool isLoggedIn() {
    
    print(user.token);
    return user.token.isNotEmpty;
  }
}
