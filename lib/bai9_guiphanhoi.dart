import 'package:flutter/material.dart';

const Color primaryOrangeColor = Color(0xFFF4511E); 
const Color backgroundLightColor = Color(0xFFFFFBF9); 

void main() {
  runApp(const GuiPhanHoi());
}

class GuiPhanHoi extends StatelessWidget {
  const GuiPhanHoi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryOrangeColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrangeColor,
          primary: primaryOrangeColor,
        ),
        useMaterial3: true,
      ),
      home: const FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _selectedRating = '4 sao'; 
  final List<String> _ratingOptions = [
    '1 sao',
    '2 sao',
    '3 sao',
    '4 sao',
    '5 sao'
  ];

  void _submitFeedback() {
    FocusScope.of(context).unfocus();

    if (_nameController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: Text(
          'Cảm ơn ${_nameController.text} đã đánh giá $_selectedRating!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _nameController.clear();
                _contentController.clear();
                _selectedRating = '4 sao';
              });
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: primaryOrangeColor, width: 2.0),
      ),
      labelStyle: TextStyle(color: Colors.grey[700]),
      alignLabelWithHint: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLightColor,
      appBar: AppBar(
        title: const Text(
          'Gửi phản hồi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: primaryOrangeColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: _buildInputDecoration(
                  labelText: 'Họ tên',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 20),
              
              DropdownButtonFormField<String>(
                value: _selectedRating,
                decoration: _buildInputDecoration(
                  labelText: 'Đánh giá (1 - 5 sao)',
                  icon: Icons.star_border,
                ),
                items: _ratingOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedRating = newValue!;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ),
              
              const SizedBox(height: 20),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: _buildInputDecoration(
                  labelText: 'Nội dung góp ý',
                  icon: Icons.chat_bubble_outline,
                ),
              ),
              const SizedBox(height: 30),
              
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrangeColor,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.send, size: 20),
                    label: const Text(
                      'Gửi phản hồi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}