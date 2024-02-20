import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/news_feed_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'News App',
            theme: ThemeData(
              brightness: themeProvider.brightness,
            ),
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('News App'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Новости'),
                      Tab(text: 'Профиль'),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    NewsFeedScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
