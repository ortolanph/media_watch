import 'package:flutter/material.dart';
import 'package:media_watch/data/entities/validation_result.dart';

class TagsValidationBarWidget extends StatefulWidget {
  const TagsValidationBarWidget({super.key, required this.histogram});

  final Map<TagsValidationResult, int> histogram;

  @override
  State<TagsValidationBarWidget> createState() =>
      _TagsValidationBarWidgetState();
}

class _TagsValidationBarWidgetState extends State<TagsValidationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _createTag(
              TagsValidationResult.emptyTags,
              widget.histogram[TagsValidationResult.emptyTags] ?? 0,
            ),
            _divider(),
            _createTag(
              TagsValidationResult.invalidTagsFormat,
              widget.histogram[TagsValidationResult.invalidTagsFormat] ?? 0,
            ),
            _divider(),
            _createTag(
              TagsValidationResult.nonUniqueSourceTag,
              widget.histogram[TagsValidationResult.nonUniqueSourceTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagsValidationResult.nonUniqueTmdbIdTag,
              widget.histogram[TagsValidationResult.nonUniqueTmdbIdTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagsValidationResult.missingGenreTag,
              widget.histogram[TagsValidationResult.missingGenreTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagsValidationResult.validTagsField,
              widget.histogram[TagsValidationResult.validTagsField] ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return VerticalDivider(width: 10, thickness: 2, color: Colors.black);
  }

  Widget _createTag(TagsValidationResult result, int? quantity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: result.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "${result.name}: ${quantity.toString()}",
            style: TextStyle(backgroundColor: result.background),
          ),
        ),
      ),
    );
  }
}
