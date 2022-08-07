import 'package:event2go/data/user.dart';

class LoginRepository{

  String? get token => null;

  void testVerifyPhoneNumber(String phoneNumber, Function func) async {}
  Future<bool?> sendCode(String verificationId, String smsCode) async {
    return null;
  }

  void updateAppUser(MyUser user) {}

}
