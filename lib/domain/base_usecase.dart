import 'package:ayman_package/data/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUsecase<Output, Parameters> {
  Future<Either<Failure, Output>> call(Parameters parameters);
}

class NoParam extends Equatable {
  const NoParam();
  @override
  List<Object> get props => [];
}
