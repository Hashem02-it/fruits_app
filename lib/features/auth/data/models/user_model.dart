import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';

class UserModel extends UserEntitiy {
  UserModel({
    required super.name,
    required super.email,
    required super.uID,
    required super.role,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uID: user.uid,
      role: '',
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uID: json['uID'],
      role: json['role'], // ➕ Add this line
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uID': uID,
      'role': role,
    };
  }

  factory UserModel.fromEntity(UserEntitiy entity) {
    return UserModel(
      name: entity.name,
      email: entity.email,
      uID: entity.uID,
      role: entity.role, // ➕ Add this line
    );
  }
}
