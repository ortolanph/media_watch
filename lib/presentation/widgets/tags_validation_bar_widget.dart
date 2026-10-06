import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/data/enums/report_template_names.dart';
import 'package:media_watch/main.dart';
import 'package:media_watch/services/template_service.dart';

class TagsValidationBarWidget extends StatefulWidget {
  const TagsValidationBarWidget({super.key, required this.histogram});

  final Map<TagValidationResult, int> histogram;

  @override
  State<TagsValidationBarWidget> createState() =>
      _TagsValidationBarWidgetState();
}

class _TagsValidationBarWidgetState extends State<TagsValidationBarWidget> {
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
              TagValidationResult.values
                  .map(
                    (element) =>
                        _createTag(element, widget.histogram[element] ?? 0),
                  )
                  .toList()
                ..add(_divider())
                ..add(_createCopyButton(context)),
        ),
      ),
    );
  }

  IconButton _createCopyButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        var templateFile = ReportTemplateNames.tagValidation.prefix;
        Map<String, Object> data = {
          'timestamp': dateFormat.format(DateTime.now()).toString(),
          'validations': widget.histogram.entries
              .map(
                (h) => {
                  'label': h.key.label,
                  'description': h.key.description,
                  'quantity': h.value,
                },
              )
              .toList(),
        };

        var clipData = ClipboardData(
          text: await _templateService.render(templateFile, data),
        );
        await Clipboard.setData(clipData);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Dados de validação de tags copiados para a Área de Transferência!",
              ),
            ),
          );
        }
      },
      tooltip: "Copiar para Clipboard",
      icon: Icon(Icons.copy),
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
