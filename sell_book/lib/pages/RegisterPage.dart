import 'package:flutter/material.dart';
import 'package:sell_book/component/CustomButton.dart';
import 'package:sell_book/component/Custom_textfile.dart';
import 'package:sell_book/main.dart';
import 'package:sell_book/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final Function(String username, String password) onRegistered;

  const RegisterPage({Key? key, required this.onRegistered}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG-g7.png"),
                fit: BoxFit.fitWidth)),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.app_registration,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(
              height: 26.0,
            ),
            CustomTextField(
              controller: usernameController,
              hintText: 'User name',
              icon: Icons.supervised_user_circle,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              icon: Icons.password,
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              icon: Icons.password,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();

                if (username.isNotEmpty &&
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty) {
                  if (password == confirmPassword) {
                    widget.onRegistered(username, password);
                    Navigator.pop(context);
                  } else {
                    // Hiển thị thông báo lỗi nếu mật khẩu xác nhận không khớp
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid Password'),
                          content: Text(
                              'Password and Confirm Password do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Hiển thị thông báo lỗi nếu một trường thông tin bị bỏ trống
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Information'),
                        content: Text('Please enter all required information.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
