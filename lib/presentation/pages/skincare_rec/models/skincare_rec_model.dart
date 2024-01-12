class SkincareRecResponse {
  final String message;
  final List<String> response;
  final int status;

  SkincareRecResponse({
    required this.message,
    required this.response,
    required this.status,
  });

  factory SkincareRecResponse.fromJson(Map<String, dynamic> json) {
    return SkincareRecResponse(
      message: json['message'] as String,
      response: List<String>.from(json['response'] as List),
      status: json['status'] as int,
    );
  }
}
