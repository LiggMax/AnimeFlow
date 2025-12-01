import 'package:anime_flow/pages/play/index.dart';
import 'package:flutter/material.dart';
import 'package:anime_flow/pages/Login/index.dart';
import 'package:anime_flow/pages/anime_detail/index.dart';

import '../pages/Main/index.dart';

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(),
    "/login": (context) => LoginPage(),
    "/anime_detail": (context) => AnimeDetailPage(),
    "/play": (context) => PlayPage()
  };
}
