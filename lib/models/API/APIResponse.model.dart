class APIResponse<T> {
  T? data;
  Map<String, dynamic>? error;
  Map<String, dynamic>? meta;

  bool get isSuccessfull => error == null;

  APIResponse({
    this.data,
    this.error,
    this.meta
  });

  @override
  String toString() {
    if(isSuccessfull) {
      return 'Successfull';
    }
    return 'Error (${error?['status']}): ${error?['message']}';
  }
}