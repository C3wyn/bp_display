class APIResponse<T> {
  int? statusCode;
  T? data;
  Map<String, dynamic>? error;
  Map<String, dynamic>? meta;

  bool get isSuccessfull => statusCode == 200;

  APIResponse({this.statusCode, this.data, this.error, this.meta});

  @override
  String toString() {
    if (isSuccessfull) {
      return 'Successfull';
    }
    return 'Error (${error?['status']}): ${error?['message']}';
  }
}
