import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/youtube_model.dart';
import 'package:recipe/data/services/api_service.dart';
import 'package:recipe/data/services/firebase_service.dart';
import 'package:recipe/data/services/gemini_service.dart';
import 'package:recipe/data/services/parser.dart';
import 'package:recipe/data/services/speech_to_text_service.dart';
import 'package:recipe/shared/app_snackbar.dart';
import 'package:recipe/shared/custom_json_parser.dart';
import 'package:recipe/ui/confirm_ingredient_view.dart';
import 'package:recipe/ui/recipe_details_view.dart';
import 'package:recipe/ui/suggested_recipes_view.dart';
import 'package:recipe/ui/suggested_video.dart';
import 'package:recipe/ui/youtube_player.dart';

class RecipeProvider extends ChangeNotifier {
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final TextEditingController textEditingController = TextEditingController();
  final GeminiService _germiniServices = GeminiService();
  final FirebaseService _authenticationsService = FirebaseService();
  ScrollController controller = ScrollController();

  bool get isListening => _speechToTextService.isListening.value;
  bool get _loading => _germiniServices.loading.value;
  List<Ingredient> ingredientList = [];
  List<Recipe> recipeList = [];
  List<YoutubeSearchItem> youtubeData = [];
  Recipe? selectedRecipe;
  String spokenText = '';
  String resultText = '';
  int start = 0;
  int end = 0;
  bool loading = false;
  void initialize() {
    debugPrint('object');
    _initGemini();
  }

  void _initGemini() => _germiniServices.init();
  void _setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> getIngredients(context) async {
    final message = textEditingController.text;
    bool hasValidMessage = message.isNotEmpty;
    bool canSendMessage =
        hasValidMessage && _speechToTextService.isNotListening && !_loading;
    if (canSendMessage) {
      _setLoading(true);
      await _germiniServices.generateContent(
        message: message,
        onSuccess: (text) {
          resultText = text;
          _setLoading(false);
          _getIngredient(text, context);
        },
        onError: (error) {
          _setLoading(false);
          _showError(error, context);
        },
      );
    }
  }

  void _getIngredient(String text, BuildContext context) {
    final jsonconverted = _extractJson(text);
    if (jsonconverted != null) {
      final convertedList = jsonconverted['ingredients'] as List<dynamic>;
      if (convertedList.isNotEmpty) {
        ingredientList = convertedList
            .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
        // textEditingController.clear();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ConfirmIngredientView()));
      } else {
        debugPrint('Empty list $text');
      }
    }
  }

  Map? _extractJson(String text) {
    log(text);
    // text = datawe;
    // final firstJsonBracket = text.indexOf('[');
    // int lastJsonBracket = text.lastIndexOf(']');
    final firstJsonBracket = text.indexOf('{');
    int lastJsonBracket = text.lastIndexOf('}');

    debugPrint('${text.length} $firstJsonBracket $lastJsonBracket');
    if (lastJsonBracket == -1) lastJsonBracket = text.length;
    if (firstJsonBracket != -1 && lastJsonBracket != -1) {
      text = text.trim();
      int addedIndex = lastJsonBracket + 1;
      lastJsonBracket = addedIndex > text.length ? text.length : addedIndex;
      String jsonString = text.substring(firstJsonBracket, lastJsonBracket);
      // log('--- $jsonString');
      var myParser = CustomJSONParser(jsonString);
      var parsedObject = myParser.parse();
      // log(parsedObject.toString());

      return parsedObject as Map<String, dynamic>;
    } else {
      debugPrint('Malformed list $text');
      AppSnackBar.showErrorCustomSnackbar(
          message: 'Could not parse ingredients, try again');
    }
    return null;
  }

