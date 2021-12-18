import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProgressPageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late http.Response _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  http.Response get initResponse => _response;

  setInitResponse(http.Response response) {
    _response = response;
    notifyListeners();
  }
}
