import 'package:news_app/core/utils/common_strings.dart';

abstract class Failure {
  String msg;
  Failure({required this.msg});
}

class ServerFailure extends Failure {
  ServerFailure() : super(msg: kErrorMsg);
}

class SignUpFailure extends Failure {
  final String message;
  SignUpFailure({required this.message}) : super(msg: message);
}
