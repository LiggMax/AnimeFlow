import 'package:flutter/material.dart';
import 'package:my_anime/pages/test/StickyCategoryPage.dart';
import 'package:my_anime/pages/Login/index.dart';
import 'package:my_anime/pages/animedetail/index.dart';

import '../pages/Main/index.dart';

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(),
    "/login": (context) => LoginPage(),
    "/anime_detail": (context) => AnimeDetailPage(),
    "/sticky_category": (context) => StickyCategoryPage(),
  };
}
