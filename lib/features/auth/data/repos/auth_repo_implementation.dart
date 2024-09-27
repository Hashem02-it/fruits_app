import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/failures.dart';
import 'package:fruits_app/core/services/database_serivce.dart';
import 'package:fruits_app/core/services/firebase_auth_service.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  AuthRepoImplementation(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntitiy>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email, password);

      var userEntity = UserEntitiy(name: name, email: email, uID: user.uid);
      await addUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await user.delete();
      }
      return left(ServerFailure(e.message));
    } catch (e) {
      await daleteUser(user);
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما، الرجاء المحاولة لاحقاً'));
    }
  }

  Future<void> daleteUser(User? user) async {
    if (user != null) {
      await user.delete();
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user =
          await firebaseAuthService.signInWithEmailAndPassword(email, password);
      var userEntity = await getUserData(uID: user.uid);
      return Right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما، الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var useEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoints.isUserExists, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uID: user.uid);
      } else {
        await addUserData(user: useEntity);
      }

      return Right(useEntity);
    } catch (e) {
      await daleteUser(user);
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithFacebook() async {
    User? user;
    try {
      var user = await firebaseAuthService.signInWithFacebook();
      var useEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoints.isUserExists, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uID: user.uid);
      } else {
        await addUserData(user: useEntity);
      }

      return Right(useEntity);
    } catch (e) {
      await daleteUser(user);
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> SignInWithApple() async {
    User? user;
    try {
      var user = await firebaseAuthService.signInWithApple();
      var useEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: useEntity);
      return Right(useEntity);
    } catch (e) {
      await daleteUser(user);
      log('Exeption in auth repo implementation ${e.toString()}');
      return left(ServerFailure('لقد حدث خطأ ما الرجاء المحاولة لاحقاً'));
    }
  }

  @override
  Future addUserData({required UserEntitiy user}) async {
    databaseService.addData(
        path: BackendEndpoints.addUserData,
        data: user.toMap(),
        documentId: user.uID);
  }

  @override
  Future<UserEntitiy> getUserData({required String uID}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoints.getUserData, documentId: uID);
    return UserModel.fromJson(userData);
  }
}
