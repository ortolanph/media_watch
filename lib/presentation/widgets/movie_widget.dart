import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/services/tag_validation_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/entities/movie.dart';

class MovieWidget extends StatelessWidget {
  MovieWidget({super.key, required this.movie});

  final Movie movie;

  final TagValidationService _tagValidationService = TagValidationService();
  late TagsValidationResult _validationResult;

  @override
  StatelessElement createElement() {
    _validationResult = _tagValidationService.checkMovieTags(movie.tags);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: _validationResult.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: _validationResult.foreground, width: 4.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: _formatTitle(
                movie.movieName,
                movie.year,
                movie.letterboxURI,
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _formatDate(
                          Icons.calendar_today_outlined,
                          movie.entryDate,
                        ),
                        _formatDate(Icons.remove_red_eye, movie.watchedDate),
                        _formatRewatch(movie.rewatch),
                      ],
                    ),
                    Row(children: [_formatTags(movie.tags)]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _validationResult.description,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatTitle(String name, int year, String tmdbURI) {
    return RichText(
      text: TextSpan(
        text: "$name ($year)",
        style: new TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        recognizer: new TapGestureRecognizer()
          ..onTap = () {
            launchUrlString(tmdbURI);
          },
      ),
    );
  }

  Widget _formatDate(IconData icon, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(icon),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _formatRewatch(bool rewatch) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        rewatch ? Icons.thumb_up_alt_outlined : Icons.thumb_down_alt_outlined,
      ),
    );
  }

  Widget _formatTags(String tags) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Icon(Icons.label_important_outline),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(tags),
          ),
        ],
      ),
    );
  }
}
