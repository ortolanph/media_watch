import 'package:flutter/material.dart';
import 'package:media_watch/presentation/widgets/poster_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                "Media Watch",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "O que você quer ver hoje?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Expanded(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Stack vertically on narrow screens, side-by-side otherwise.
                      final isWide = constraints.maxWidth > 480;

                      final buttons = [
                        PosterButton(
                          asset: "assets/images/movie_icon.png",
                          targetRoute: "/movies",
                        ),
                        PosterButton(
                          asset: "assets/images/tv_show_icon.png",
                          targetRoute: "/shows",
                        ),
                      ];

                      return isWide
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttons[0],
                                const SizedBox(width: 24),
                                buttons[1],
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttons[0],
                                const SizedBox(height: 24),
                                buttons[1],
                              ],
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
