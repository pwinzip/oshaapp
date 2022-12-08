import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<User?> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        print('The account already exists for tha email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "user-not-found") {
        print('No user found for that email.');
      } else if (e.code == "wrong-password") {
        print("Wrong password provided.");
      }
    }

    return user;
  }
}
