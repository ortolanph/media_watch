import 'package:flutter/material.dart';

class PosterButton extends StatelessWidget {
  const PosterButton({
    super.key,
    required this.asset,
    required this.targetRoute,
  });

  final String asset;
  final String targetRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: _renderButton(context),
    );
  }

  Widget _renderButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, targetRoute);
      },
      child: Image(width: 384, height: 384, image: AssetImage(asset)),
    );
  }
}
