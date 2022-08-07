import 'dart:async';

import 'package:event2go/features/login/domain/login_repository.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  LoginUseCase({required this.loginRepository});

  LoginRepository loginRepository;

  void testVerifyPhoneNumber(String phoneNumber, Function func) async {
    return loginRepository.testVerifyPhoneNumber(phoneNumber, func);
  }

  Future<bool?> sendCode(String verificationId, String smsCode) async {
    return loginRepository.sendCode(verificationId, smsCode);
  }
}
