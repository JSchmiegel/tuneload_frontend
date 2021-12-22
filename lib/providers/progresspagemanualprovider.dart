import 'package:flutter/cupertino.dart';
import 'package:spotiload/models/httpresponse.dart';

class ProgressPageManualProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late HTTPResponse _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  HTTPResponse get progressManualResponse => _response;

  setProgressManualResponse(HTTPResponse response) {
    _response = response;
    notifyListeners();
  }
}
