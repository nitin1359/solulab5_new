class ApiResponse {
  final dynamic data;
  final String message;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        data: json['data'],
        message: json['message'] as String,
        status: json['status'] as int,
      );
}