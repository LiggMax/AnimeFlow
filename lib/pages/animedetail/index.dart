import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_anime/models/hot_item.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  Subject? _animeData;

  @override
  void initState() {
    super.initState();
    _animeData = Get.arguments as Subject;
  }

  @override
  Widget build(BuildContext context) {
    final data = _animeData!;
    return Scaffold(
      appBar: AppBar(title: Text(data.nameCN ?? data.name)),
      body: Center(child: Text('Anime Detail Page')),
    );
  }
}
