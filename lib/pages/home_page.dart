import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/Account_page.dart';
import '../models/product_model.dart';
import '../services/get_all_products_service.dart';
import '../widgets/custom_search.dart';
import 'product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<itemsModel> _futureItemsModel;

  @override
  void initState() {
    super.initState();
    _futureItemsModel = getAllServices();
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
          SearchTextField(hintText: 'Search for products'),
          const SizedBox(
            height: 8,
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
                      final coverImgUrl = item.coverImg != null &&
                              Uri.parse(item.coverImg!).isAbsolute
                          ? item.coverImg!
                          : 'https://item-shopping.c.yimg.jp/i/l/shimamura-gakufu_g0225648';
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsPage.id,
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
                                                    overflow: TextOverflow.ellipsis),
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
                                          '\$ ${item.price}',
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
                                            const Text(
                                              'Negotiable',
                                              style: TextStyle(
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
                                              item.createAt!
                                                  .toString()
                                                  .substring(0, 10),
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
                                coverImgUrl,
                                height: 110,
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
