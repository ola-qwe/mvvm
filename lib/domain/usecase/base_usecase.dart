import 'package:mvvm_udemy/data/network/failure.dart';
import 'package:dartz/dartz.dart';
//we will extends from this to all usecase
abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
