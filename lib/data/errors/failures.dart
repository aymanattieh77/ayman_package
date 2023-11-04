import 'package:equatable/equatable.dart';

abstract interface class Failure extends Equatable {
  final String message;
  final int? statusCode;
  const Failure(this.message, [this.statusCode]);
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.statusCode]);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}

class DataBaseFailure extends Failure {
  const DataBaseFailure(super.message);
}

class CahceFailure extends Failure {
  const CahceFailure(super.message);
}
