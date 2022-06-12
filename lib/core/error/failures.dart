import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String errorMessage;
  int code;
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

//General failures
class InvalidRequestFailure extends Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoConnectionFailure extends Failure {}
