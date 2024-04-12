import 'package:recipe/shared/extensions/double.dart';
import 'package:recipe/shared/extensions/string.dart';

class Ingredient {
  final String name;
  final dynamic rawQuantity;
  final String unit;
  String get imageUrl =>
      "https://img.spoonacular.com/ingredients_100x100/${name.imagify}.jpg";
  // final String imageUrl;

  String get quantity =>
      rawQuantity is num ? (rawQuantity as num).removeDecimalZero : rawQuantity;

  Ingredient({
    required this.name,
    required this.rawQuantity,
    this.unit = '',
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      rawQuantity: json['quantity'],
      unit: json['unit'] ?? 'pcs',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }
}

class Recipe {
  final String name;
  final String cookTime;
  final String description;
  final String? imageUrl;
  final List<String> instructions;
  final String instruction;
  final String tips;
  final List<Ingredient> ingredients;

  Recipe({
    required this.name,
    required this.cookTime,
    required this.description,
    required this.instructions,
    required this.tips,
    required this.ingredients,
    required this.instruction,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'cookTime': cookTime,
      'description': description,
      'instructions': instructions.isNotEmpty ? instructions : instruction,
      'tips': tips,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'] as String,
      cookTime: map['cooktime'] as String,
      imageUrl: map['imageUrl'] as String?,
      description: map['description'] as String,
      instructions: map['instructions'] is List
          ? List<String>.from(map['instructions'])
          : [],
      instruction:
          map['instructions'] is String ? map['instructions'] as String : '',
      tips: map['tips'] as String,
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List).map<Ingredient>(
          (x) => Ingredient.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
