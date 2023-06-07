import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/guest/login_page.dart';
import 'package:project_v2/pages/guest/register_page.dart';
import '../../models/product_model.dart';
import '../../services/item_services.dart';
import '../../widgets/custom_search.dart';
import 'package:intl/intl.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});
  static String id = 'GuestPage';

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
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
          const SearchTextField(hintText: 'Search for products'),
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
                          Navigator.pushNamed(
                            context,
                            LoginPage.id
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
