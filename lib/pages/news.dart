import 'package:flutter/material.dart';
import 'package:tms/widgets/text.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: text(text: 'ข่าวสาร'),
    );
  }
}
