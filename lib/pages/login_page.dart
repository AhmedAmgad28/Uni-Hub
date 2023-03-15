import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/navigator_home_page.dart';
import 'package:project_v2/widgets/custom_button.dart';
import 'package:project_v2/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String id = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              'Please Fill the following Fields: ',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 16,),
            Text(
              'Email :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(height: 6,),
            CustomFormTextField(hintText: 'Email'),
            SizedBox(height: 12,),
            Text(
              'Password :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(height: 6,),
            CustomFormTextField(hintText: 'Password'),
            SizedBox(height: 16,),
            CustomButton(
              buttonText: 'Login',
              onTap: () {
                Navigator.pushNamed(context, NavigatorHome.id);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Don\'t have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Text(
                      " Register",
                      style: TextStyle(color: Color.fromARGB(255, 149, 162, 29), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
