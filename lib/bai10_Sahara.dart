import 'package:flutter/material.dart';

void main() {
  runApp(const Bai10Helloworld());
}

class Bai10Helloworld extends StatelessWidget {
  const Bai10Helloworld({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LakeScreen(),
    );
  }
}

class LakeScreen extends StatelessWidget {
  const LakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1559586616-361e18714958?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Oeschinen Lake Campground',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      Icon(Icons.star, color: Colors.red),
      const Text('41'),
    ],
  ),
);

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButton(Icons.call, 'CALL'),
    _buildButton(Icons.near_me, 'ROUTE'),
    _buildButton(Icons.share, 'SHARE'),
  ],
);

Widget _buildButton(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: Colors.blue),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(color: Colors.blue)),
    ],
  );
}

Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
    'Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. '
    'A gondola ride from Kandersteg, followed by a half-hour walk through pastures '
    'and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. '
    'Activities enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
