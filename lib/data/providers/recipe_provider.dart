import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/youtube_model.dart';
import 'package:recipe/data/services/firebase_service.dart';
import 'package:recipe/data/services/gemini_service.dart';
import 'package:recipe/data/services/pexels_api_service.dart';
import 'package:recipe/data/services/speech_to_text_service.dart';
import 'package:recipe/data/services/youtube_api_service.dart';
import 'package:recipe/shared/app_snackbar.dart';
import 'package:recipe/shared/custom_json_parser.dart';
import 'package:recipe/ui/confirm_ingredient_view.dart';
import 'package:recipe/ui/recipe_details_view.dart';
import 'package:recipe/ui/suggested_recipes_view.dart';
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
        // _getIngredientImage();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ConfirmIngredientView()));
      } else {
        debugPrint('Empty list $text');
      }
    }
  }

  Future<void> _getIngredientImage() async {
    if (ingredientList.isNotEmpty) {
      for (var element in ingredientList) {
        final image = await PexelsApiService().getPicture(element.name);

        if (image != null) {
          int index = ingredientList.indexOf(element);
          ingredientList[index].imageUrl = image;
          // element.imageUrl = image;

          notifyListeners();
        }
      }
    }
  }

  Map? _extractJson(String text) {
    try {
      final firstJsonBracket = text.indexOf('{');
      int lastJsonBracket = text.lastIndexOf('}');

      debugPrint('${text.length} $firstJsonBracket $lastJsonBracket');
      if (lastJsonBracket == -1) lastJsonBracket = text.length;
      if (firstJsonBracket != -1 && lastJsonBracket != -1) {
        var myParser = jsonDecode(text.replaceAll('\\n', ' '));
        log('From Pur Decoder $myParser with ${myParser.runtimeType}');
        return myParser as Map<String, dynamic>;
      } else {
        log('From Invalid json ');

        return _extractCustomJson(text);
      }
    } catch (e) {
      log('user error $e');
      return _extractCustomJson(text);
    }
    // return null;
  }

  Map? _extractCustomJson(String text) {
    final firstJsonBracket = text.indexOf('{');
    int lastJsonBracket = text.lastIndexOf('}');

    debugPrint('${text.length} $firstJsonBracket $lastJsonBracket');
    if (lastJsonBracket == -1) lastJsonBracket = text.length;
    if (firstJsonBracket != -1 && lastJsonBracket != -1) {
      text = text.trim();
      int addedIndex = lastJsonBracket + 1;
      lastJsonBracket = addedIndex > text.length ? text.length : addedIndex;
      String jsonString = text.substring(firstJsonBracket, lastJsonBracket);

      var myParser = CustomJSONParser(jsonString);
      var parsedObject = myParser.parse();

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

  Future<void> _getRecipes(String text, BuildContext context) async {
    final json = _extractJson(text);
    // final json = getJsonFromString(text);

    if (json != null && json.isNotEmpty) {
      final convertedList = json['recipes'] as List<dynamic>;

      if (convertedList.isNotEmpty) {
        recipeList = convertedList
            .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
            .toList();
        _getRecipeImage();
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

  Future<void> _getRecipeImage() async {
    if (recipeList.isNotEmpty) {
      for (var element in recipeList) {
        final image = await PexelsApiService().getPicture(element.name);

        if (image != null) {
          int index = recipeList.indexOf(element);
          recipeList[index].imageUrl = image;

          notifyListeners();
        }
      }
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _authenticationsService.saveUserRecipeData(recipe);
    notifyListeners();
  }

  void viewRecipeDetails(Recipe recipe, BuildContext context) {
    selectedRecipe = recipe;

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const RecipeDetailsView()));
  }

  Future<void> searchYoutube() async {
    youtubeData.clear();
    _setLoading(true);
    final response =
        await YoutubeApiService().getVideos('${selectedRecipe?.name}');
    _setLoading(false);
    if (response.isNotEmpty) {
      youtubeData = response.map((e) => YoutubeSearchItem.fromJson(e)).toList();
      notifyListeners();
    }
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
      await _speechToTextService.stopListening(onSpeechStopped: (text) {
        log('Stopped: $text');
        notifyListeners();
      });
    } else {
      _speechToTextService.startListening(onSpeech: (text, val) {
        log('Said: $text');
        notifyListeners();
        textEditingController.text = text;
      });
    }
  }
}
