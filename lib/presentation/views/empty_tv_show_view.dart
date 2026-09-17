import 'package:flutter/material.dart';

class EmptyTvShowView extends StatelessWidget {
  const EmptyTvShowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: const Text(
          "Nenhum TV Show aqui, adicione ou importe alguns ou redefina sua busca!",
        ),
      ),
    );
  }
}
