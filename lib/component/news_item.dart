import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:um_mobile/model/news.dart';

class NewsItem extends StatefulWidget {
  final News news;
  const NewsItem({super.key, required this.news});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      height: 114,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(6),
            height: 102,
            width: 102,
            decoration: BoxDecoration(
                color: Color(0xFFE7E2E2),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${widget.news.image}"))),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("${widget.news.title}"),
                ),
                Expanded(
                    child: Text(
                  "${widget.news.getFormattedDate()}",
                  style: TextStyle(color: Color(0xFF888888)),
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
