import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/account/Account_page.dart';
import '../../services/item_services.dart';
import '../../services/user_services.dart';
import 'edit_item_page.dart';
import '../home/navigator_home_page.dart';
import 'product_details_page.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});
  static String id = 'MyAdsPage';

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  late Future<Map<String, dynamic>> _userData;
  late Map<String, dynamic> item;
  late String coverImgUrl;

  @override
  void initState() {
    super.initState();
    _userData = getUserData();
    item = {'title': 'My Item', 'price': 100, 'description': 'A sample item'};
    coverImgUrl = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded,
                color: kBackgroundColor),
          )
        ],
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Ads',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No user data found.'),
            );
          } else {
            final user = snapshot.data;
            final items = user!['items'].where((item) => item['approved'] != false).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      if (item['_id'] == "6467ab02d75256041c2b24bc") {
                        coverImgUrl =
                            'https://5.imimg.com/data5/XA/YN/MY-4078569/introduction-to-information-systems-book-500x500.png'; // Replace with the URL for the first product
                      } else if (item['_id'] == "646794f7912f4e932dec9369") {
                        coverImgUrl =
                            'https://m.media-amazon.com/images/I/51HV36xU6yL._SX354_BO1,204,203,200_.jpg'; // Replace with the URL for the second product
                      } else if (item['_id'] == "645ad66701a6c0099057eb72") {
                        coverImgUrl =
                            'https://play-lh.googleusercontent.com/P2VMEenhpIsubG2oWbvuLGrs0GyyzLiDosGTg8bi8htRXg9Uf0eUtHiUjC28p1jgHzo'; // Replace with the URL for the third product
                      } else if (item['_id'] == "64559a8ede7bed79a9b7526f") {
                        coverImgUrl =
                            'https://5.imimg.com/data5/FW/BE/JQ/SELLER-1731045/ms-office-software-500x500.jpg'; // Replace with the URL for the second product
                      } else if (item['_id'] == "64556d96706250ad9660fbcb") {
                        coverImgUrl =
                            'https://www.egytech.net/wp-content/uploads/2021/01/EGYTECH-G3-3500-I7-scaled.jpg'; // Replace with the URL for the second product
                      } else {
                        coverImgUrl =
                            'https://item-shopping.c.yimg.jp/i/l/shimamura-gakufu_g0225648'; // Replace with the default URL
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                itemId: item['_id'],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 8, right: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 0,
                                      offset: const Offset(10, 10)),
                                ],
                              ),
                              child: Card(
                                elevation: 16,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 14, bottom: 12, top: 12, left: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                item['title'],
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final updatedValues =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditItemPage(
                                                                item: item),
                                                      ),
                                                    );
                                                    if (updatedValues != null) {
                                                      final updatedItem = Map<
                                                          String,
                                                          dynamic>.from(item);
                                                      updatedValues
                                                          .forEach(
                                                              (key, value) => {
                                                                    if (value !=
                                                                        null)
                                                                      {
                                                                        updatedItem[key] =
                                                                            value,
                                                                      }
                                                                  });
                                                      await updateItem(
                                                          item, updatedValues);
                                                      setState(() {
                                                        item = updatedItem;
                                                      });
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Confirm Delete'),
                                                          content: const Text(
                                                              'Are you sure you want to delete this item?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'Delete'),
                                                              onPressed: () {
                                                                deleteItem(item)
                                                                    .then((_) {
                                                                  // Item successfully deleted, navigate to home page
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushNamedAndRemoveUntil(
                                                                    NavigatorHome
                                                                        .id,
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false,
                                                                    arguments: {},
                                                                  );
                                                                }).catchError(
                                                                        (error) {
                                                                  // Handle error, e.g. show error message
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Error deleting item: $error'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              3),
                                                                    ),
                                                                  );
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70),
                                        child: Text(
                                          "£ ${item['price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 22),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['category'],
                                              style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 22,
                              top: 16,
                              child: Image.network(
                                item['coverImg'] != null &&
                                        Uri.parse(item['coverImg']!).isAbsolute
                                    ? item['coverImg']!
                                    : coverImgUrl,
                                height: 100,
                                width: 90,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
