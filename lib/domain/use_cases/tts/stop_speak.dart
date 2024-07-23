import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/tts_repository.dart';

class StopSpeak {
  final TtsRepository repository;
  StopSpeak(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.stopSpeaking();
  }
}
