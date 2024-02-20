import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  void setBrightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}
