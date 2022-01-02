import 'package:flutter/cupertino.dart';
import 'package:spotiload/models/finishresponse.dart';
import 'package:spotiload/models/httpresponse.dart';

class FinishPageProvider extends ChangeNotifier {
  bool _isProcessing = true;
  late FinishResponseObj _response;

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  FinishResponseObj get progressResponse => _response;

  setFinishResponse(HTTPResponse response, int index) {
    _response = FinishResponseObj(response, index);
    notifyListeners();
  }
}
