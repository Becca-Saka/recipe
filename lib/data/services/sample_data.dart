final category = [
  'Fruits',
  'Vegetables',
  'Grains',
  'Meat & Poultry',
  'Seafood',
  'Dairy & Eggs',
  'Herbs & Spices',
  'Oils & Vinegars',
  'Nuts & Seeds',
  'Sweeteners',
  'Condiments & Sauces',
  'Beverages',
  'Baking Ingredients',
  'Canned Goods',
  'Frozen Foods',
  'Snacks',
  'Ethnic Ingredients',
  'Gluten-Free',
  'Organic',
  'Vegan & Vegetarian',
  'Low-Carb',
  'Superfoods',
  'Fermented Foods',
  'Natural Flavorings',
  'Flavor Enhancers',
  'Preservatives',
  'Colorings & Dyes',
  'Emulsifiers & Thickeners',
  'Texturizers',
  'Antioxidants',
  'Fortified Foods',
  'Seasonal Ingredients',
  'Specialty Items'
];

final recipeResp = {
  "recipes": [
    {
      "name": "Scrambled Eggs",
      "cooktime": "15 minutes",
      "description": "A quick and easy breakfast .",
      "imageUrl": "https://www.bbcgoodfood.com/recipes/scrambled-eggs",
      "instructions":
          "1. Crack the eggs into a bowl and whisk until smooth.\n2. Heat a nonstick skillet over medium heat and add the eggs.",
      "tips":
          "For a creamier scramble, add a splash of milk or cream to the eggs before cooking.",
      "ingredients": [
        {
          "name": "eggs",
          "quantity": 3,
          'category': 'Dairy & Eggs',
        },
        {
          "name": "salt",
          "quantity": "dash",
        },
      ]
    },
    {
      "name": "Fried Eggs",
      "cooktime": "10 minutes",
      "description": "A classic breakfast that is sure to please everyone.",
      "imageUrl": "https://www.bbcgoodfood.com/recipes/fried-eggs",
      "instructions":
          "1. Heat a nonstick skillet over medium heat and add the oil.\n2. Crack the eggs into the skillet and cook until the whites are set and the yolks are still runny.",
      "tips":
          "For a sunny-side up egg, cook it for 2-3 minutes per side. For an over-easy egg, cook it for 3-4 minutes per side.",
      "ingredients": [
        {
          "name": "oil",
          "quantity": 1,
          "unit": "tablespoon",
        },
        {
          "name": "salt",
          "quantity": "dash",
        },
      ]
    },
  ]
};
