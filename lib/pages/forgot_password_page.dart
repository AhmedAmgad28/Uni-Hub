import 'package:flutter/material.dart';
import '../helper/constants.dart';
import '../services/forget_password.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _emailController = TextEditingController();

  // ignore: use_key_in_widget_constructors
  ForgetPasswordScreen({Key? key});

  void _sendResetPasswordRequest(BuildContext context) async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      // Show error message if email is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      // Send password reset request
      await forgotPassword(email);

      // Show success message and navigate back to login screen
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to $email')),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/Forgot_password-cuate.png",height: 300,),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: kBackgroundColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _sendResetPasswordRequest(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: kPrimaryColor,
              ),
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}