import 'package:flutter/material.dart';
import 'package:news_app/presentation/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_app/presentation/screens/news_feed_screen.dart';
import 'package:news_app/presentation/screens/profile_screen.dart';
import 'package:news_app/presentation/providers/theme_provider.dart';
import 'package:news_app/di/di.dart';
import 'package:news_app/presentation/providers/liked_news_interactor.dart';

void main() {
  DiContainer.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => DiContainer.get<NewsProvider>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'News App',
            theme: ThemeData(
              brightness: themeProvider.brightness,
            ),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    DiContainer.get<LikedNewsInteractor>().loadLikedArticles();
  }

  @override
  void dispose() {
    DiContainer.get<LikedNewsInteractor>().saveLikedArticles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
    );
  }
}
