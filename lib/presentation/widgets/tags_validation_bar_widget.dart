import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/main.dart';

class TagsValidationBarWidget extends StatefulWidget {
  const TagsValidationBarWidget({super.key, required this.histogram});

  final Map<TagValidationResult, int> histogram;

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
              TagValidationResult.emptyTags,
              widget.histogram[TagValidationResult.emptyTags] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.invalidTagsFormat,
              widget.histogram[TagValidationResult.invalidTagsFormat] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.missingSourceTag,
              widget.histogram[TagValidationResult.missingSourceTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.nonUniqueSourceTag,
              widget.histogram[TagValidationResult.nonUniqueSourceTag] ?? 0,
            ),
            _createTag(
              TagValidationResult.missingTMDBIDTag,
              widget.histogram[TagValidationResult.missingTMDBIDTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.nonUniqueTmdbIdTag,
              widget.histogram[TagValidationResult.nonUniqueTmdbIdTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.missingGenreTag,
              widget.histogram[TagValidationResult.missingGenreTag] ?? 0,
            ),
            _divider(),
            _createTag(
              TagValidationResult.validTagsField,
              widget.histogram[TagValidationResult.validTagsField] ?? 0,
            ),
            _divider(),
            IconButton(
              onPressed: () {
                String tableData =
                    "label,description,${dateFormat.format(DateTime.now())}\n";

                for (var histData in widget.histogram.entries) {
                  tableData =
                      "$tableData${histData.key.label},$tableData${histData.key.description},${histData.value}\n";
                }

                var clipData = ClipboardData(text: tableData);
                Clipboard.setData(clipData);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Dados de validação de tags copiados para a Área de Transferência!",
                    ),
                  ),
                );
              },
              tooltip: "Copiar para Clipboard",
              icon: Icon(Icons.copy),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return VerticalDivider(width: 10, thickness: 2, color: Colors.black);
  }

  Widget _createTag(TagValidationResult result, int? quantity) {
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
            "${result.label}: ${quantity.toString()}",
            style: TextStyle(
              backgroundColor: result.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
