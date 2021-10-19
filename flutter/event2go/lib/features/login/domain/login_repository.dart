import 'package:event2go/data/user.dart';

class LoginRepository{

  String get token => null;

  void testVerifyPhoneNumber(String phoneNumber, Function func) async {}
  Future<bool> sendCode(String verificationId, String smsCode) async {}

  void updateAppUser(MyUser user) {}

}
