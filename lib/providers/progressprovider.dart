import 'package:flutter/cupertino.dart';
import 'package:spotiload/models/httpresponse.dart';

class ProgressProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late HTTPResponse _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  HTTPResponse get progressResponse => _response;

  setProgressResponse(HTTPResponse response) {
    _response = response;
    notifyListeners();
  }
}
