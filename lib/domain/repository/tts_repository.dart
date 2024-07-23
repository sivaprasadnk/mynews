import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';

abstract class TtsRepository {
  Future<Either<Failure, void>> speakText(String content);
  Future<Either<Failure, void>> stopSpeaking();
}
