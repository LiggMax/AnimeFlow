import 'package:flutter/material.dart';
import 'package:my_anime/routes/index.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: "/",
      routes: getRootRoutes(),
    ),
  );
}
