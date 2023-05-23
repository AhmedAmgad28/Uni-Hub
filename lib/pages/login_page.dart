import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/navigator_home_page.dart';
import 'package:project_v2/pages/register_page.dart';
import 'package:project_v2/services/login_service.dart';
import 'package:project_v2/widgets/custom_button.dart';
import 'package:project_v2/widgets/custom_textfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const String id = 'LoginPage';

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Login',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 32,
          ),
          const Text(
            'Welcome back!',
            style: TextStyle(
              color: kPrimaryColor,
             fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomFormTextField(
            hintText: 'Email',
            onChanged: (data) {
              email = data;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormTextField(
            hintText: 'Password',
            onChanged: (data) {
              password = data;
            },
            obscureText: true,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to the Forgot Password page
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            buttonText: 'Login',
            onTap: () async {
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
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, NavigatorHome.id);
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login failed. Please try again.'),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login failed. Please try again. $e'),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Don't have an account?"),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
                child: const Text(
                  " Sign Up",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}