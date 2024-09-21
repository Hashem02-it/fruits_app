import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failures.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntitiy>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failure, UserEntitiy>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, UserEntitiy>> signInWithGoogle();

  Future<Either<Failure, UserEntitiy>> signInWithFacebook();
  Future<Either<Failure, UserEntitiy>> SignInWithApple();
}
