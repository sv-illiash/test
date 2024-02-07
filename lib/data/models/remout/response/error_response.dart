class ErrorResponse {
  static const String _fieldError = 'error';
  static const String _fieldMessage = 'message';
  static const String _fieldTimestamp = 'timestamp';

  final String timestamp;
  final String error;
  final String message;

  const ErrorResponse(
      {required this.timestamp, required this.error, required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        timestamp: json[_fieldTimestamp].toString(),
        error: json[_fieldError].toString(),
        message: json[_fieldMessage] ?? '');
  }
}
