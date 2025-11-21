class ApiError {
  final String? error;
  final String? message;

  // ignore: prefer_constructors_over_static_methods
  static ApiError fromJson(Map<String, dynamic> json) {
    return ApiError(
      error: json['error'],
      message: json['message'],
    );
  }

  ApiError({
    this.error,
    this.message,
  });
}
