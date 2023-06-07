import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/account/Account_page.dart';
import 'package:project_v2/pages/home/navigator_home_page.dart';
import '../../models/product_model.dart';
import '../../services/Favourite_service.dart';
import 'product_details_page.dart';
import 'package:intl/intl.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});
  static String id = 'Favourites';

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  late Future<List<Items>> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = getFavourites();
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
            icon: const Icon(Icons.account_circle_rounded, color: kBackgroundColor),
          )
        ],
        title: const Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            'Favourites',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Items>>(
                future: _futureItem,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Items>> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Items item = data[index];
      
      
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
                                                        updateFavoriteItem(item.sId!);
                                                      } else {
                                                        // Add item to favorites
                                                        updateFavoriteItem(item.sId!);
                                                      }
                                                      Navigator.pushReplacementNamed(context, NavigatorHome.id);
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
      ),
    );
  }
}
