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
  final List<Ingredient> ingredients;

  Recipe({required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<dynamic> ingredientsJson = json['ingredients'];
    List<Ingredient> ingredients = ingredientsJson
        .map((ingredientJson) => Ingredient.fromJson(ingredientJson))
        .toList();

    return Recipe(ingredients: ingredients);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> ingredientsJson =
        ingredients.map((ingredient) => ingredient.toJson()).toList();

    return {'ingredients': ingredientsJson};
  }
}
