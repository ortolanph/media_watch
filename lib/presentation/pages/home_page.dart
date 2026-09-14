import 'package:flutter/material.dart';
import 'package:media_watch/presentation/widgets/poster_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PosterButton(asset: "assets/images/movie_icon.png", targetRoute: "/movies",),
            PosterButton(asset: "assets/images/tv_show_icon.png", targetRoute: "/shows",),
          ],
        ),
      ),
    );
  }
}
