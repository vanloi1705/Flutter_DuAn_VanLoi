import 'package:flutter/material.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  bool showConfirmPassword = false;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  OutlineInputBorder redBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xffC62828), width: 1.4),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
        .hasMatch(email);
  }

  void register() {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        passCtrl.text.isEmpty ||
        confirmCtrl.text.isEmpty) {
      showMsg("Vui lòng nhập đầy đủ thông tin");
      return;
    }

    if (!isValidEmail(emailCtrl.text)) {
      showMsg("Email không hợp lệ");
      return;
    }

    if (passCtrl.text.length < 6) {
      showMsg("Mật khẩu phải từ 6 ký tự trở lên");
      return;
    }

    if (passCtrl.text != confirmCtrl.text) {
      showMsg("Mật khẩu xác nhận không khớp");
      return;
    }

    showMsg("Đăng ký tài khoản thành công", success: true);
  }

  void showMsg(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8EFF4),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            color: const Color(0xff3F51B5),
            child: const Center(
              child: Text(
                "Form Đăng ký tài khoản",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: "Họ tên",
                    prefixIcon:
                        const Icon(Icons.person, color: Color(0xffC62828)),
                    enabledBorder: redBorder(),
                    focusedBorder: redBorder(),
                    helperText: "Vui lòng nhập họ tên",
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xffC62828)),
                    enabledBorder: redBorder(),
                    focusedBorder: redBorder(),
                    helperText: "Vui lòng nhập email",
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: passCtrl,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xffC62828)),
                    suffixIcon: IconButton(
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    ),
                    enabledBorder: redBorder(),
                    focusedBorder: redBorder(),
                    helperText: "Vui lòng nhập mật khẩu",
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: confirmCtrl,
                  obscureText: !showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Xác nhận mật khẩu",
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: Color(0xffC62828)),
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(
                          () => showConfirmPassword = !showConfirmPassword),
                    ),
                    enabledBorder: redBorder(),
                    focusedBorder: redBorder(),
                    helperText: "Vui lòng xác nhận mật khẩu",
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 160,
                  height: 45,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text("Đăng ký", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3F51B5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: register,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
