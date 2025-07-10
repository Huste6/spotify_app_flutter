class AppFailure {
  final String message;
  AppFailure([String? message])
      : message = message ?? 'Sorry, an unexpected error occured!';

  @override
  String toString() => 'AppFailure(message: $message)';
}
