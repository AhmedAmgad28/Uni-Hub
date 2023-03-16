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
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        iconTheme: const IconThemeData(color:Colors.black),
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Create new account',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
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
              'UserName :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Username'),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Email :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'E-Mail'),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Phone Number :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Phone Number'),
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
            CustomFormTextField(hintText: 'Password',obscureText: true,),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Confirm Password :',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomFormTextField(hintText: 'Confirm Password',obscureText: true,),
            const SizedBox(
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
                  const Text("Already Have an Account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: const Text(
                      " Login",
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
