import 'package:flutter/cupertino.dart';
import 'package:spotiload/models/httpresponse.dart';

class MatchingPageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late HTTPResponse _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  HTTPResponse get matchingResponse => _response;

  setMatchingResponse(HTTPResponse response) {
    _response = response;
    notifyListeners();
  }
}
