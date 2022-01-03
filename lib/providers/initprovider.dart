import 'package:flutter/cupertino.dart';
import 'package:tuneload/models/httpresponse.dart';

class InitProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late HTTPResponse _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  HTTPResponse get initResponse => _response;

  setInitResponse(HTTPResponse response) {
    _response = response;
    notifyListeners();
  }
}