  void _showError(String message, BuildContext context) {
    spokenText = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> getRecipes(context) async {
    // _getRecipes('', context);
    final message = jsonEncode(ingredientList.map((e) => e.toJson()).toList());
    _setLoading(true);
    await _germiniServices.generateContent(
      message: message,
      type: QueryType.recipe,
      onSuccess: (text) {
        resultText = text;
        _setLoading(false);
        _getRecipes(text, context);
      },
      onError: (error) {
        _setLoading(false);
        _showError(error, context);
      },
    );
  }

  // String escapeSpecialCharacters(String text) {
  //   log(text);
  //   return r"" "$text" r" ";
  //   return text.replaceAll("\n", r"\n");
  //   // RegExp specialChars = RegExp(r'[\\^$.*+?()\[\]{}|]');
  //   // String escapedText = text.replaceAllMapped(specialChars, (match) {
  //   //   return '\\${match.group(0)}';
  //   // });
  //   // return escapedText;
  // }

  Future<void> _getRecipes(String text, BuildContext context) async {
//     text = '''
// {"recipes": [{"name": "Scrambled Eggs and Rice", "cooktime": 15, "description": "A hearty and quick breakfast", "instructions": "1. Heat the olive oil in a nonstick skillet over medium heat.\n2. Cook the garlic for 1 min.\n3. Add the bell peppers and cook them for 5 minutes. \n4. Crack the eggs into a bowl and whisk until smooth.\n5. Add the eggs to the skillet and scramble until cooked through.\n6. Serve with rice. ", "tips": "Add salt and pepper to taste.", "ingredients": [{"name": "eggs", "quantity": 6}, {"name": "olive oil", "quantity": 1, "unit": "tbsp"}, {"name": "garlic", "quantity": 1, "unit": "clove"}, {"name": "bell peppers", "quantity": 1}, {"name": "rice", "quantity": 1, "unit": "cup"}]}, {"name": "Chicken and Rice Burrito", "cooktime": 30, "description": "A delicious and satisfying lunch or dinner", "instructions": "1. Heat the olive oil in a large skillet over medium heat.\n2. Add the chicken and cook it until browned on all sides.\n3. Add the bell peppers, onions, and garlic to the skillet and cook them until softened.\n4. Stir in the rice and beans and cook until heated through.\n5. Season with salt and pepper to taste.\n6. Place a tortilla on a plate and fill it with the chicken mixture.\n7. Top with your favorite toppings, such as cheese, sour cream, and guacamole.", "tips": null, "ingredients": [{"name": "chicken breasts", "quantity": 2}, {"name": "olive oil", "quantity": 2, "unit": "tbsp"}, {"name": "bell peppers", "quantity": 1}, {"name": "onions", "quantity": 2}, {"name": "garlic", "quantity": 2, "unit": "cloves"}, {"name": "rice", "quantity": 1, "unit": "cup"}, {"name": "canned beans", "quantity": 1, "unit": "can"}, {"name": "cheese", "quantity": 1, "unit": "cup"}, {"name": "sour cream", "quantity": 1, "unit": "cup"}, {"name": "guacamole", "quantity": 1, "unit": "cup"}]}, {"name": "Chicken and Spinach Soup", "cooktime": 30, "description": "A healthy and comforting soup", "instructions": "1. Heat the olive oil in a large pot over medium heat.\n2. Add the chicken breasts and cook them until browned on all sides.\n3. Add the onions, carrots, and celery to the pot and cook them until softened.\n4. Add the garlic to the pot and cook for 1 min.\n5. Add the spinach and cook until wilted.\n6. Add the chicken broth and season with salt and pepper to taste.\n7. Bring the soup to a boil, then reduce heat and simmer for 20 minutes, or until the chicken is cooked through.\n8. Remove the chicken from the soup and shred it. Return the chicken to the soup and stir.", "tips": "Serve with crusty bread", "ingredients": [{"name": "chicken breasts", "quantity": 2}, {"name": "olive oil", "quantity": 1, "unit": "tbsp"}, {"name": "onions", "quantity": 2}, {"name": "carrots", "quantity": 2}, {"name": "celery", "quantity": 2}, {"name": "garlic", "quantity": 2, "unit": "cloves"}, {"name": "spinach", "quantity": 1, "unit": "bunch"}, {"name": "chicken broth", "quantity": 4, "unit": "cups"}, {"name": "salt and pepper", "quantity": null}, {"name": "bread", "quantity": 1, "unit": "loaf"}]}, {"name": "Chicken Salad Sandwich", "cooktime": 15, "description": "A classic and refreshing lunch", "instructions": "1. Place the chicken in a bowl and shred it.\n2. Add the mayonnaise, celery, onion, and salt to the bowl and stir to combine.\n3. Spread the chicken salad on slices of bread and enjoy.", "tips": "Add lettuce or tomato for extra freshness", "ingredients": [{"name": "chicken breasts", "quantity": 2}, {"name": "mayonnaise", "quantity": 1, "unit": "cup"}, {"name": "celery", "quantity": 2}, {"name": "onions", "quantity": 1}, {"name": "salt", "quantity": null}, {"name": "bread", "quantity": 4, "unit": "slices"}]}, {"name": "Chicken Tacos", "cooktime": 20, "description": "A flavorful and fun dinner", "instructions": "1. Heat the olive oil in a large skillet over medium heat.\n2. Add the chicken breasts and cook them until browned on all sides.\n3. Add the taco seasoning to the skillet and cook according to package directions.\n4. Warm the tortillas in the microwave or oven.\n5. Fill the tortillas with the chicken mixture and your favorite toppings, such as cheese, lettuce, and tomatoes.", "tips": "Serve with guacamole and sour cream", "ingredients": [{"name": "chicken breasts", "quantity": 2}, {"name": "olive oil", "quantity": 1, "unit": "tbsp"}, {"name": "taco seasoning", "quantity": 1, "unit": "packet"}, {"name": "tortillas", "quantity": 6}, {"name": "cheese", "quantity": 1, "unit": "cup"}, {"name": "lettuce", "quantity": 1, "unit": "head"}, {"name": "tomatoes", "quantity": 2}, {"name": "guacamole", "quantity": 1, "unit": "cup"}, {"name": "sour cream", "quantity": 1, "unit": "cup"}]}]}
// ''';
//     text = escapeSpecialCharacters(text);
//     text = '''
// {"recipes": [{"name": "Scrambled Eggs and Rice", "cooktime": 15, "description": "A hearty and quick breakfast", "instructions": "1. Heat the olive oil in a nonstick skillet over medium heat.\n2. Cook the garlic for 1 min.\n3. Add the bell peppers and cook them for 5 minutes. \n4. Crack the eggs into a bowl and whisk until smooth.\n5. Add the eggs to the skillet and scramble until cooked through.\n6. Serve with rice. ", "tips": "Add salt and pepper to taste.", "ingredients": [{"name": "eggs", "quantity": 6}, {"name": "olive oil", "quantity": 1, "unit": "tbsp"}, {"name": "garlic", "quantity": 1, "unit": "clove"}, {"name": "bell peppers", "quantity": 1}, {"name": "rice", "quantity": 1, "unit": "cup"}]}]}
// ''';
//     text = r'' + text;
    // log(text);
    // log('--------------');
    final json = getJsonFromString(text);
    // print(json);
    // final jsonconverted = _extractJson(text);

    if (json.isNotEmpty) {
      // debugPrint('jsonconverted : ${json.runtimeType}');
      final convertedList = json['recipes'] as List<dynamic>;
      // final convertedList = jsonconverted;
      // debugPrint('convertedList : $convertedList.');
      // log(convertedList.toString());
      if (convertedList.isNotEmpty) {
        recipeList = convertedList
            .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
            .toList();

        notifyListeners();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SuggestedRecipesView()));
      } else {
        AppSnackBar.showErrorCustomSnackbar(
            message: 'No recipes found, try again');
      }
    } else {
      AppSnackBar.showErrorCustomSnackbar(
          message: 'No recipes found, try again');
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _authenticationsService.saveUserRecipeData([recipe]);
    AppSnackBar.showCustomSnackbar(message: 'Saved successfully');
  }

