// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:project_v2/models/product_model.dart';
import '../helper/constants.dart';
import '../pages/guest/product_guest_page.dart';
import '../services/item_services.dart';

class GuestSearchTextField extends StatefulWidget {
  const GuestSearchTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  // ignore: library_private_types_in_public_api
  _GuestSearchTextFieldState createState() => _GuestSearchTextFieldState();
}

class _GuestSearchTextFieldState extends State<GuestSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          fillColor: kBackgroundColor,
          prefixIcon: GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            child: const Icon(
              Icons.search,
              color: kPrimaryColor,
            ),
          ),
          hintText: widget.hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
        ),
        enabled: false,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  Future<List<Items>> _getItems() async {
    final items = await getAllServices();
    return items.data?.items ?? [];
  }

  @override
  List<Widget> buildActions(context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          if (query == '') {
            close(context, null);
          }
        },
        icon: const Icon(Icons.clear_rounded),
        color: kPrimaryColor,
      )
    ];
  }

  @override
  Widget buildLeading(context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      color: kPrimaryColor,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(context) {
    return FutureBuilder<List<Items>>(
      future: _getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data!;
          final matchQuery = query.isEmpty
              ? item
              : item
                  .where((items) =>
                      items.title!.toLowerCase().contains(query.toLowerCase()))
                  .toList();
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final result = matchQuery[index];
                return ListTile(
                  title: Text(result.title!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductGuestDetailsPage(itemId: result.sId!),
                      ),
                    );
                  },
                );
              },
              itemCount: matchQuery.length,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(context) {
    return FutureBuilder<List<Items>>(
      future: _getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data!;
          final matchQuery = query.isEmpty
              ? item
              : item
                  .where((items) =>
                      items.title!.toLowerCase().contains(query.toLowerCase()))
                  .toList();
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final result = matchQuery[index];
                return ListTile(
                  title: Text(result.title!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductGuestDetailsPage(itemId: result.sId!),
                      ),
                    );
                  },
                );
              },
              itemCount: matchQuery.length,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
