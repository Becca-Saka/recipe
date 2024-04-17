import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/youtube_model.dart';
import 'package:recipe/data/services/api_service.dart';
import 'package:recipe/data/services/firebase_service.dart';
import 'package:recipe/data/services/gemini_service.dart';
import 'package:recipe/data/services/speech_to_text_service.dart';
import 'package:recipe/shared/custom_json_parser.dart';
import 'package:recipe/ui/confirm_ingredient_view.dart';
import 'package:recipe/ui/recipe_details_view.dart';
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
    final firstJsonBracket = text.indexOf('{');
    int lastJsonBracket = text.lastIndexOf('}');
    debugPrint('${text.length} $firstJsonBracket $lastJsonBracket');
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

  Future<void> _getRecipes(String text, BuildContext context) async {
    final jsonconverted = _extractJson(text);

    if (jsonconverted != null) {
      debugPrint('jsonconverted : $jsonconverted');
      final convertedList = jsonconverted['recipes'] as List<dynamic>;
      debugPrint('convertedList : $convertedList');
      if (convertedList.isNotEmpty) {
        recipeList = convertedList
            .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
      } else {
        debugPrint('Empty list $text');
      }
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _authenticationsService.saveUserRecipeData([recipe]);
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
