import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Để dùng TextInputFormatter
import 'dart:async'; // Để dùng Timer

void main() {
  runApp(TimerApp());
}

// Ứng dụng gốc của Bài 2
class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TimerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Màn hình chính của Bài 2
class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // 1. Dùng TextEditingController cho ô nhập liệu (theo gợi ý)
  final TextEditingController _controller = TextEditingController();
  
  // Biến Timer từ dart:async (theo gợi ý)
  Timer? _timer;
  
  // Biến state để lưu số giây còn lại
  int _remainingSeconds = 0;
  
  // Biến state để biết timer đang chạy hay không
  bool _isRunning = false;

  @override
  void dispose() {
    // 3. Hủy Timer trong dispose để tránh rò rỉ bộ nhớ (theo gợi ý)
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // Hàm bắt đầu đếm ngược (yêu cầu 2)
  void _startTimer() {
    // Lấy số giây từ ô nhập liệu
    int? seconds = int.tryParse(_controller.text);
    if (seconds == null || seconds <= 0) {
      // Nếu nhập không hợp lệ thì không làm gì
      return;
    }

    setState(() {
      _remainingSeconds = seconds;
      _isRunning = true;
    });

    // Hủy timer cũ nếu có
    _timer?.cancel();

    // 2. Dùng Timer.periodic() (theo gợi ý)
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--; // Mỗi giây giảm 1
        } else {
          // Khi hết giờ
          _timer?.cancel(); // Dừng timer
          _isRunning = false;
          _showTimeUpDialog(); // Hiển thị thông báo
        }
      });
    });
  }

  // Hàm reset timer (như nút Đặt lại trong ảnh)
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
      _controller.clear(); // Xóa chữ trong ô nhập
      _isRunning = false;
    });
  }

  // Hàm hiển thị thông báo "Hết thời gian!" (yêu cầu 3)
  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thông báo'),
        content: Text('Hết thời gian!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Hàm định dạng thời gian (Giây -> Phút:Giây)
  // Ví dụ: 84 giây -> "01:24" (giống như trong ảnh)
  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60; // Số phút
    int seconds = totalSeconds % 60; // Số giây còn lại
    // padLeft(2, '0') để đảm bảo 2 chữ số (ví dụ: 1:5 -> 01:05)
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ô nhập số giây (yêu cầu 1)
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nhập số giây cần đếm',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.timer_outlined),
              ),
              keyboardType: TextInputType.number,
              // Chỉ cho phép nhập số
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              // Vô hiệu hóa ô nhập khi timer đang chạy
              enabled: !_isRunning,
            ),
            SizedBox(height: 40),
            
            // Hiển thị thời gian đếm ngược (giống ảnh)
            Text(
              _formatTime(_remainingSeconds), // Hiển thị MM:SS
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace', // Font chữ số
              ),
            ),
            SizedBox(height: 40),
            
            // Hàng chứa các nút bấm
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút Bắt đầu (như trong ảnh)
                ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Bắt đầu'),
                  // Vô hiệu hóa nút khi đang chạy
                  onPressed: _isRunning ? null : _startTimer,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                // Nút Đặt lại (như trong ảnh)
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Đặt lại'),
                  onPressed: _resetTimer,
                   style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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