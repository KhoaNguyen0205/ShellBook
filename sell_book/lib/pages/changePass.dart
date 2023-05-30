import 'package:flutter/material.dart';
import 'package:sell_book/component/CustomButton.dart';
import 'package:sell_book/component/Custom_textfile.dart';
import 'package:sell_book/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? username;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    setState(() {
      username = storedUsername;
    });
  }

  void changePassword() async {
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Kiểm tra mật khẩu hiện tại có đúng không
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString('password');

    if (storedPassword == oldPassword) {
      // Kiểm tra mật khẩu mới và mật khẩu xác nhận trùng khớp
      if (newPassword == confirmPassword) {
        // Lưu mật khẩu mới vào SharedPreferences
        await prefs.setString('password', newPassword);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Password changed successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('New password and confirm password do not match.'),
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
            title: Text('Error'),
            content: Text('Invalid old password.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bghp.png"),
                fit: BoxFit.fitWidth)),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.switch_account,
                color: Colors.red,
                size: 80,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: '$username',
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: oldPasswordController,
              obscureText: true,
              hintText: 'Old Password',
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: newPasswordController,
              obscureText: true,
              hintText: 'New Password',
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: confirmPasswordController,
              obscureText: true,
              hintText: 'Confirm new password',
            ),
            SizedBox(height: 24.0),
            Center(
              child: CustomButton(
                onPressed: changePassword,
                text: 'ChangePassword',
              ),
            )
          ],
        ),
      ),
    );
  }
}
