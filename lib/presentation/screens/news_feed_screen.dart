// news_feed_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/presentation/providers/news_provider.dart';
import 'package:news_app/domain/article_model.dart';
import 'package:logger/logger.dart';
import 'package:news_app/presentation/providers/liked_news_interactor.dart';
import 'package:news_app/di/di.dart';
import 'package:news_app/domain/news_interactor.dart';
import 'package:news_app/presentation/components/news_cell_component.dart';
import 'package:news_app/presentation/screens/news_details_screen.dart';

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

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Article>?> fetchData() async {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    final newsInteractor = DiContainer.get<NewsInteractor>();

    try {
      final articles = await newsInteractor.getNews(
          'a0bd7b3d69c64d3780be01d584e81efc', 'apple');

      if (articles != null && articles.isNotEmpty) {
        provider.setArticles(articles);
      }
      return articles;
    } catch (error, stackTrace) {
      _logger.e('Error fetching data');
      _logger.e(stackTrace.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>?>(
      future: fetchData(),
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
              return NewsListItem(article: article, index: index);
            },
          );
        }
      },
    );
  }
}

class NewsListItem extends StatefulWidget {
  final Article article;
  final int index;

  const NewsListItem({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  _NewsListItemState createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  bool isLiked = false;
  final likedNewsInteractor = DiContainer.get<LikedNewsInteractor>();

  @override
  void initState() {
    super.initState();
    final likedNewsInteractor = DiContainer.get<LikedNewsInteractor>();
    isLiked = likedNewsInteractor.likedArticles.contains(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return NewsListTile(
      title: widget.article.title ?? 'Нет заголовка',
      subtitle: widget.article.source?.name ?? 'Нет источника',
      isLiked: isLiked,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(article: widget.article),
          ),
        );
      },
      onLikePressed: () {
        setState(() {
          isLiked = !isLiked;
        });
        if (isLiked) {
          likedNewsInteractor.addLikedArticle(widget.index);
        } else {
          likedNewsInteractor.removeLikedArticle(widget.index);
        }
        provider.updateLikeStatus(widget.index, isLiked);
      },
    );
  }
}
