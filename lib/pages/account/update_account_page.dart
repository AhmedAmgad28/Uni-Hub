import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_v2/pages/account/account_page.dart';
import '../../services/user_services.dart';
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
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _updateProfile() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final photo = _imageFile.toString();

    try {
      await updateProfile(name, phone, photo);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('User data updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AccountPage.id);
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
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
                const SizedBox(height: 24.0),
                const Text('Profile Image', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _getImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _getImage(ImageSource.gallery),
                      icon: const Icon(Icons.image),
                      label: const Text('Choose from Gallery'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child:  _imageFile == null
                        ? const Icon(Icons.add_a_photo, size: 40.0)
                        : Image.file(_imageFile!),
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
      ),
    );
  }
}
