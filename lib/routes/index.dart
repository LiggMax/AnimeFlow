import 'package:flutter/material.dart';
import 'package:my_anime/pages/Login/index.dart';

import '../pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {"/": (context) => MainPage(), "/login": (context) => LoginPage()};
}
