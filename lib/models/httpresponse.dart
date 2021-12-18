class HTTPResponse<T> {
  bool isSuccessful;
  T data;
  String? message;
  int? statusCode;

  HTTPResponse(this.isSuccessful, this.data, {this.message, this.statusCode});
}
