import 'package:dartz/dartz.dart';
import 'package:fd_app/error/failures.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}
