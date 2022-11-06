import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      //print('Nombre: $name, Email: $email y pass: $password');
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user!;
      user.sendEmailVerification();
      user.updateDisplayName(name);
      await user.reload();
      user = await _auth.currentUser;
      //print('usuario final es: $user');
      return true;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
