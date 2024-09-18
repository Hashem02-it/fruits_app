import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failures.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntitiy>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failure, UserEntitiy>> signInWithEmailAndPassword(
      String email, String password);
}
