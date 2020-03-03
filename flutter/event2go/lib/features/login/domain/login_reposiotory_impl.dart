import 'package:event2go/data/user.dart';
import 'package:event2go/features/login/data/signup_model.dart';
import 'package:event2go/features/login/domain/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({@required this.user, @required this.signUpModel})
      : assert(user != null),
        assert(signUpModel != null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> _message = new Future<String>.value('');
  User user;
  final SignUpModel signUpModel;

  @override
  Future<bool> sendCode(String verificationId, String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String token = await user.getIdToken();
    updateAppUser(currentUser.toUser(token));

//    return 'signInWithPhoneNumber succeeded: $user';
    return user.uid == currentUser.uid;
  }

  @override
  Future<void> testVerifyPhoneNumber(String phoneNumber, Function func) async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) async {
      _message = Future<String>.value('signInWithPhoneNumber succeeded: $user');
      print("verificationCompleted");

      String token = await user.getIdToken();
      updateAppUser(user.toUser(token));
      func();
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      _message = Future<String>.value(
          'Phone numbber verification failed. Code: ${authException.code}. Message: ${authException.message}');
      print("verificationFailed");
      _message.then((str) => print(str));
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      signUpModel.verificationId = verificationId;
      print("verificationId (codeSent) " + verificationId);
      print("codeSent");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      signUpModel.verificationId = verificationId;
      print("codeAutoRetrievalTimeout ");
      print("verificationId (codeAutoRetrievalTimeout) " + verificationId);
    };

    print("verifyPhoneNumber start ");
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 0),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

    print("verifyPhoneNumber end ");
  }

  @override
  void updateAppUser(User user) {
    print('updateAppUser:');
    print("token " + user.token);
    print("uid " + user.uid);
    print("phone # " + user.phoneNumber);
    print("email ${user.email}");
    print("*****");

    this.user = user;
  }

  @override
  get token => user.token;
}

extension on FirebaseUser {
  User toUser(String token) {
    return new User(
        uid: this.uid,
        token: token,
        phoneNumber: this.phoneNumber,
        email: this.email);
  }
}
