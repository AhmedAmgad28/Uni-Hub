import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/Account_page.dart';
import 'package:project_v2/pages/elctronics_page.dart';
import '../models/product_model.dart';
import '../services/get_all_products_service.dart';
import '../widgets/custom_search.dart';
import 'accessories_page.dart';
import 'books_page.dart';
import 'product_details_page.dart';
import 'package:intl/intl.dart';

import 'services_page.dart';
import 'tools_page.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({super.key});
  static String id = 'OthersPage';

  @override
  State<OthersPage> createState() => _OthersPage();
}

class _OthersPage extends State<OthersPage> {
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  late Future<itemsModel> _futureItemsModel;

  @override
  void initState() {
    super.initState();
    _futureItemsModel = getitemsByCategory('Other');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
            'UNI-HUB',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.7,left: 1,right: 1),
            child: SearchTextField(hintText: 'Search for products'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, BooksPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.book_outlined,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Books",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, ToolsPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.design_services_rounded,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Tools",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, ElectronicsPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.electrical_services_rounded,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Electronics",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, ServicesPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.miscellaneous_services_outlined,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Services",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AccessoriesPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.type_specimen_sharp,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Accessories",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 90,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.devices_other_rounded,
                              color: kBackgroundColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Other",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kBackgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<itemsModel>(
              future: _futureItemsModel,
              builder:
                  (BuildContext context, AsyncSnapshot<itemsModel> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!.data;
                  return ListView.builder(
                    itemCount: data!.items!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data.items![index];

                      String coverImgUrl;
                      if (item.sId == "6467ab02d75256041c2b24bc") {
                        coverImgUrl =
                            'https://5.imimg.com/data5/XA/YN/MY-4078569/introduction-to-information-systems-book-500x500.png'; // Replace with the URL for the first product
                      } else if (item.sId == "646794f7912f4e932dec9369") {
                        coverImgUrl =
                            'https://m.media-amazon.com/images/I/51HV36xU6yL._SX354_BO1,204,203,200_.jpg'; // Replace with the URL for the second product
                      } else if (item.sId == "645ad66701a6c0099057eb72") {
                        coverImgUrl =
                            'https://play-lh.googleusercontent.com/P2VMEenhpIsubG2oWbvuLGrs0GyyzLiDosGTg8bi8htRXg9Uf0eUtHiUjC28p1jgHzo'; // Replace with the URL for the third product
                      } else if (item.sId == "64559a8ede7bed79a9b7526f") {
                        coverImgUrl =
                            'https://5.imimg.com/data5/FW/BE/JQ/SELLER-1731045/ms-office-software-500x500.jpg'; // Replace with the URL for the second product
                      } else if (item.sId == "64556d96706250ad9660fbcb") {
                        coverImgUrl =
                            'https://www.egytech.net/wp-content/uploads/2021/01/EGYTECH-G3-3500-I7-scaled.jpg'; // Replace with the URL for the second product
                      } else {
                        coverImgUrl =
                            'https://item-shopping.c.yimg.jp/i/l/shimamura-gakufu_g0225648'; // Replace with the default URL
                      }

                      final coverImgUrlFinal = item.coverImg != null &&
                              Uri.parse(item.coverImg!).isAbsolute
                          ? item.coverImg!
                          : coverImgUrl;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                itemId: item.sId!,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8, right: 8),
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
                                color: kBackgroundColor,
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
                                                item.title!,
                                                style: const TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
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
                                          '£ ${item.price}',
                                          style: const TextStyle(
                                              color: kItemDetails,
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
                                              item.category!,
                                              style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              item.city!,
                                              style: const TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              reverseDateFormat(item.createAt!),
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
                              left: 20,
                              top: 6,
                              child: Image.network(
                                coverImgUrlFinal,
                                height: 100,
                                width: 90,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
