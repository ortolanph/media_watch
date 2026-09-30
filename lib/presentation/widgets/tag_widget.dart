import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/entities/tag_data.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({super.key, required this.tagData});

  final TagData tagData;

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
                onPressed: () {
                  String document = "# ${tagData.label}\n\n";

                  for (var value in tagData.values) {
                    document = "$document * $value\n";
                  }

                  ClipboardData data = ClipboardData(text: document);
                  Clipboard.setData(data);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Dados da tag ${tagData.label} copiados para a Área de Transferência!",
                      ),
                    ),
                  );
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
