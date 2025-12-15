import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const DoiMauApp());

class DoiMauApp extends StatelessWidget {
  const DoiMauApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManHinhDoiMau(),
    );
  }
}

class ManHinhDoiMau extends StatefulWidget {
  const ManHinhDoiMau({super.key});

  @override
  State<ManHinhDoiMau> createState() => _ManHinhDoiMauState();
}

class _ManHinhDoiMauState extends State<ManHinhDoiMau> {
  Color _mauNen = Colors.purple;
  String _tenMau = "Tím";

  final List<Color> _cacMau = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.pink,
    Colors.cyan,
    Colors.purple,
    Colors.brown,
    Colors.teal
  ];

  final List<String> _tenCacMau = [
    "Đỏ",
    "Xanh lá",
    "Xanh dương",
    "Cam",
    "Vàng",
    "Hồng",
    "Xanh ngọc",
    "Tím",
    "Nâu",
    "Xanh đậm"
  ];

  void _doiMau() {
    final random = Random();
    int index = random.nextInt(_cacMau.length);
    setState(() {
      _mauNen = _cacMau[index];
      _tenMau = _tenCacMau[index];
    });
  }

  void _datLai() {
    setState(() {
      _mauNen = Colors.purple;
      _tenMau = "Tím";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎨 Ứng dụng Đổi màu nền"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        color: _mauNen,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Màu hiện tại",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                _tenMau,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _doiMau,
                    icon: const Icon(Icons.color_lens),
                    label: const Text("Đổi màu"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _datLai,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Đặt lại"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
