import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/models/article_model.dart';
import '../screens/news_details_screen.dart';
import 'package:logger/logger.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новостная лента'),
      ),
      body: const NewsList(),
    );
  }
}

// ignore: library private types in public api
class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final NewsService newsService = NewsService();
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    try {
      final articles = await newsService.getNews(
          'a0bd7b3d69c64d3780be01d584e81efc', 'apple');
      if (articles != null && articles.isNotEmpty) {
        provider.setArticles(articles);
      }
    } catch (error) {
      _logger.e('Error fetching data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>?>(
      future: newsService.getNews('a0bd7b3d69c64d3780be01d584e81efc', 'apple'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          if (snapshot.data == null) {
            return const Center(
                child: Text(
                    'Ошибка авторизации. Пожалуйста, проверьте ваш API ключ.'));
          }
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Не удалось загрузить новости.'));
        } else {
          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsListItem(article: article);
            },
          );
        }
      },
    );
  }
}

class NewsListItem extends StatelessWidget {
  final Article article;

  const NewsListItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title ?? 'Нет заголовка'),
      subtitle: Text(article.source?.name ?? 'Нет источника'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(article: article),
          ),
        );
      },
    );
  }
}
