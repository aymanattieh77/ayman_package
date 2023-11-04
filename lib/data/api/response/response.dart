class ApiResponse<T> {
  APIStatus status;
  T? data;
  String? message;

  ApiResponse.loading(this.message) : status = APIStatus.loading;
  ApiResponse.completed(this.data) : status = APIStatus.compeleted;
  ApiResponse.error(this.message) : status = APIStatus.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum APIStatus { loading, compeleted, error }

abstract class Result<T> {
  T? data;
  String? message;
  Result([this.data, this.message]);
}

class Success<T> extends Result<T> {
  Success(super.data);
}

class Fail<T> extends Result<T> {
  String? errorMessage;

  Fail(this.errorMessage) : super(null, errorMessage);
}

abstract class Status<L, R> {
  R? data;
  L? failure;
  Status();

  /// Represents the left side of [Either] class which by convention is a "Failure".
  bool get isLeft => this is Left<L, R>;

  /// Represents the right side of [Either] class which by convention is a "Success"
  bool get isRight => this is Right<L, R>;

  T fold<T>(T Function(L left) fnL, T Function(R right) fnR);
}

class Right<L, R> extends Status<L, R> {
  R value;
  Right(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnR(value);
  }
}

class Left<R, L> extends Status<L, R> {
  L value;
  Left(this.value);

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnL(value);
  }
}
