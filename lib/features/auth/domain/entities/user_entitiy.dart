class UserEntitiy {
  final String name;
  final String email;
  final String uID;

  UserEntitiy({
    required this.name,
    required this.email,
    required this.uID,
  });

  toMap() {
    return {
      'name': name,
      'email': email,
      'uID': uID,
    };
  }
}
