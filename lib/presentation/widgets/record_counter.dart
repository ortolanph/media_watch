import 'package:flutter/material.dart';

class RecordCounter extends StatelessWidget {
  const RecordCounter({super.key, required this.recordCount});

  final int recordCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        "$recordCount records",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
