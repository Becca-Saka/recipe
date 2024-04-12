import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

enum QueryType { ingredients, recipe }

class GeminiService {
  late GenerativeModel model;
  late ChatSession chat;
  final String ingredientExtractionPrompt =
      """Your role is to collect the ingredients and quantity information and return it in a json format that looks like this
      {
        "ingredients": [
          {
            "name": "eggs",
            "quantity": 3,
          },{
            "name": "flour",
            "quantity": 0.6,
          },
           ...
        ]
      }

      NOTE: 
        1. If there is no "unit" value provided, take initiative and add an approprite unit for the ingredient.
        2. If you cant determine the unit skip the field
        3. "quantity" should either be a double or a int
        4. return just the json, not quotations
      """;
  final String recipeExtractionPrompt =
      """Your role is to collect the list of ingredients and quantity information and return a list of  recipes that can be made with the available ingredient keeping the quntity in mind, return your response it in a json format that looks like this
      {
        "recipes": [
          {
            "name": "",
            "cooktime": "",
            "{"description": "It is a long established fact\\nthat a reader will be distracted by the readable content\\nof a page when looking at its layout. The point\\nof using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."}"
            "instructions": "",
            "tips": "",
            "ingredients": [
              {
                "name": "eggs",
                "quantity": 3,
              },
              ...
             ]
          },
           ...
        ]
      }

      """;

  final ValueNotifier<bool> loading = ValueNotifier(false);
  List<Content> get chats => chat.history.toList();

  int maxMessageSize = 1005299;
  void init() {
    const apiKey = String.fromEnvironment('API_KEY');

    model = GenerativeModel(
      model: 'gemini-1.0-pro',
      apiKey: apiKey,
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
    // try {
    final prompt = type == QueryType.ingredients
        ? ingredientExtractionPrompt
        : recipeExtractionPrompt;
    var response =
        await model.generateContent([Content.text('$prompt$message')]);
    // var response = await chat.sendMessage(Content.text('$prompt$message'));
    _onResponse(response, onSuccess: onSuccess, onError: onError);
    // } catch (e) {
    //   onError(e.toString());
    //   _setLoading(false);
    // } finally {
    //   _setLoading(false);
    // }
  }

  void _onResponse(
    GenerateContentResponse response, {
    required Function(String) onSuccess,
    required Function(String) onError,
  }) {
    var text = response.text;
    // debugPrint('text: $text');
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
