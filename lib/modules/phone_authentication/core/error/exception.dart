class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}

class InternetException implements Exception {
  final String message;

  InternetException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}
