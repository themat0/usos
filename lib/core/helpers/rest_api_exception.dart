class RestApiException {
  final String message;
  final int statusCode;

  RestApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'RestApiException{message: $message, statusCode: $statusCode}';
  }
}