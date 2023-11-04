class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, [this.statusCode]);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class CahceException implements Exception {
  final String message;
  CahceException(this.message);
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class StorageException implements Exception {
  final String message;
  StorageException(this.message);
}
