import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// ignore: library private types in public api
class _ProfileScreenState extends State<ProfileScreen> {
  late String _selectedTheme = 'light';

  @override
  void initState() {
    super.initState();
    _loadSelectedTheme();
  }

  Future<void> _loadSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final savedTheme = prefs.getString('selectedTheme');
      if (savedTheme != null) {
        setState(() {
          _selectedTheme = savedTheme;
        });
      } else {
        setState(() {
          _selectedTheme = 'light';
        });
      }
    } catch (e) {
      setState(() {
        _selectedTheme = 'light';
      });
    }
  }

  Future<void> _saveSelectedTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedTheme', theme);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Выберите тему:'),
          RadioListTile(
            title: const Text('Светлая'),
            value: 'light',
            groupValue: themeProvider.brightness == Brightness.light
                ? _selectedTheme
                : null,
            onChanged: (value) {
              setState(() {
                _selectedTheme = value as String;
              });
              _saveSelectedTheme(value as String);
              themeProvider.setBrightness(Brightness.light);
            },
          ),
          RadioListTile(
            title: const Text('Темная'),
            value: 'dark',
            groupValue: themeProvider.brightness == Brightness.dark
                ? _selectedTheme
                : null,
            onChanged: (value) {
              setState(() {
                _selectedTheme = value as String;
              });
              _saveSelectedTheme(value as String);
              themeProvider.setBrightness(Brightness.dark);
            },
          ),
        ],
      ),
    );
  }
}
