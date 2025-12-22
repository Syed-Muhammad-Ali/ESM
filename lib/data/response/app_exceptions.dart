class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);
  @override
  String toString() => _message ?? '$_prefix$_message';
  String get message => _message ?? '';
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet');
}
