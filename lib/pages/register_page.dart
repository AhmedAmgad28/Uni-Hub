import 'package:flutter/material.dart';
import 'package:project_v2/pages/login_page.dart';
import 'package:project_v2/widgets/custom_textfield.dart';
import '../helper/constants.dart';
import '../widgets/custom_button.dart';
import 'navigator_home_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static String id = 'RegisterPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text(
          'Create new account',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Text(
              'Please Fill the following Fields: ',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'UserName :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Username'),
            SizedBox(
              height: 12,
            ),
            Text(
              'Email :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'E-Mail'),
            SizedBox(
              height: 12,
            ),
            Text(
              'Phone Number :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Phone Number'),
            SizedBox(
              height: 12,
            ),
            Text(
              'Password :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Password'),
            SizedBox(
              height: 12,
            ),
            Text(
              'Confirm Password :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Confirm Password'),
            SizedBox(
              height: 16,
            ),
            CustomButton(
              buttonText: 'Register',
              onTap: () {
                Navigator.pushNamed(context, NavigatorHome.id);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Already Have an Account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: Text(
                      " Login",
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
