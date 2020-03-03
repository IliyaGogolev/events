import 'dart:async';

import 'package:event2go/features/login/domain/login_repository.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  LoginUseCase({@required this.loginRepository})
      : assert(loginRepository != null);

  LoginRepository loginRepository;

  void testVerifyPhoneNumber(String phoneNumber, Function func) async {
    loginRepository.testVerifyPhoneNumber(phoneNumber, func);
  }

  Future<bool> sendCode(String verificationId, String smsCode) async {
    loginRepository.sendCode(verificationId, smsCode);
  }
}
