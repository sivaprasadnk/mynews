import 'package:flutter_tts/flutter_tts.dart';

abstract class TtsDataSource {
  Future<void> speakText(String content);
  Future<void> stop();
}

class TtsDataSourceImpl extends TtsDataSource {
  final FlutterTts tts;
  TtsDataSourceImpl({
    required this.tts,
  });

  @override
  Future<void> speakText(String content) async {
    await tts.speak(content);
  }

  @override
  Future<void> stop() async {
    await tts.stop();
  }
}
