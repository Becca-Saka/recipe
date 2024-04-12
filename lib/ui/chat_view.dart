import 'package:flutter/material.dart';
import 'package:recipe/data/services/gemini_service.dart';
import 'package:recipe/data/services/speech_to_text_service.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/shared/widget/gradient_text.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final TextEditingController _textEditingController = TextEditingController();
  final GeminiService _germiniServices = GeminiService();
  ScrollController controller = ScrollController();
  bool get _loading => _germiniServices.loading.value;
  bool imageLoading = false;

  String spokenText = '';
  String resultText = '';
  int start = 0;
  int end = 0;

  @override
  void initState() {
    super.initState();
    _initGemini();
    // _initSpeechServices();
  }

  void _initGemini() => _germiniServices.init();

  // void _initSpeechServices() async {
  //   await _speechToTextService.initSpeech(
  //     onError: (e) {
  //       spokenText = '';
  //       setState(() {});
  //       debugPrint('error: $e');
  //     },
  //   );

  //   setState(() {});
  // }

  // void _startListening() async {
  //   await _speechToTextService.startListening(
  //     onSpeech: (lastWords, isFinal) {
  //       spokenText = lastWords;
  //       setState(() {});
  //       if (isFinal) {
  //         _sendMessage(message: lastWords);
  //       }
  //     },
  //   );
  // }

  // Future<void> _stopListening() async {
  //   await _speechToTextService.stopListening(
  //     onSpeechStopped: (lastWords) {
  //       spokenText = lastWords;
  //       setState(() {});

  //       _sendMessage(message: lastWords);
  //     },
  //   );
  // }

  // void _stopSession() {
  //   if (!_speechToTextService.isNotListening) {
  //     _speechToTextService.cancel();
  //   }

  //   spokenText = '';

  //   setState(() {});
  // }

  Future<void> _sendMessage({String? message}) async {
    bool hasValidMessage = message != null && message.isNotEmpty;
    bool canSendMessage =
        hasValidMessage && _speechToTextService.isNotListening && !_loading;
    if (canSendMessage) {
      await _germiniServices.generateContent(
        message: message,
        onSuccess: (text) {
          print(text);
          resultText = text;
          //TODO
          setState(() {});
        },
        onError: (error) {
          setState(() {});
          _showError(error);
        },
      );
    }
  }

  void _showError(String message) {
    imageLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            const GradientText(
              'Gemini Assistant',
              style: TextStyle(fontSize: 40),
              gradient: LinearGradient(colors: [
                AppColors.blue,
                AppColors.secondaryColor,
                AppColors.tertiaryColor,
              ]),
            ),
            Expanded(
              child: Center(
                child:
                    // !_speechToTextService.speechEnabled
                    //     ? const Text(
                    //         'Speech not enabled on your device. Check your settings',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(fontSize: 20),
                    //       )
                    //     :
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: SingleChildScrollView(
                        child: Text(resultText),
                      ),
                    ),
                    // HighlightedText(
                    //   text: resultText,
                    //   start: start,
                    //   end: end,
                    // ),
                    // const Spacer(),
                    if (resultText.isNotEmpty)
                      const SizedBox(
                        height: 80,
                      ),
                    TextField(
                      controller: _textEditingController,
                      maxLines: 4,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_textEditingController.text.isNotEmpty) {
                          _sendMessage(message: _textEditingController.text);
                        }
                      },
                      child: const Text('Send'),
                    ),
                    // AnimatedSwitcher(
                    //   duration: const Duration(milliseconds: 300),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       if (spokenText.isNotEmpty)
                    //         Text(
                    //           spokenText,
                    //           style: const TextStyle(
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //       const SizedBox(height: 50),
                    //       ValueListenableBuilder(
                    //           valueListenable: _germiniServices.loading,
                    //           builder: (context, value, child) {
                    //             return PushToTalk(
                    //               loading: value,
                    //               isNotListening:
                    //                   _speechToTextService.isNotListening,
                    //               onPressed:
                    //                   _speechToTextService.isNotListening
                    //                       ? _startListening
                    //                       : _stopListening,
                    //             );
                    //           }),
                    //     ],
                    //   ),
                    // ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
