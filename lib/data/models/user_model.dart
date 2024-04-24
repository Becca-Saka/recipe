class UserModel {
  String uid;
  String? email;
  String? name;
  String? imageUrl;

  bool promotions;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageUrl,
    this.promotions = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'promotions': promotions
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String?,
      name: map['name'] as String?,
      imageUrl: map['imageUrl'] as String?,
      promotions: map['promotions'] ?? true,
    );
  }
}
