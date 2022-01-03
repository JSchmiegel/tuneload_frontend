import 'package:flutter/cupertino.dart';
import 'package:tuneload/models/httpresponse.dart';
import 'package:tuneload/models/progressresponse.dart';

class ProgressProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late ProgressResponseObj _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  ProgressResponseObj get progressResponse => _response;

  setProgressResponse(HTTPResponse response, int index) {
    _response = ProgressResponseObj(response, index);
    notifyListeners();
  }
}
