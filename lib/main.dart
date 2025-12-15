import 'package:flutter/material.dart';


import 'baitap1_form_dang_ky.dart';
import 'baitap2_bmi.dart';
import 'baitap3_timer.dart';
import 'baitap4_news/news_list_page.dart';
import 'baitap5_login.dart';
import 'baitap6_classroom.dart';
import 'baitap7_ui_demo.dart';
import 'bai8_thuongmai.dart';
import 'bai9_guiphanhoi.dart';
import 'bai10_Sahara.dart';
import 'bai11_counter.dart';
import 'bai12_doimaunen.dart';

const Color kHeaderStartColor = Color(0xFF2E6FF9);
const Color kHeaderEndColor = Color(0xFF00B0FF);
const Color kPrimaryBlue = kHeaderStartColor; 
const Color kDefaultIconColor = Colors.white;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BÀI KIỂM TRA FLUTTER – VĂN LỢI',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('BÀI KIỂM TRA FLUTTER – ĐÀO VĂN LỢI'),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const _CustomDrawerHeader(),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _item(context, 'Bài 1 – Form đăng ký', Icons.app_registration,
                      wrap(RegisterPage(), 'Bài 1 – Form đăng ký')),

                  _item(context, 'Bài 2 – BMI', Icons.monitor_weight,
                      wrap(BMIScreen(), 'Bài 2 – BMI')),

                  _item(context, 'Bài 3 – Timer', Icons.timer,
                      wrap(TimerScreen(), 'Bài 3 – Timer')),

                  _item(context, 'Bài 4 – News', Icons.article,
                      wrap(NewsListPage(), 'Bài 4 – News')),

                  _item(context, 'Bài 5 – Login', Icons.lock_open,
                      wrap(LoginPage(), 'Bài 5 – Login')),

                  _item(context, 'Bài 6 – Classroom UI', Icons.school,
                      wrap(Baitap6Classroom(), 'Bài 6 – Classroom UI')),

                  _item(context, 'Bài 7 – UI Demo', Icons.dashboard,
                      wrap(UiDemoPage(), 'Bài 7 – UI Demo')),

                  _item(context, 'Bài 8 – TMĐT', Icons.shopping_bag,
                      wrap(ShopeeCloneApp(), 'Bài 8 – TMĐT')),

                  _item(context, 'Bài 9 – Gửi phản hồi', Icons.feedback,
                      wrap(GuiPhanHoi(), 'Bài 9 – Gửi phản hồi')),

                  _item(context, 'Bài 10 – Sahara', Icons.code,
                      wrap(Bai10Helloworld(), 'Bài 10 – Sahara')),

                  _item(context, 'Bài 11 – Counter', Icons.add_circle_outline,
                      wrap(CounterApp(), 'Bài 11 – Counter')),

                  _item(context, 'Bài 12 – Đổi màu nền', Icons.color_lens,
                      wrap(DoiMauApp(), 'Bài 12 – Đổi màu nền')),
                ],
              ),
            ),
            
            const _DrawerFooter(),
          ],
        ),
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _WelcomeBanner(), 
              
              SizedBox(height: 30),

              _StatCardOnly(), 

              SizedBox(height: 30),

              Text(
                '⬅️ Chọn bài tập từ Dấu 3 gạch bên trái',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),             
            ],
          ),
        ),
      ),
    );
  }

  ListTile _item(
    BuildContext context,
    String title,
    IconData icon,
    Widget page, {
    Color iconColor = Colors.blueGrey,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
      onTap: () async {
        Navigator.pop(context);
        
        await Navigator.push( 
          context,
          MaterialPageRoute(builder: (_) => page),
        );
        
        _scaffoldKey.currentState?.openDrawer();
      },
    );
  }
}


class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: kPrimaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: kPrimaryBlue, width: 2),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.laptop_mac, 
            size: 60,
            color: kPrimaryBlue,
          ),
          const SizedBox(height: 10),
          const Text(
            'CHÀO MỪNG THẦY ĐẾN VỚI GIAO DIỆN CÁC BÀI TẬP HỌC PHẦN LẬP TRÌNH ỨNG DỤNG DI ĐỘNG!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: kPrimaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Dự án tổng hợp 12 bài thực hành giao diện và logic ứng dụng di động.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCardOnly extends StatelessWidget {
  const _StatCardOnly();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        _StatCard(
          icon: Icons.check_circle_outline,
          label: 'Bài Tập Đã Hoàn Thành',
          value: '12/12',
          color: Colors.green,
          isFullWidth: true, 
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isFullWidth; 

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          children: [
            Icon(icon, size: 36, color: color), 
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
    
    if (isFullWidth) {
      return cardContent;
    }
    
    return Expanded(child: cardContent);
  }
}

class _CustomDrawerHeader extends StatelessWidget {
  const _CustomDrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kHeaderStartColor, kHeaderEndColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/VanLoi.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 40, color: kHeaderStartColor);
                },
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          const Text(
            'ĐÀO VĂN LỢI',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Danh sách bài tập',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: const [
          Divider(height: 1, color: Colors.black12),
          SizedBox(height: 8),
          Text(
            'Developed by Văn Lợi - 12/2025',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

Widget wrap(Widget child, String title) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: kHeaderStartColor,
    ),
    body: child,
  );
}