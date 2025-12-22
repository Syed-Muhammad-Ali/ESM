import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> reauthenticate(String email, String password) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
  }

  Future<void> deleteAuthAccount() async {
    await _auth.currentUser?.delete();
  }

  String get uid => _auth.currentUser?.uid ?? '';
  String? get email => _auth.currentUser?.email;
}
