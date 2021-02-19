import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_with_flutter/src/daos/interface_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Auth implements IAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        .uid;
  }

  @override
  Future<String> currentUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  @override
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _auth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _auth.idToken,
      accessToken: _auth.accessToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        .uid;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookLogin.logOut();
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> signInWithFacebook() async {
    final result = await _facebookLogin.logInWithReadPermissions(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}
