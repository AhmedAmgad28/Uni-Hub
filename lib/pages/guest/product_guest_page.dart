import 'package:flutter/material.dart';
import 'package:project_v2/models/product_model.dart';
import 'package:project_v2/pages/guest/register_page.dart';
import '../../helper/constants.dart';
import 'package:intl/intl.dart';
import '../../services/item_services.dart';
import 'login_page.dart';

class ProductGuestDetailsPage extends StatefulWidget {
  const ProductGuestDetailsPage({
    Key? key,
    required this.itemId,
  }) : super(key: key);
  static String id = 'ProductGuestDetailsPage';
  final String itemId;

  @override
  State<ProductGuestDetailsPage> createState() =>
      _ProductGuestDetailsPageState();
}

class _ProductGuestDetailsPageState extends State<ProductGuestDetailsPage> {
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  ' | ',
                  style: TextStyle(color: kBackgroundColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder<itemsModel>(
              future: getAllServices(),
              builder:
                  (BuildContext context, AsyncSnapshot<itemsModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final data = snapshot.data!.data;
                  final item = data?.items
                      ?.firstWhere((element) => element.sId == widget.itemId);
                  if (item != null) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                  height: 263,
                  child: PageView(
                    children: [
                      Image.network(
                        "https://unihub.azurewebsites.net/imgs/items/${item.coverImg}",
                        fit: BoxFit.cover,
                      ),
                      ...item.imgs!
                          .map((img) => Image.network(
                                "https://unihub.azurewebsites.net/imgs/items/$img",
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                    ],
                  ),
                ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title!,
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Text(
                                '£ ${item.price!.toString()}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined),
                                      Text(
                                        item.city!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range_outlined),
                                      Text(
                                        reverseDateFormat(item.createAt!),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Product Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Category',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        item.category!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    indent: 5,
                                    endIndent: 5,
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Condition',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        item.condition!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    item.description!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Text(
                                'Published by: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      "https://unihub.azurewebsites.net/imgs/users/${item.user!.photo}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.user!.name!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Login or register to chat with the seller'),
                                    content: const SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'You must be logged in to chat with the seller.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Login'),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, LoginPage.id);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Register'),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, RegisterPage.id);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: const Center(
                                child: Text(
                                  'Chat',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: kBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Item not found');
                  }
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top:350.0),
                    child:  Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
