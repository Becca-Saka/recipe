import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;
  bool initialized = false;
  String _lastWords = '';
  final ValueNotifier<bool> isListening = ValueNotifier(false);

  bool get isNotListening => !isListening.value || _speechToText.isNotListening;

  Future<void> initSpeech({
    required Function(SpeechRecognitionError) onError,
  }) async {
    speechEnabled = await _speechToText.initialize(
      debugLogging: true,
      onError: (error) {
        debugPrint('error: $error');
        _lastWords = '';
        isListening.value = false;
        onError(error);
      },
    );
    initialized = true;
  }

  /// Starts a speech recognition session
  Future<void> startListening({
    required Function(String, bool) onSpeech,
  }) async {
    try {
      await stopListening(onSpeechStopped: (p0) {});
      _lastWords = '';
      isListening.value = true;
      await _speechToText.listen(
        localeId: 'en-NG',
        pauseFor: const Duration(seconds: 10),
        listenOptions: SpeechListenOptions(
          autoPunctuation: true,
          listenMode: ListenMode.dictation,
          cancelOnError: true,
        ),
        onResult: (result) {
          debugPrint('results: ${result.recognizedWords}');

          _lastWords = result.recognizedWords;

          if (result.finalResult) {
            isListening.value = false;
          }
          onSpeech(_lastWords, result.finalResult);
        },
      );
      onSpeech(_lastWords, false);
    } on Exception catch (e) {
      debugPrint('error response: $e');
    }
  }

  /// Stops the active speech recognition session
  Future<void> stopListening(
      {required Function(String) onSpeechStopped}) async {
    await _speechToText.stop();

    isListening.value = false;
    onSpeechStopped(_lastWords);
  }

  Future<void> cancel() async => await _speechToText.cancel();
}
