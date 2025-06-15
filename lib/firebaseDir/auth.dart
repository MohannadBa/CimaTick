import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Method to get current user from database
  User? get currentUser => auth.currentUser;

  //Method to listen to authentication state changes (e.g., login/logout)
  Stream<User?> get authStateChanges => auth.authStateChanges();

  //Method to let the user signIn with Email And Password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  //Method to let the user SignUp with Email And Password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  //Method to let the user SignOut
  Future<void> signOut() async {
    await auth.signOut();
  }
}
