import 'package:flutter/cupertino.dart';
import 'package:spotiload/models/errorresponse.dart';
import 'package:spotiload/models/httpresponse.dart';

class ErrorPageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late ErrorResponseObj _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  ErrorResponseObj get progressResponse => _response;

  setErrorResponse(HTTPResponse response, int index) {
    _response = ErrorResponseObj(response, index);
    notifyListeners();
  }
}
