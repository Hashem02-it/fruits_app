import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exeption in firebase auth service ${e.toString()}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'ضع كلمة مرور قوية');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'لديك حساب بالفعل في هذا البريد الالكتروني');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'خطأ في الاتصال بالشبكة');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      log('Exeption in firebase auth service ${e.toString()}');
      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      // handle error codes here
      log('Exeption in firebase auth service ${e.toString()}');

      if (e.code == 'user-not-found') {
        throw CustomException(
            message: 'لا يوجد حساب مسجل بهذا البريد الالكتروني');
      } else if (e.code == 'wrong-password') {
        // wrong password
        throw CustomException(
            message: 'كلمة المرور او البريد الالكتروني غير صحيحة');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'خطأ في الاتصال بالشبكة');
      } else {
        throw CustomException(
            message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
      }
    } catch (e) {
      log('Exeption in firebase auth service ${e.toString()}');
      throw CustomException(message: 'لقد حدث خطأ ما، الرجاء المحاولة لاحقاً');
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }
}
