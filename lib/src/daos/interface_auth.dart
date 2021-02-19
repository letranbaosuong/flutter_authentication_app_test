abstract class IAuth {
  Stream<String> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<String> createUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<String> currentUser();
  Future<void> signOut();
  Future<String> signInWithGoogle();
  Future<String> signInWithFacebook();
}
