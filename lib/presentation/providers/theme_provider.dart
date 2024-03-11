import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  Brightness _brightness = Brightness.light;
  final String _themeKey = 'selectedTheme';

  Brightness get brightness => _brightness;

  ThemeProvider() {
    _loadSelectedTheme();
  }

  Future<void> _loadSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      _brightness = savedTheme == 'light' ? Brightness.light : Brightness.dark;
    }
    notifyListeners();
  }

  Future<void> setBrightness(Brightness newBrightness) async {
    _brightness = newBrightness;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        _themeKey, _brightness == Brightness.light ? 'light' : 'dark');
  }
}
