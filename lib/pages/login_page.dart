// ignore_for_file: unnecessary_string_escapes, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/navigator_home_page.dart';
import 'package:project_v2/pages/register_page.dart';
import 'package:project_v2/services/login_service.dart';
import 'package:project_v2/widgets/custom_button.dart';
import 'package:project_v2/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static String id = 'LoginPage';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Login',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              'Please Fill the following Fields: ',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Email :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(
              hintText: 'Email',
              onChanged: (data) {
                email = data;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Password :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(
              hintText: 'Password',
              onChanged: (data) {
                password = data;
              },
              obscureText: true,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              buttonText: 'Login',
              onTap: () async {
                // login(email: email!, password: password!);
                if (email == null || password == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your email and password.'),
                    ),
                  );
                  return;
                }
                try {
                  final response =
                      await login(email: email!, password: password!);
                  if (response['status'] == "Success") {
                    Navigator.pushReplacementNamed(context, NavigatorHome.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login failed. Please try again.'),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed. Please try again.$e'),
                    ),
                  );
                }
                //Navigator.pushNamed(context, NavigatorHome.id);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Don\'t have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      " Register",
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
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
