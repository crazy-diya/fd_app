import 'package:equatable/equatable.dart';

class ErrorResponseEntity extends Equatable {
  ErrorResponseEntity({
    required this.responseCode,
    required this.responseError,
  });

  String responseCode;
  String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
