class APIResponse<T> {
  int statusCode;
  String? message;
  T? data;

  APIResponse({
    this.statusCode = 200,
    this.message,
    this.data
  });
}