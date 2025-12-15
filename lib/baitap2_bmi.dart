import 'package:flutter/material.dart';




class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? bmi;
  String classification = '';

  void calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      final double result = weight / (height * height);

      setState(() {
        bmi = result;

        if (bmi! < 18.5) {
          classification = 'Gầy';
        } else if (bmi! < 25) {
          classification = 'Bình thường';
        } else if (bmi! < 30) {
          classification = 'Thừa cân';
        } else {
          classification = 'Béo phì';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Chiều cao (m)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: calculateBMI,
              icon: const Icon(Icons.calculate),
              label: const Text('Tính BMI'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
            const SizedBox(height: 30),
            if (bmi != null) ...[
              Text(
                'Chỉ số BMI: ${bmi!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Phân loại: $classification',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
