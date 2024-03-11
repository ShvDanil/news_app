import 'package:flutter/material.dart';

class NewsListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isLiked;
  final VoidCallback onTap;
  final VoidCallback onLikePressed;

  const NewsListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isLiked,
    required this.onTap,
    required this.onLikePressed,
  }) : super(key: key);

  @override
  _NewsListTileState createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: widget.onLikePressed,
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}
