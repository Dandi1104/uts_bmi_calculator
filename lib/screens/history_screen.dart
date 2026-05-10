import 'package:flutter/material.dart';
import '../models/bmi_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<BMIModel> history;

  const HistoryScreen({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History BMI"),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                "BMI: ${item.bmi.toStringAsFixed(1)}",
              ),
              subtitle: Text(item.category),
              trailing: Text("${item.weight} kg"),
            ),
          );
        },
      ),
    );
  }
}