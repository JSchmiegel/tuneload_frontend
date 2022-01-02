import 'package:spotiload/models/httpresponse.dart';

class ErrorResponseObj {
  HTTPResponse httpResponse;
  int index;

  ErrorResponseObj(this.httpResponse, this.index);
}
