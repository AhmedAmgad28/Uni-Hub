// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:project_v2/pages/guest/login_page.dart';
import 'package:project_v2/services/authentication_services.dart';
import 'package:project_v2/widgets/register_form_textfield.dart';
import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import '../home/navigator_home_page.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'RegisterPage';

  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // File? _imageFile;

  // Future<void> _getImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  void _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final response = await register(
        name: name,
        email: email,
        password: password,
        passwordConfirm: confirmPassword,
        phone: phone,
      );
      final userId = response['data']['user']['_id'];
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account Created Successfully.'),      
          actions: [
            TextButton(
              onPressed: () {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigatorHome(userId: userId),
                    ),
                  );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Failed to sign up.'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset("assets/images/Mobile_login-pana.png",height: 300,),
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
              RegisterFormTextField(
                controller: _nameController,
                hintText: 'Username',
              ),
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
              RegisterFormTextField(
                controller: _emailController,
                hintText: 'E-Mail',
                keyboardType: TextInputType.emailAddress,
              ),
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
              RegisterFormTextField(
                controller: _phoneController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
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
              RegisterFormTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
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
              RegisterFormTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                buttonText: 'Register',
                onTap: _signUp,
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
      ),
    );
  }
}
