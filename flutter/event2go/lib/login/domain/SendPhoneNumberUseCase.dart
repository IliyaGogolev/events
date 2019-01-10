import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:event2go/login/data/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:event2go/firebase_auth_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event2go/data/user.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class SendPhoneNumberUseCase{


  SendPhoneNumberUseCase({@required this.user, @required this.signUpModel}) :
        assert(user != null),
        assert(signUpModel != null);

  final SignUpModel signUpModel;
  final User user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _message = new Future<String>.value('');


  void testVerifyPhoneNumber(String phoneNumber, Function func) async {

    final PhoneVerificationCompleted verificationCompleted = (FirebaseUser user) async {
      _message = Future<String>.value('signInWithPhoneNumber succeeded: $user');
      print("verificationCompleted");

      String token = await user.getIdToken();
      updateAppUser(user,token);
      func();
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      _message = Future<String>.value('Phone numbber verification failed. Code: ${authException.code}. Message: ${authException.message}');
      print("verificationFailed");
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      signUpModel.verificationId = verificationId;
      print ("verificationId (codeSent) " + verificationId);
      print("codeSent");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      signUpModel.verificationId = verificationId;
      print("codeAutoRetrievalTimeout ");
      print ("verificationId (codeAutoRetrievalTimeout) " + verificationId);
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

  Future<bool> sendCode(String verificationId, String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String token = await user.getIdToken();
    updateAppUser(currentUser,token);

//    return 'signInWithPhoneNumber succeeded: $user';
    return user.uid == currentUser.uid;
  }

  void updateAppUser(FirebaseUser user, String token)  {
    print ('updateAppUser:' );
    print ("token " + token);
    print ("uid " + user.uid);
    print ("phone # " + user.phoneNumber);
    print ("isEmailVerified $user.isEmailVerified"); // false
    print ("*****");

    this.user.uid = user.uid;
    this.user.token = token;
    this.user.phoneNumber = user.phoneNumber;
  }

}