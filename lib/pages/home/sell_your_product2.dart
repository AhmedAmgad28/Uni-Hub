import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/item_services.dart';
import '../home/navigator_home_page.dart';

class SellProductPage2 extends StatefulWidget {
  const SellProductPage2({super.key, required this.itemId});

  static String id = 'SellProductPage2';
  final String itemId;

  @override
  State<SellProductPage2> createState() => _SellProductPage2State();
}

class _SellProductPage2State extends State<SellProductPage2> {
  final List<File> _selectedImages = [];
  final contentType = 'image/jpeg';

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      
      if (_selectedImages.length < 5) {
        setState(() {
          _selectedImages.add(image);
        });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('You can only select up to 5 images.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _submitForm() async {
    try {
      // ignore: unused_local_variable
      final response = await updateItemImages(
        itemId: widget.itemId,
        coverImg: _selectedImages.first,
        imgs: _selectedImages.sublist(1),
        contentType: contentType,
      );
      // ignore: use_build_context_synchronously
      if (!Navigator.of(context).canPop()) {
        // Wait for the navigator to unlock before navigating
        await Future.delayed(const Duration(milliseconds: 50));
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        NavigatorHome.id,
        (route) => false,
      );
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Product added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    } on TimeoutException catch (_) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to add product. Request timed out. Please wait and try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to add product. $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Add Product Images',
          style: TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Row(
              children: [
                Text('Product Images', style: TextStyle(fontSize: 18)),
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text('(Add from 3 to 5 images)',
                      style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take Photo'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                ),
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text('Choose from Gallery'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 150.0,
                width: 200,
                child: PageView.builder(
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    final image = _selectedImages[index];
                    return Center(
                      child: Image.file(image, width: 150),
                    );
                  },
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Note: The First image will be the Cover Image for your Product',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
