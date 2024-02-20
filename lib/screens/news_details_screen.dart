import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробности новости'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(article.urlToImage!)
            else
              Container(
                color: Colors.black,
                height: 200.0,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'Изображения нет',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title ?? 'Без названия',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.description ?? "Описания нет"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(article.description ?? "Контента нет"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Автор: ${article.author ?? "Неизвестно"}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Источник: ${article.source?.name ?? "Неизвестно"}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Опубликовано: ${article.publishedAt ?? "Неизвестно"}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  launchURL(article.url);
                },
                child: const Text('Подробнее в источнике'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
