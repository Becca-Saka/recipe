import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// enum QueryType { text, image }

class GeminiService {
  late GenerativeModel model;
  late GenerativeModel imageModel;
  late ChatSession chat;
  final String prompt =
      "Your role is to collect the ingredients and quantity information ad return it in a json format";

  final ValueNotifier<bool> loading = ValueNotifier(false);
  List<Content> get chats => chat.history.toList();

  int maxMessageSize = 1005299;
  void init() {
    const apiKey = String.fromEnvironment('API_KEY');

    model = GenerativeModel(
      model: 'gemini-1.0-pro',
      apiKey: apiKey,
    );
    imageModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: apiKey,
    );
    chat = model.startChat();
  }

  Future<void> sendMessage({
    String? message,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    if (message != null) {
      _sendTextMessage(message, onSuccess: onSuccess, onError: onError);
    } else {
      onError('No message or image provided');
    }
  }

  Future<void> _sendTextMessage(
    String message, {
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setLoading(true);
    try {
      var response = await chat.sendMessage(Content.text('$prompt$message'));
      _onResponse(response, onSuccess: onSuccess, onError: onError);
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
    debugPrint('text: $text');
    _setLoading(false);
    if (text == null) {
      onError('No response from API.');
      return;
    } else {
      onSuccess(text);
    }
  }

  int _calculateMessageSize(List<Part> message) {
    var size = 0;
    for (var part in message) {
      if (part is TextPart) {
        size += part.text.length;
      } else if (part is DataPart) {
        final json = part.toJson();
        final jsonString = jsonEncode(json);
        final jsonSizeInBytes = utf8.encode(jsonString).length;
        size += jsonSizeInBytes;
      }
    }
    return size;
  }

  void _setLoading(bool value) => loading.value = value;
}
