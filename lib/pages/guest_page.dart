import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/login_page.dart';
import 'package:project_v2/pages/register_page.dart';
import '../models/product_model.dart';
import '../services/get_all_products_service.dart';
import '../widgets/custom_search.dart';
import 'guest_product_details.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});
  static String id = 'GuestPage';

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  late Future<itemsModel> _futureItemsModel;

  @override
  void initState() {
    super.initState();
    _futureItemsModel = getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Uni-Hub',
                style: TextStyle(
                  color: kBackgroundColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
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
          ],
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
                            GuestProductDetailsPage.id,
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
                                        child: Text(
                                          item.title!,
                                          style: const TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 20,
                                              overflow: TextOverflow.ellipsis),
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
