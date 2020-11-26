import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

import 'AuthExceptionHandler.dart';
import 'FirebaseDocuments.dart';
import 'Home.dart';
import 'InitMyLocation.dart';
import 'LoginPage.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class LoginAll {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  AuthResultStatus _status;

  Future<AuthResultStatus> authLogin({email, pass, context}) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
      /*Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Falha no login")));*/
      Toast.show("Ops. Flaha no login:${e.hashCode}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      print("${e.hashCode}");
    }
    return _status;
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    print("email: $email senha: $password");
    final status =
        await authLogin(email: email, pass: password, context: context)
            .catchError((onError) {
      print(onError);
    });
    if (status == AuthResultStatus.successful) {
      print("login");
      InitMyLocation().myLocation();
      FirebaseDocuments().loginRoute(context);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      print(errorMsg);
    }
  }

  void loginGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print("Google User: ${googleUser.email} ${googleUser.id}");

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);
    final User fUser = result.user;
    print("Firebase Nome: ${fUser.displayName}");
    print("Firebase Email: ${fUser.email}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
