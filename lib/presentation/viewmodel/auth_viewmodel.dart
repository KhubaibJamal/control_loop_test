import 'package:flutter/material.dart';
import 'package:control_loop_test/data/repositories/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  AuthRepository authRepository = AuthRepository();

  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return authRepository.signInWithEmailAndPassword(email, password);
  }
}
