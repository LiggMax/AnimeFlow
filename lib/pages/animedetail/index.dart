import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anime_flow/controllers/theme_controller.dart';
import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/services.dart';

import 'head.dart';

class AnimeDetailPage extends StatefulWidget {
  const AnimeDetailPage({super.key});

  @override
  State<AnimeDetailPage> createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Subject animeData;

  @override
  void initState() {
    super.initState();
    animeData = Get.arguments as Subject;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadView(data: animeData),
            SizedBox(height: 10),
            Column(
              children: List<Widget>.generate(105, (index) => Text('$index')),
            ),
          ],
        ),
      ),
    );
  }
}
