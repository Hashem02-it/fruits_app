import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/failures.dart';
import 'package:fruits_app/core/services/database_serivce.dart';
import 'package:fruits_app/core/services/firebase_auth_service.dart';
import 'package:fruits_app/core/services/shared_prefences_singleton.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  AuthRepoImplementation({required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntitiy>> createUserWithEmailAndPassword(String email, String password, String name, String role) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(email, password);

      var userEntity = UserEntitiy(name: name, email: email, uID: user.uid, role: role);
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
  Future<Either<Failure, UserEntitiy>> signInWithEmailAndPassword(String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(email, password);

      try {
        var userEntity = await getUserData(uID: user.uid);
        return Right(userEntity);
      } on CustomException catch (_) {
        // User exists in Auth but not in Firestore - create their record
        var newUser =
            UserEntitiy(name: user.displayName ?? 'New User', email: user.email ?? email, uID: user.uid, role: 'user' // default role
                );
        await addUserData(user: newUser);
        return Right(newUser);
      }
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntitiy>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var useEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(path: BackendEndpoints.isUserExists, documentId: user.uid);
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
      var isUserExist = await databaseService.checkIfDataExists(path: BackendEndpoints.isUserExists, documentId: user.uid);
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
    databaseService.addData(path: BackendEndpoints.addUserData, data: UserModel.fromEntity(user).toMap());
  }

  @override
  Future<UserEntitiy> getUserData({required String uID}) async {
    try {
      log('Fetching user data for UID: $uID');
      var userData = await databaseService.getData(path: 'users', documentId: uID);

      // Proper null and empty check
      if (userData == null || userData.isEmpty) {
        log('No user data found for UID: $uID');
        throw CustomException(message: 'User data not found');
      }

      // Safe casting
      final userMap = userData as Map<String, dynamic>? ?? {};

      log('User data retrieved: $userMap');
      return UserModel.fromJson(userMap);
    } catch (e) {
      log('Error retrieving user data: ${e.toString()}');
      throw CustomException(message: 'Failed to fetch user data');
    }
  }

  @override
  Future saveUserData({required UserEntitiy user}) async {
    var jasonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jasonData);
  }
}
