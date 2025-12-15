import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// ================== LOGIN PAGE ==================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool showPass = false;
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);

    final url = Uri.parse("https://dummyjson.com/auth/login");
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usernameCtrl.text,
        "password": passwordCtrl.text,
      }),
    );

    setState(() => loading = false);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(user: data),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sai tài khoản hoặc mật khẩu!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8EFF4),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("LOGIN",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 40),

              // Username
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person, color: Colors.red),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                controller: passwordCtrl,
                obscureText: !showPass,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock, color: Colors.red),
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPass ? Icons.visibility : Icons.visibility_off,
                        color: Colors.red),
                    onPressed: () => setState(() => showPass = !showPass),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // BUTTON LOGIN
              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: loading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3F51B5),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Đăng nhập",
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== PROFILE PAGE ==================
class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final u = widget.user;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.purple.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(u["image"]),
              ),
              const SizedBox(height: 10),

              Text(
                "Hello, ${u['firstName']}",
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),

              const SizedBox(height: 25),

              // AUTH CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.orange.shade300],
                  ),
                ),
                child: Text(
                  "Welcome back, ${u['firstName']} ${u['lastName']}!",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),

              // PROFILE INFO CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Profile",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 20),

                    infoRow(Icons.numbers, "ID", "#${u['id']}"),
                    infoRow(Icons.person, "Username", u['username']),
                    infoRow(Icons.email, "Email", u['email']),
                    infoRow(Icons.badge, "Full Name",
                        "${u['firstName']} ${u['lastName']}"),
                    infoRow(Icons.male, "Gender", u['gender']),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // REFRESH
                  ElevatedButton(
                    onPressed: refresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 30),
                    ),
                    child: const Text("Refresh",
                        style: TextStyle(color: Colors.white)),
                  ),

                  // LOGOUT
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 30),
                    ),
                    child: const Text("Logout",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
              Text(value,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }
}
