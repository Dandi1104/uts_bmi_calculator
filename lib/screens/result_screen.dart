import 'package:flutter/material.dart';
import '../models/bmi_model.dart';

class ResultScreen extends StatelessWidget {

  final BMIModel result;

  const ResultScreen({
    required this.result,
  });

  Color getColor() {

    if (result.category == 'Kurus') {
      return Colors.blue;
    }

    else if (result.category == 'Normal') {
      return Colors.green;
    }

    else if (result.category == 'Gemuk') {
      return Colors.orange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Hasil BMI'),
      ),

      body: Center(

        child: Card(

          elevation: 10,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          child: Padding(

            padding: EdgeInsets.all(30),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                Text(

                  result.bmi.toStringAsFixed(1),

                  style: TextStyle(
                    fontSize: 50,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Text(

                  result.category,

                  style: TextStyle(
                    fontSize: 30,
                    color: getColor(),
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}