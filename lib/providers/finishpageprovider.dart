import 'package:flutter/cupertino.dart';
import 'package:tuneload/models/httpresponse.dart';

class FinishPageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late HTTPResponse _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  HTTPResponse get progressResponse => _response;

  setFinishResponse(HTTPResponse response) {
    _response = response;
    notifyListeners();
  }
}
