import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecipes {
  final String id;
  final DateTime dateSuggested;
  UserRecipes({
    required this.id,
    required this.dateSuggested,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateSuggested': dateSuggested,
    };
  }

  factory UserRecipes.fromJson(Map<String, dynamic> json) {
    return UserRecipes(
      id: json['id'],
      dateSuggested:
          (json['dateSuggested'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class UserModel {
  String uid;
  String? email;
  String? name;
  String? imageUrl;

  bool promotions;
  final List<UserRecipes> recipes;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageUrl,
    this.promotions = true,
    this.recipes = const [],
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
      recipes: map['recipes'] != null
          ? List<UserRecipes>.from(
              (map['recipes'] as List<dynamic>).map<UserRecipes>(
                (x) => UserRecipes.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
