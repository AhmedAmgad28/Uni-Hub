import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_v2/helper/constants.dart';

import '../services/update_item_by_user.dart';

// ignore: prefer_const_constructors
final storage = FlutterSecureStorage();

class EditItemPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditItemPage({Key? key, required this.item}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
  String? _updatedTitle;
  int? _updatedPrice;
  String? _updatedDescription;
  String? _updatedCategory;
  String? _updatedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: widget.item['title'],
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _updatedTitle = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.item['price'].toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _updatedPrice = int.tryParse(value ?? '');
                  },
                ),
                TextFormField(
                  initialValue: widget.item['description'],
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _updatedDescription = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.item['category'],
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _updatedCategory = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.item['city'],
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _updatedCity = value;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        final updatedValues = {
                          'title': _updatedTitle,
                          'price': _updatedPrice,
                          'description': _updatedDescription,
                          'category': _updatedCategory,
                          'city': _updatedCity,
                        };
                        updateItem(widget.item, updatedValues);
                        Navigator.pop(context, updatedValues);
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
