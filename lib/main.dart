import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_anime/routes/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: "/",
      routes: getRootRoutes(),
    ),
  );
}
