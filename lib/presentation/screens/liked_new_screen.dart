import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/presentation/providers/liked_news_interactor.dart';
import 'package:news_app/presentation/providers/news_provider.dart';
import 'package:news_app/presentation/screens/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:news_app/presentation/components/news_cell_component.dart';

class LikedNewsScreen extends StatelessWidget {
  const LikedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likedNewsInteractor = GetIt.instance<LikedNewsInteractor>();
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Понравившиеся новости'),
      ),
      body: FutureBuilder<List<int>>(
        future: likedNewsInteractor.loadLikedArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error.toString()}'));
          } else {
            final likedArticles = snapshot.data ?? [];

            return likedArticles.isEmpty
                ? const Center(
                    child:
                        Text('Упс, кажется, понравившихся новостей нет(( 😢'),
                  )
                : ListView.builder(
                    itemCount: likedArticles.length,
                    itemBuilder: (context, index) {
                      final articleIndex = likedArticles[index];
                      final article = newsProvider.articles[articleIndex];

                      return NewsListTile(
                        title: article.title ?? 'No title',
                        subtitle: article.source?.name ?? 'No source',
                        isLiked: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailsScreen(article: article),
                            ),
                          );
                        },
                        onLikePressed: () {
                          likedNewsInteractor.removeLikedArticle(articleIndex);
                          newsProvider.updateLikeStatus(articleIndex, false);
                        },
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