  void viewRecipeDetails(Recipe recipe, BuildContext context) {
    selectedRecipe = recipe;

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const RecipeDetailsView()));
  }

  Future<void> searchYoutube(BuildContext context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SuggestedVideosView()));
    youtubeData.clear();
    _setLoading(true);
    final response =
        await YoutubeApiService().getVideos('${selectedRecipe?.name}');
    _setLoading(false);
    if (response != null) {
      final result = response["items"] as List;
      debugPrint(result.first.toString());
      youtubeData = result.map((e) => YoutubeSearchItem.fromJson(e)).toList();
      notifyListeners();
    }
    // selectedRecipe = recipe;
  }

  Future<void> playVideo(YoutubeSearchItem item, BuildContext context) async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => CustomYoutubePlayer(id: item.id)));
  }

  Future<void> startListening() async {
    if (!_speechToTextService.initialized) {
      await _speechToTextService.initSpeech(onError: (e) {
        log('error initial $e');
        notifyListeners();
      });
    }
    if (_speechToTextService.isListening.value) {
      _speechToTextService.stopListening(onSpeechStopped: (text) {
        log('Stopped: $text');
        notifyListeners();
      });
    }
    _speechToTextService.startListening(onSpeech: (text, val) {
      log('Said: $text');
      notifyListeners();
      textEditingController.text = text;
    });
  }
}
