import 'package:flutter/material.dart';
import 'package:sell_book/component/CustomButton.dart';
import 'package:sell_book/component/Custom_textfile.dart';
import 'package:sell_book/main.dart';
import 'package:sell_book/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    checkIfRegistered();
  }

  void checkIfRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    if (username != null) {
      setState(() {
        isRegistered = true;
      });
    }
  }

  void saveNewPassword(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Forgot Pass'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG-g7.png"),
                fit: BoxFit.fitWidth)),
        padding: EdgeInsets.only(top: 26.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mobile_friendly_outlined,
              size: 50.0,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: usernameController,
                hintText: 'User name',
                icon: Icons.supervised_user_circle,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: 'PassWord',
                icon: Icons.password,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();
                if (username.isNotEmpty && password.isNotEmpty) {
                  validateCredentials(username, password);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Credentials'),
                        content: Text('Please enter username and password.'),
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
              child: CustomButton(text: 'Confirm', width: 200),
            ),
            SizedBox(height: 50),
            Divider(
              color: Colors.red,
            ),
            SizedBox(
              height: 20.6,
            ),
          ],
        ),
      ),
    );
  }

  void validateCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');

    if (storedUsername != null) {
      if (username == storedUsername) {
        saveNewPassword(
            username, password); // Lưu mật khẩu mới vào SharedPreferences
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text("username can't find on data"),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('No registered user found.'),
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
  }
}
