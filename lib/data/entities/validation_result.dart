import 'package:flutter/material.dart';

enum TagValidationResult {
  emptyTags(
    description: "Tags field is empty",
    label: "EMPTY",
    background: Color(0xFFEF9A9A),
    foreground: Colors.red,
  ),
  invalidTagsFormat(
    description: "Tags field has invalid format",
    label: "INVALID FORMAT",
    background: Color(0xFFFFF59D),
    foreground: Colors.yellow,
  ),
  missingSourceTag(
    description: "`source` tag is missing",
    label: "NO SOURCE",
    background: Color(0xFF80DEEA),
    foreground: Colors.cyan,
  ),
  nonUniqueSourceTag(
    description: "Source tag must be unique",
    label: "SOURCE NOT UNIQUE",
    background: Color(0xFFFFCC80),
    foreground: Colors.orange,
  ),
  missingTMDBIDTag(
    description: "`tmdb_id` tag is missing",
    label: "NO TMDB_ID",
    background: Color(0xFFE48D73),
    foreground: Color(0xFFAB4E2F),
  ),
  nonUniqueTmdbIdTag(
    description: "TMDB ID tag must be unique",
    label: "TMDB_ID NOT UNIQUE",
    background: Color(0xFFF48FB1),
    foreground: Colors.pink,
  ),
  missingGenreTag(
    description: "No genre tag found",
    label: "NO GENRE",
    background: Color(0xFFCE93D8),
    foreground: Colors.purple,
  ),
  validTagsField(
    description: "Tags are valid",
    label: "VALID",
    background: Color(0xFFA5D6A7),
    foreground: Colors.green,
  );

  final String description;
  final String label;
  final Color? background;
  final Color foreground;

  const TagValidationResult({
    required this.description,
    required this.label,
    required this.background,
    required this.foreground,
  });
}
