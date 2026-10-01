import 'package:flutter/material.dart';

import '../../data/entities/validation_result.dart';

class ToggledTagsValidationBarWidget extends StatefulWidget {
  const ToggledTagsValidationBarWidget({super.key, required this.histogram});

  final Map<TagValidationResult, int> histogram;

  @override
  State<ToggledTagsValidationBarWidget> createState() =>
      _ToggledTagsValidationBarWidget();
}

class _ToggledTagsValidationBarWidget
    extends State<ToggledTagsValidationBarWidget> {
  late var _selectedValidations = <bool>[];
  late var _validations = <Widget>[];

  @override
  void initState() {
    setState(() {
      _selectedValidations = widget.histogram.entries
          .map((e) => false)
          .toList();
      _validations = widget.histogram.entries
          .map((e) => _createTag(e.key, e.value))
          .toList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedValidations.length; i++) {
                    if (i == index) {
                      _selectedValidations[i] = !_selectedValidations[i];
                    } else {
                      _selectedValidations[i] = false;
                    }
                  }
                });
              },
              borderRadius: const .all(Radius.circular(8)),
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedValidations,
              children: _validations,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTag(TagValidationResult result, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text("${result.label}: ${quantity.toString()}"),
    );
  }
}
