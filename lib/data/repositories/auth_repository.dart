import 'package:control_loop_test/data/service/firebase/firebase_auth_service.dart';
import 'package:control_loop_test/data/service/firebase/firebase_media_service.dart';

class AuthRepository {
  final FirebaseAuthService authService = FirebaseAuthService();
  final FirebaseMediaService mediaService = FirebaseMediaService();

  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await authService.signInWithEmailAndPassword(email, password);
  }
}
