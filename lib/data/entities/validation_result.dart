import 'package:flutter/material.dart';

enum TagsValidationResult {
  emptyTags(
    description: "Tags field is empty",
    background: Color(0xFFEF9A9A),
    foreground: Colors.red,
  ),
  invalidFormatTagsFormat(
    description: "Tags field has invalid format",
    background: Color(0xFFFFF59D),
    foreground: Colors.yellow,
  ),
  nonUniqueSourceTag(
    description: "Source tag must be unique",
    background: Color(0xFFFFCC80),
    foreground: Colors.orange,
  ),
  nonUniqueTmdbIdTag(
    description: "TMDB ID tag must be unique",
    background: Color(0xFFF48FB1),
    foreground: Colors.pink,
  ),
  missingGenreTag(
    description: "No genre tag found",
    background: Color(0xFFCE93D8),
    foreground: Colors.purple,
  ),
  validTagsField(
    description: "Tags are valid",
    background: Color(0xFFA5D6A7),
    foreground: Colors.green,
  );

  final String description;
  final Color? background;
  final Color foreground;

  const TagsValidationResult({
    required this.description,
    required this.background,
    required this.foreground,
  });
}
