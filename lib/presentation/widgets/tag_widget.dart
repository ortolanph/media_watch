import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_watch/data/enums/report_template_names.dart';
import 'package:media_watch/services/template_service.dart';

import '../../data/entities/tag_data.dart';

class TagWidget extends StatelessWidget {
  TagWidget({super.key, required this.tagData});

  final TagData tagData;
  final TemplateService _templateService = TemplateService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: Text(
                tagData.label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: _formatValues(tagData.values),
              trailing: IconButton(
                onPressed: () async {
                  var templateFile = ReportTemplateNames.tagReport.prefix;

                  Map<String, Object> data = {
                    'label': tagData.label,
                    'values': tagData.values.toList(),
                  };

                  final text = await _templateService.render(
                    templateFile,
                    data,
                  );
                  await Clipboard.setData(ClipboardData(text: text));

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Dados da tag ${tagData.label} copiados para a Área de Transferência!",
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.copy),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatValues(Set<String> values) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: values.map((v) => Chip(label: Text(v))).toList(),
    );
  }
}
