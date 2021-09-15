import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  firebase_auth.User get currentUser => firebase_auth.FirebaseAuth.instance.currentUser;
  // Future<User> signInAnonymously();
  Stream<firebase_auth.User> authStateChanges();
  Future<void> signOut();
  Future<firebase_auth.User> signInWithGoogle();
  Future<firebase_auth.User> signInWithEmailAndPassword(String email, String password);
  Future<firebase_auth.User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  @override
  Stream<firebase_auth.User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  firebase_auth.User get currentUser => firebase_auth.FirebaseAuth.instance.currentUser;

  // @override
  // Future<User> signInAnonymously() async {
  //   final userCredential = await _firebaseAuth.signInAnonymously();
  //   return userCredential.user;
  // }

  @override
  Future<firebase_auth.User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential =
        await _firebaseAuth.signInWithCredential(firebase_auth.EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return userCredential.user;
  }

  @override
  Future<firebase_auth.User> createUserWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<firebase_auth.User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(firebase_auth.GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw firebase_auth.FirebaseAuthException(
          code: "ERROR _MISSING_GOOGLE_ID_TOKEN",
          message: "Missing Google ID token",
        );
      }
    } else {
      throw firebase_auth.FirebaseAuthException(
        code: "ERROR_ABORTED_BY_USER",
        message: "Sign in aborted by user",
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSIgnIn = GoogleSignIn();
    await googleSIgnIn.signOut();
    await _firebaseAuth.signOut();
  }
}
