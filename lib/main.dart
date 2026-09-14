import 'package:flutter/material.dart';
import 'package:media_watch/presentation/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Media Watch",
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
      },
    )
  );
}
