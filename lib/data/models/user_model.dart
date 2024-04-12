class UserModel {
  String uid;
  String? email;
  String? name;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String?,
      name: map['name'] as String?,
    );
  }
}
