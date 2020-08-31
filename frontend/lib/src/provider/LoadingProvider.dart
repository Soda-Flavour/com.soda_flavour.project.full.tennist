import 'package:flutter/foundation.dart';

class LoadingProvider with ChangeNotifier {
  bool isLoading = false;

  get getIsLoading => isLoading;

  void setIsLoading() {
    isLoading = true;
    notifyListeners();
  }

  void setEndLoading() {
    isLoading = false;
    notifyListeners();
  }
}
