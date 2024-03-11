import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/presentation/providers/theme_provider.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор темы'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: Brightness.light,
                  groupValue: themeProvider.brightness,
                  onChanged: (value) {
                    themeProvider.setBrightness(Brightness.light);
                  },
                ),
                const Text('Светлая тема'),
                const SizedBox(width: 16),
                Radio(
                  value: Brightness.dark,
                  groupValue: themeProvider.brightness,
                  onChanged: (value) {
                    themeProvider.setBrightness(Brightness.dark);
                  },
                ),
                const Text('Темная тема'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
