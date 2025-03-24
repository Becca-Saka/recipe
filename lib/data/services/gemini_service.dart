import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:recipe/shared/prompts.dart';

enum QueryType { ingredients, recipe }

class GeminiService {
  late GenerativeModel model;
  late ChatSession chat;

  final ValueNotifier<bool> loading = ValueNotifier(false);
  List<Content> get chats => chat.history.toList();

  int maxMessageSize = 1005299;

  void init() {
    model = GenerativeModel(
      model: 'gemini-1.0-pro',
      apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
    );

    chat = model.startChat();
  }

  Future<void> generateContent({
    required String message,
    QueryType type = QueryType.ingredients,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setLoading(true);
    try {
      var prompt = type == QueryType.ingredients
          ? '${Prompts.ingredientExtractionPrompt}$message'
          : '${Prompts.recipeExtractionPrompt}$message${Prompts.recipeExtractionPrompt2}';

      var response = await model.generateContent([Content.text(prompt)]);
      _onResponse(response, onSuccess: onSuccess, onError: onError);
    } on GenerativeAIException catch (e) {
      String message = e.message;
      if (e.message == 'User location is not supported for the API use.') {
        message =
            'Gemini is not available in your location. Please try another location or use a VPN.';
      }
      onError(message);
      _setLoading(false);
    } catch (e) {
      onError(e.toString());
      _setLoading(false);
    } finally {
      _setLoading(false);
    }
  }

  void _onResponse(
    GenerateContentResponse response, {
    required Function(String) onSuccess,
    required Function(String) onError,
  }) {
    var text = response.text;
    _setLoading(false);
    if (text == null) {
      onError('No response from API.');
      return;
    } else {
      onSuccess(text);
    }
  }

  void _setLoading(bool value) => loading.value = value;
}
