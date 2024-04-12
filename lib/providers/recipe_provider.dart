import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe/models/ingredients.dart';
import 'package:recipe/services/gemini_service.dart';
import 'package:recipe/services/speech_to_text_service.dart';
import 'package:recipe/ui/confirm_ingredient_view.dart';

class RecipeProvider extends ChangeNotifier {
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final TextEditingController textEditingController = TextEditingController();
  final GeminiService _germiniServices = GeminiService();
  ScrollController controller = ScrollController();
  bool get _loading => _germiniServices.loading.value;
  List<Ingredient> ingredientList = [];
  String spokenText = '';
  String resultText = '';
  int start = 0;
  int end = 0;
  bool loading = false;
  void initialize() {
    _initGemini();
  }

  void _initGemini() => _germiniServices.init();

  Future<void> sendMessage(context) async {
    final message = textEditingController.text;
    bool hasValidMessage = message.isNotEmpty;
    bool canSendMessage =
        hasValidMessage && _speechToTextService.isNotListening && !_loading;
    if (canSendMessage) {
      loading = true;
      notifyListeners();
      await _germiniServices.sendMessage(
        message: message,
        onSuccess: (text) {
          loading = false;
          resultText = text;

          notifyListeners();
          _extractJson(text, context);
        },
        onError: (error) {
          loading = false;
          notifyListeners();
          _showError(error, context);
        },
      );
    }
  }

  void _extractJson(String text, BuildContext context) {
    final firstJsonBracket = text.indexOf('{');
    final lastJsonBracket = text.lastIndexOf('}');
    print('${text.length} $firstJsonBracket $lastJsonBracket');
    if (firstJsonBracket != -1 && lastJsonBracket != -1) {
      final jsonString = text.substring(firstJsonBracket, lastJsonBracket + 1);
      print(jsonString);
      final jsonconverted = jsonDecode(jsonString);
      print(jsonconverted);
      final convertedList = jsonconverted['ingredients'] as List<dynamic>;
      if (convertedList.isNotEmpty) {
        ingredientList = convertedList
            .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ConfirmIngredientView()));
      } else {
        print('Empty list $text');
      }
    } else {
      print('Malformed list $text');
    }
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
}
