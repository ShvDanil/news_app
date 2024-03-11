import 'package:flutter/material.dart';
import 'package:news_app/presentation/screens/liked_new_screen.dart';
import 'package:news_app/presentation/screens/theme_selection_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Понравившиеся новости'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LikedNewsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Выбор темы'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeSelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
