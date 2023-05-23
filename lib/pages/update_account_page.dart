import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/user_update_profile.dart';
import 'package:project_v2/helper/constants.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _photoController = TextEditingController();

  void _updateProfile() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final photo = _photoController.text;

    try {
      await updateProfile(name, phone, photo);
      final updatedUser = User(name: name, phone: phone, photo: photo);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('User data updatedsuccessfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, updatedUser);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
    final errorMessage = e.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Failed to update user data. Please try again later.\n\nError message: $errorMessage'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          elevation: 10,
          titleTextStyle: TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(
                  labelText: 'Photo',
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
