import 'package:flutter/material.dart';

void main() {
  runApp(CounterApp());
}

// Ứng dụng gốc của Bài 1
class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CounterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Màn hình chính của Bài 1
class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Biến state để lưu giá trị đếm
  int _counter = 0;

  // Hàm tăng
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  // Hàm giảm (theo yêu cầu)
  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  // Hàm reset (theo yêu cầu)
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  // Hàm quyết định màu chữ (theo yêu cầu "Màu chữ thay đổi")
  Color _getTextColor() {
    if (_counter < 0) {
      return Colors.red; // Số âm
    } else if (_counter > 0) {
      return Colors.green; // Số dương
    } else {
      return Colors.black; // Số 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài 1: Ứng dụng Đếm Số'),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true, // <-- SỬA Ở ĐÂY: Đã thêm để căn giữa tiêu đề
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Giá trị hiện tại:',
              style: TextStyle(fontSize: 24, color: Colors.grey.shade700),
            ),
            // Văn bản hiển thị số đếm, áp dụng màu động
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _getTextColor(), // Áp dụng màu tại đây
              ),
            ),
            SizedBox(height: 30),
            // Hàng chứa các nút bấm
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút Giảm (như trong ảnh)
                ElevatedButton.icon(
                  icon: Icon(Icons.remove),
                  label: Text('Giảm'),
                  onPressed: _decrement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    foregroundColor: Colors.red.shade900,
                  ),
                ),
                SizedBox(width: 12),
                // Nút Đặt lại (Reset) (như trong ảnh)
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Đặt lại'),
                  onPressed: _reset,
                ),
                SizedBox(width: 12),
                // Nút Tăng (như trong ảnh)
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Tăng'),
                  onPressed: _increment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    foregroundColor: Colors.green.shade900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}