import 'package:flutter/material.dart';

import 'package:sell_book/pages/LoginPage.dart';
import 'package:sell_book/pages/changePass.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key? key});

  void logOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }

  void goToChangePasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ChangePassPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Account'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg3.gif"),
                  fit: BoxFit.fitWidth)),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Icon(
                  Icons.account_box_outlined,
                  size: 80,
                  color: Color.fromARGB(255, 238, 98, 11),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => logOut(context),
                  child: Text('Log Out'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => goToChangePasswordPage(context),
                  child: Text('Change Password'),
                ),
              ],
            ),
          ),
        ));
  }
}
