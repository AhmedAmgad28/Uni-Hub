import 'package:flutter/material.dart';
import 'package:project_v2/models/product_model.dart';
import '../helper/constants.dart';
import '../services/single_product_details.dart';
import 'login_page.dart';
import 'register_page.dart';

class GuestProductDetailsPage extends StatefulWidget {
  const GuestProductDetailsPage({Key? key, required this.itemId})
      : super(key: key);
  static String id = 'GuestProductDetailsPage';
  final String itemId;

  @override
  State<GuestProductDetailsPage> createState() =>
      _GuestProductDetailsPageState();
}

class _GuestProductDetailsPageState extends State<GuestProductDetailsPage> {
  late Future<Items> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = getItemById(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Items>(
    //   future: _futureItem,
    //   builder: (context, snapshot) {
    //     print(snapshot);
    //     if (snapshot.hasData) {
    //       final item = snapshot.data!;
    //       print(item.title);
    //       if (item.sId != null) {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                elevation: 10,
                centerTitle: true,
                backgroundColor: kBackgroundColor,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Uni-Hub',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Text(
                          ' | ',
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.id);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: ListView(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    'assets/images/book.png',
                    height: 220,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        child: Text(
                          // item.title ?? 'Title',
                          'title',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Text(
                          // item.price.toString(),
                          "Price",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  // item.city ?? 'city',
                                  "city",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range_outlined),
                                Text(
                                  // item.createAt.toString().substring(0, 10),
                                  'Date',
                                  style: TextStyle(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Category',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                                Text(
                                  'Books',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                              ],
                            ),
                            const Divider(
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Department',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                                Text(
                                  'Computer Science',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                              ],
                            ),
                            const Divider(
                              indent: 5,
                              endIndent: 5,
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Condition',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                                Text(
                                  'Used',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
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
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              // item.description ?? 'Decription UnKnown',
                              "Describtion",
                              style: TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, LoginPage.id);
                                },
                                child: const Text(
                                  "Login ",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 16),
                                )),
                            const Text(
                              "Or",
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RegisterPage.id);
                                },
                                child: const Text(
                                  " Register ",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 16),
                                )),
                            const Text(
                              "for more information.",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
  //         } else {
  //           return Scaffold(
  //             body: Center(
  //               child: Text('Null '),
  //             ),
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: Text('${snapshot.error}'),
  //         );
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  }
}
