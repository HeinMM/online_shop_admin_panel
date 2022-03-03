import 'package:flutter/cupertino.dart';

class DesignInjection extends ChangeNotifier {
  int _currentIndex = 0;

  int getCurrentIndex() {
    return _currentIndex;
  }

  setCurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
  }
}
