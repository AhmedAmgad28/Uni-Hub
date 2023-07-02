import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/item_services.dart';
import 'package:geolocator/geolocator.dart';
import '../home/navigator_home_page.dart';

class SellProductPage extends StatefulWidget {
  const SellProductPage({super.key});

  static String id = 'SellProductPage';

  @override
  State<SellProductPage> createState() => _SellProductPageState();
}

class Category {
  final String value;
  final String label;

  const Category({required this.value, required this.label});
}

class Condition {
  final String value;
  final String label;

  const Condition({required this.value, required this.label});
}

class _SellProductPageState extends State<SellProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _conditionController = TextEditingController();
  final _cityController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationDescriptionController = TextEditingController();
  final List<File> _selectedImages = [];

  final List<Category> _categories = [
    const Category(value: 'Books', label: 'Books'),
    const Category(value: 'Tools', label: 'Tools'),
    const Category(value: 'Electronics', label: 'Electronics'),
    const Category(value: 'Services', label: 'Services'),
    const Category(value: 'Accessories', label: 'Accessories'),
    const Category(value: 'Other', label: 'Other'),
  ];

  final List<Condition> _condition = [
    const Condition(value: 'New', label: 'New'),
    const Condition(value: 'Used', label: 'Used'),
    const Condition(value: 'Other', label: 'Other'),
  ];

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

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled and ask for permission if not
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    // Get the current position of the user
    return await Geolocator.getCurrentPosition();
  }

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      final response = await addProduct(
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        coverImg: _selectedImages.first,
        imgs: _selectedImages,
        category: _categoryController.text,
        condition: _conditionController.text,
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
      } else {
        // Show an error message
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to add product ${response.reasonPhrase}'),
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
    } on TimeoutException catch (_) {
      // Show a timeout message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to add product. Request timed out. Please wait and try again later.'),
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
      // Show a generic error message
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
                style: const TextStyle(color: Colors.black),
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
                style: const TextStyle(color: Colors.black),
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
                style: const TextStyle(color: Colors.black),
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
              DropdownButtonFormField<String>(
                value: _categoryController.text.isNotEmpty
                    ? _categoryController.text
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    key: Key(category
                        .value), // assign a unique key based on the category value
                    value: category.value,
                    child: Text(category.label),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoryController.text = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _conditionController.text.isNotEmpty
                    ? _conditionController.text
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Condition',
                  border: OutlineInputBorder(),
                ),
                items: _condition.map((condition) {
                  return DropdownMenuItem<String>(
                    key: Key(condition
                        .value), // assign a unique key based on the category value
                    value: condition.value,
                    child: Text(condition.label),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _conditionController.text = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
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
                  padding:  EdgeInsets.all(8.0),
                  child:  Text(
                      'Note: The First image will be the Cover Image for your Product',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        color: kPrimaryColor,
                        icon: const Icon(Icons.location_on),
                        onPressed: () async {
                          final position = await _getCurrentLocation();
                          setState(() {
                            _latController.text = position.latitude.toString();
                            _lngController.text = position.longitude.toString();
                          });
                        },
                      ),
                      const Text(
                        "click here to get your accurate location",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cityController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
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
