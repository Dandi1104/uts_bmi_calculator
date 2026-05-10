import 'package:flutter/material.dart';
import '../models/bmi_model.dart';
import '../widgets/custom_textfield.dart';
import 'result_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController heightController =
      TextEditingController();

  List<BMIModel> history = [];

  late AnimationController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..forward();
  }

  void calculateBMI() {

    if (weightController.text.isEmpty ||
        heightController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Input tidak boleh kosong',
          ),
        ),
      );

      return;
    }

    double weight =
        double.parse(weightController.text);

    double height =
        double.parse(heightController.text) / 100;

    double bmi =
        weight / (height * height);

    String category = '';

    if (bmi < 18.5) {
      category = 'Kurus';
    } else if (bmi < 25) {
      category = 'Ideal';
    } else if (bmi < 30) {
      category = 'Gemuk';
    } else {
      category = 'Obesitas';
    }

    BMIModel result = BMIModel(
      bmi: bmi,
      category: category,
      weight: weight,
      height: height,
    );

    history.add(result);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });

          if (index == 1) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HistoryScreen(
                  history: history,
                ),
              ),
            );
          }
        },

        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),

      body: Container(

        width: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(

          child: Padding(

            padding: EdgeInsets.all(20),

            child: Column(

              children: [

                SizedBox(height: 30),

                Icon(
                  Icons.monitor_weight,
                  size: 120,
                  color: Colors.white,
                ),

                SizedBox(height: 20),

                Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 40),

                CustomTextField(
                  hint: 'Berat Badan (kg)',
                  icon: Icons.scale,
                  controller: weightController,
                ),

                SizedBox(height: 20),

                CustomTextField(
                  hint: 'Tinggi Badan (cm)',
                  icon: Icons.height,
                  controller: heightController,
                ),

                SizedBox(height: 40),

                ScaleTransition(

                  scale: _controller,

                  child: SizedBox(

                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            Colors.white,

                        foregroundColor:
                            Colors.blue,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),

                      onPressed: calculateBMI,

                      child: Text(
                        'Hitung BMI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
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