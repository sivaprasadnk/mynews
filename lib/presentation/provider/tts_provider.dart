import 'package:flutter/material.dart';
import 'package:my_news/domain/use_cases/tts/speak_text.dart';

class TtsProvider extends ChangeNotifier {
  final SpeakText speakText;
  TtsProvider({
    required this.speakText,
  });

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  playText(String content) async {
    _isSpeaking = true;
    notifyListeners();
    await speakText.call(content).whenComplete(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  stop(String content) async {
    _isSpeaking = true;
    notifyListeners();
    await speakText.call(content).whenComplete(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }
}
