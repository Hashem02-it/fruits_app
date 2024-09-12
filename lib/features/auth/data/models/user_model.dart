import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';

class UserModel extends UserEntitiy {
  UserModel({required super.name, required super.email, required super.uID});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
        name: user.displayName ?? '', email: user.email ?? '', uID: user.uid);
  }
}
