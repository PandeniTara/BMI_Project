import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String _gender = "Laki-laki";
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double? bmi;
  String category = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      double heightInMeters = height / 100;
      setState(() {
        bmi = weight / (heightInMeters * heightInMeters); //rumus

        category = getBMICategory(bmi!);
      });
    } else {
      setState(() {
        bmi = null;
        category = "Masukkan angka yang valid!";
      });
    }
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Kurus";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Gemuk";
    } else {
      return "Obesitas";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator BMI"),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,),

      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pilih Jenis Kelamin:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                    // Pilihan Gender
                    Row(
                      children: [
                        Radio(
                          value: "Laki-laki",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                        Text("Laki-laki"),
                        SizedBox(width: 20),
                        Radio(
                          value: "Perempuan",
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                        Text("Perempuan"),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Input Berat Badan
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Berat Badan (kg)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Input Tinggi Badan
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Tinggi Badan (cm)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.height),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Tombol Hitung BMI
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: calculateBMI,
                        child: Text("Hitung BMI",
                            style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Hasil BMI
                    if (bmi != null) ...[
                      Divider(thickness: 1),
                      Center(
                        child: Column(
                          children: [
                            Text("BMI Anda:",
                                style: TextStyle(fontSize: 18)),
                            Text(
                              "${bmi!.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700),
                            ),
                            SizedBox(height: 5),
                            Text("Kategori: $category",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
