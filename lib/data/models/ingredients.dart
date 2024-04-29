import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe/shared/extensions/num.dart';

class Ingredient {
  final String name;
  final dynamic rawQuantity;
  final String unit;
  final String category;
  String imageUrl;
  // String get imageUrl => "https://loremflickr.com/320/240/${name.imagify}";
  // String get imageUrl =>
  //     "http://127.0.0.1:5001/pixfork-a4f4d/us-central1/helloWorld?category=$category";
  // String get imageUrl =>
  //     "https://img.spoonacular.com/ingredients_100x100/${name.imagify}.jpg";

  // final String imageUrl;
// https://loremflickr.com/320/240/dog
  String get quantity =>
      rawQuantity is num ? (rawQuantity as num).removeDecimalZero : rawQuantity;

  Ingredient({
    required this.name,
    required this.rawQuantity,
    required this.category,
    this.unit = '',
    this.imageUrl = '',
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      rawQuantity: json['quantity'] ?? '1',
      unit: json['unit'] ?? 'pcs',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'category': category,
    };
  }
}

class CreatorModel {
  final String id;
  final String name;
  final String? imageUrl;

  CreatorModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) {
    return CreatorModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}

class Recipe {
  String? id;
  final String name;
  final String cookTime;
  final String description;
  String? imageUrl;
  final List<String> instructions;
  final String instruction;
  final String tips;
  final List<Ingredient> ingredients;
  DateTime? dateSuggested;
  List<CreatorModel> creators;
  bool get isLocal => creators.isEmpty;

  Recipe({
    required this.id,
    required this.name,
    required this.cookTime,
    required this.description,
    required this.instructions,
    required this.tips,
    required this.ingredients,
    required this.instruction,
    required this.imageUrl,
    required this.dateSuggested,
    required this.creators,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cooktime': cookTime,
      'description': description,
      'instructions': instructions.isNotEmpty ? instructions : instruction,
      'tips': tips,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
      'imageUrl': imageUrl,
      'creators': creators.map((x) => x.toJson()).toList(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String?,
      name: map['name'] as String,
      cookTime: map['cooktime']?.toString() ?? '',
      imageUrl: map['imageUrl'] as String?,
      description: map['description'] as String,
      dateSuggested: (map['dateSuggested'] as Timestamp?)?.toDate(),
      instructions: map['instructions'] is List
          ? List<String>.from(map['instructions'])
          : [],
      instruction:
          map['instructions'] is String ? map['instructions'] as String : '',
      tips: (map['tips'] is List)
          ? (map['tips'] as List).join('\n')
          : map['tips'] != null
              ? map['tips'] as String
              : '',
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              (map['ingredients'] as List).map<Ingredient>(
                (x) => Ingredient.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
      creators: map['creators'] != null
          ? List<CreatorModel>.from(
              (map['creators'] as List).map<CreatorModel>(
                (x) => CreatorModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
