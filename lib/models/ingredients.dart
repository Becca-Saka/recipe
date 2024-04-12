// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ingredient {
  final String name;
  final double quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    this.unit = '',
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'].toDouble(),
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
  final List<String> instructions;
  final String tips;
  final List<Ingredient> ingredients;

  Recipe({
    required this.name,
    required this.cookTime,
    required this.description,
    required this.instructions,
    required this.tips,
    required this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'cookTime': cookTime,
      'description': description,
      'instructions': instructions,
      'tips': tips,
      'ingredients': ingredients.map((x) => x.toJson()).toList(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'] as String,
      cookTime: map['cooktime'] as String,
      description: map['description'] as String,
      instructions: List<String>.from(map['instructions']),
      tips: map['tips'] as String,
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List).map<Ingredient>(
          (x) => Ingredient.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
