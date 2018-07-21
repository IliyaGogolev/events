import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:event2go/firebase_auth_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class SendPhoneNumberUseCase{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;

  Future<String> _message = new Future<String>.value('');


  Future<void> testVerifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted = (FirebaseUser user) {
      _message = Future<String>.value('signInWithPhoneNumber succeeded: $user');
      print("verificationCompleted");
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      _message = Future<String>.value('Phone numbber verification failed. Code: ${authException.code}. Message: ${authException.message}');
      print("verificationFailed");
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("codeSent");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      this.verificationId = verificationId;
      print("codeAutoRetrievalTimeout");
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 0),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> sendCode(String verificationId, String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithPhoneNumber succeeded: $user';
  }
}