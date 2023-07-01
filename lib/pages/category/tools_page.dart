import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/account/Account_page.dart';
import 'package:project_v2/pages/category/books_page.dart';
import 'package:project_v2/pages/category/services_page.dart';
import '../../models/product_model.dart';
import '../../services/Favourite_service.dart';
import '../../services/item_services.dart';
import '../../widgets/custom_search.dart';
import 'accessories_page.dart';
import 'elctronics_page.dart';
import 'other_page.dart';
import '../home/product_details_page.dart';
import 'package:intl/intl.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});
  static String id = 'ToolsPage';

  @override
  State<ToolsPage> createState() => _ToolsPage();
}

class _ToolsPage extends State<ToolsPage> {
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
    _futureItemsModel = getitemsByCategory('Tools');
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
          const Padding(
            padding: EdgeInsets.only(top: 0.7, left: 1, right: 1),
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
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
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Icon(
                              Icons.design_services_rounded,
                              color: kBackgroundColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Tools",
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
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
                          Navigator.pushReplacementNamed(context, OthersPage.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBackgroundColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Icon(
                              Icons.devices_other_rounded,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Other",
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
                                            FutureBuilder<List<Items>>(
                                              future: getFavourites(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final favoriteItems =
                                                      snapshot.data!;
                                                  final isFavorite =
                                                      favoriteItems.any(
                                                          (favoriteItem) =>
                                                              favoriteItem
                                                                  .sId ==
                                                              item.sId);
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (isFavorite) {
                                                        // Remove item from favorites
                                                        updateFavoriteItem(
                                                            item.sId!);
                                                      } else {
                                                        // Add item to favorites
                                                        updateFavoriteItem(
                                                            item.sId!);
                                                      }
                                                    },
                                                    child: isFavorite
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.red,
                                                          ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.red,
                                                  );
                                                } else {
                                                  return const Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.red,
                                                  );
                                                }
                                              },
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
                                "https://unihub.azurewebsites.net/imgs/items/${item.coverImg}",
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
