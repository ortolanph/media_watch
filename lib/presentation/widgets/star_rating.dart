import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating});

  final double rating;
  static const int _ratingStars = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          _calculateFilledStars(rating),
          (_) => Icon(Icons.star, size: 24.0, color: Colors.amber),
        ),
        ...List.generate(
          _calculateHalfStars(rating),
          (_) => Icon(Icons.star_half, size: 24.0, color: Colors.amber),
        ),
        ...List.generate(
          _calculateEmptyStars(rating),
          (_) => Icon(Icons.star_border, size: 24.0, color: Colors.amber),
        ),
      ],
    );
  }

  int _calculateFilledStars(double rating) {
    return rating.floor();
  }

  int _calculateHalfStars(double rating) {
    return rating.ceil() - rating.floor();
  }

  int _calculateEmptyStars(double rating) {
    return _ratingStars -
        _calculateFilledStars(rating) -
        _calculateHalfStars(rating);
  }
}
