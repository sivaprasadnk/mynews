import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/tts_repository.dart';

class SpeakText {
  final TtsRepository repository;
  SpeakText(this.repository);

  Future<Either<Failure, void>> call(String content) async {
    return await repository.speakText(content);
  }
}
