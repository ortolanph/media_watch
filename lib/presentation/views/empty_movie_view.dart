import 'package:flutter/material.dart';

class EmptyMovieView extends StatelessWidget {
  const EmptyMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: const Text("Nenhum Filme aqui! Importe o arquivo para visualizar a sua jornada!"),
      ),
    );
  }
}
