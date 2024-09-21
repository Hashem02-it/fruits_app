import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/failures.dart';
import 'package:fruits_app/core/services/firebase_auth_service.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImplementation({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntitiy>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
          email, password);
      return Right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما، الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user =
          await firebaseAuthService.signInWithEmailAndPassword(email, password);
      return Right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما، الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithGoogle() async {
    try {
      var user = await firebaseAuthService.signInWithGoogle();
      return Right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithFacebook() async {
    try {
      var user = await firebaseAuthService.signInWithFacebook();
      return Right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> SignInWithApple() async {
    try {
      var user = await firebaseAuthService.signInWithApple();
      return Right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }
}
