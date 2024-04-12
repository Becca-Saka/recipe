import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/models/ingredients.dart';
import 'package:recipe/providers/data.dart';
import 'package:recipe/services/gemini_service.dart';
import 'package:recipe/services/speech_to_text_service.dart';
import 'package:recipe/shared/custom_json_parser.dart';
import 'package:recipe/ui/confirm_ingredient_view.dart';
import 'package:recipe/ui/suggested_recipes_view.dart';

class RecipeProvider extends ChangeNotifier {
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final TextEditingController textEditingController = TextEditingController();
  final GeminiService _germiniServices = GeminiService();
  ScrollController controller = ScrollController();
  bool get _loading => _germiniServices.loading.value;
  List<Ingredient> ingredientList = [];
  List<Recipe> recipeList = [];
  String spokenText = '';
  String resultText = '';
  int start = 0;
  int end = 0;
  bool loading = false;
  void initialize() {
    _initGemini();
  }

  void _initGemini() => _germiniServices.init();

  Future<void> getIngredients(context) async {
    final message = textEditingController.text;
    bool hasValidMessage = message.isNotEmpty;
    bool canSendMessage =
        hasValidMessage && _speechToTextService.isNotListening && !_loading;
    if (canSendMessage) {
      loading = true;
      notifyListeners();
      await _germiniServices.generateContent(
        message: message,
        onSuccess: (text) {
          loading = false;
          resultText = text;

          notifyListeners();
          _getIngredient(text, context);
        },
        onError: (error) {
          loading = false;
          notifyListeners();
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
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ConfirmIngredientView()));
      } else {
        debugPrint('Empty list $text');
      }
    }
  }

  Map? _extractJson(String text) {
    // // Define the regex pattern to match any JSON-like structure
    // RegExp regex = RegExp(
    //     r'\{(?:[^{}]|(?:\{(?:[^{}]|(?:\{(?:[^{}]|(?:\{[^{}]*\}))*\}))*\}))*\}');
    // // RegExp regex = RegExp(r'\{[^{}]+\}');
    // Iterable<Match> matches = regex.allMatches(text);

    // List<String> jsonStrings = [];
    // for (Match match in matches) {
    //   log(match.group(0).toString());

    //   jsonStrings.add(match.group(0)!);
    // }
    // // debugPrint(text);
    // Clipboard.setData(ClipboardData(text: text));
    // print("----------------------------------------------------");

    // if (jsonStrings.isNotEmpty) {
    //   String jsonString = jsonStrings.join(',');
    //   // jsonString = jsonString.replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F]'), '');
    //   // log(jsonStrings.toString());
    //   final jsonconverted = json.decode(jsonString) as Map<String, dynamic>;
    //   return jsonconverted;
    // }
    // log(text);
    text = datateo;
    final firstJsonBracket = text.indexOf('{');
    final lastJsonBracket = text.lastIndexOf('}');
    debugPrint('${text.length} $firstJsonBracket $lastJsonBracket');
    if (firstJsonBracket != -1 && lastJsonBracket != -1) {
      text = text.trim();
      Clipboard.setData(ClipboardData(text: text));
      String jsonString = text.substring(firstJsonBracket, lastJsonBracket + 1);
      // print(jsonString);
      // jsonString = jsonString.replaceAll('\n', '\\n');
      // jsonString = jsonString.replaceAll(r'\', r'\\');
      // jsonString = jsonString.trim();
      // jsonString = jsonString.replaceAll('\\n', '\\');
      var myParser = CustomJSONParser(jsonString);
      var parsedObject = myParser.parse();
      log(parsedObject.toString());
      // final jsonconverted = json.decode(jsonString) as Map<String, dynamic>;

      // debugPrint(jsonconverted.runtimeType.toString());

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
    _getRecipes('', context);
    // final message = jsonEncode(ingredientList.map((e) => e.toJson()).toList());

    // loading = true;
    // notifyListeners();
    // await _germiniServices.generateContent(
    //   message: message,
    //   type: QueryType.recipe,
    //   onSuccess: (text) {
    //     loading = false;
    //     resultText = text;

    //     notifyListeners();
    //     _getRecipes(text, context);
    //   },
    //   onError: (error) {
    //     loading = false;
    //     notifyListeners();
    //     _showError(error, context);
    //   },
    // );
  }

  void _getRecipes(String text, BuildContext context) {
    final jsonconverted = _extractJson(text);
    print('json : $jsonconverted');
    if (jsonconverted != null) {
      final convertedList = jsonconverted['recipes'] as List<dynamic>;
      if (convertedList.isNotEmpty) {
        recipeList = convertedList
            .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SuggestedRecipesView()));
      } else {
        debugPrint('Empty list $text');
      }
    }
  }
}
