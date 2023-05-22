import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../services/add_product.dart';

class SellProductPage extends StatefulWidget {
  const SellProductPage({super.key});

  static String id = 'SellProductPage';

  @override
  State<SellProductPage> createState() => _SellProductPageState();
}

class _SellProductPageState extends State<SellProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _coverImagePathController = TextEditingController();
  final _categoryController = TextEditingController();
  final _cityController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationDescriptionController = TextEditingController();
  final List<File> _selectedImages = [];

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final response = await addProduct(
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        coverImgPath: _coverImagePathController.text,
        imgs: _selectedImages,
        category: _categoryController.text,
        city: _cityController.text,
        lat: double.parse(_latController.text),
        lng: double.parse(_lngController.text),
        address: _addressController.text,
        locationDescription: _locationDescriptionController.text,
      );

      // Check if product was added successfully
      if (response.statusCode == 201) {
        // Show a success message and navigate back to the previous screen
        // ignore: use_build_context_synchronously
        if (!Navigator.of(context).canPop()) {
          // Wait for the navigator to unlock before navigating
          await Future.delayed(const Duration(milliseconds: 50));
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Product added successfully!'),
              actions:[
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
      } else {
        // Show an error message
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to add product'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Sell Your Product',
          style: TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: kPrimaryColor),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                style: const TextStyle(color: kPrimaryColor),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: kPrimaryColor),
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _coverImagePathController,
                style: const TextStyle(color: kPrimaryColor),
                decoration: const InputDecoration(
                  labelText: 'Cover Image Path',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cover image path';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Product Images', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: const Icon(Icons.image),
                    label: const Text('Choose from Gallery'),
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      final image = _selectedImages[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(image, width: 150),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _latController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid latitude';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lngController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid longitude';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _locationDescriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Location Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
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
      ),
    );
  }
}