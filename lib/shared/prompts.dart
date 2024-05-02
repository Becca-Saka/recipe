import 'dart:convert';

import 'package:recipe/shared/sample_data.dart';

class Prompts {
  Prompts._();
  static final String ingredientExtractionPrompt =
      """Your role is to collect the ingredients and quantity information and categorize them based  on this list $category, and return it in a json format that looks like this
      {
        "ingredients": [
          {
            "name": "eggs",
            "quantity": 3, 
            "category": "Dairy & Eggs",
          },{
            "name": "flour",
            "quantity": 0.6, 
            "category": "Baking Ingredients",
          
          },
           ...
        ]
      }

      NOTE: 
        1. If there is no "unit" value provided, take initiative and add an approprite unit for the ingredient.
        2. If you cant determine the unit skip the field
        3. "quantity" should either be a double or a int
        4. return just the json, not quotations
        5. if there are items that appear multiple times, merge them into compute the responses.



      """;

  static final String recipeExtractionPrompt = """
Your role is to collect the list of ingredients and quantity information and return a list of recipes that can be made with the available ingredient keeping the quntity in mind;
      
      Here are the guideline you must follow:
      1. Your response should Only ever be a JSON (in json format) nothing else that looks like this:   ${jsonEncode(recipeResp)}
      2. If there is no "unit" value provided, take initiative and add an approprite unit for the ingredient.
      3. If you cant determine the unit skip the field
      4. "quantity" should either be a double or a int
      5. Only return me a JSON ( the json must be readable when parsed by Dart )
      6. return multiline strings with just one begining and end quotes
      """;
  static const String recipeExtractionPrompt2 = """
Before you give me back a response, validate it. Your response must fullfill these conditions:
 
 1. It must be a JSON
 2. No other information must trail or come before the JSON
 3. It must fulfill all above conditions
 4. To ensure that it is actually a JSON, it must start and end with a Curly Brace
 5. The JSON must be complete, You must not stop in the middle. It must be a full JSON
 6. If the JSON will be too long, If the content limit is going to be passed , reduce the number of recipes
 7. All your quotation marks, brackets are complete, if you start a quotation mark, you must stop it at the end of the string
 8. ALl fractions should be turned to decimals
 9. All imageUrl field must return a valid image.
      """;
}
