// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_v2/widgets/custom_button.dart';
import '../../helper/constants.dart';
import '../../models/product_model.dart';
import '../../services/Favourite_service.dart';
import '../../services/chat_services.dart';
import '../../services/item_services.dart';
import '../account/account_page.dart';
import 'package:intl/intl.dart';
import '../chat/single_chat_page.dart';
import 'view_profile_page.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.itemId}) : super(key: key);
  static String id = 'ProductDetailsPage';
  final String itemId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  final storage = const FlutterSecureStorage();
  String getTokenPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = parts[1];
    final normalizedPayload = base64Url.normalize(payload);
    final utf8Payload = utf8.decode(base64Url.decode(normalizedPayload));
    return utf8Payload;
  }

  String getCurrentUserIdFromToken(String token) {
    final payload = getTokenPayload(token);
    final data = jsonDecode(payload);
    return data['id'];
  }

  late Future<Items> _futureItem;
  final defaultProfileImgUrl =
      'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/626fd8140423801.6241b91e24d9c.png';

  @override
  void initState() {
    super.initState();
    _futureItem = getItemById(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Items>(
      future: _futureItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data!;
          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              elevation: 10,
              centerTitle: true,
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
            ),
            body: ListView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title ?? 'Title',
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          FutureBuilder<List<Items>>(
                            future: getFavourites(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final favoriteItems = snapshot.data!;
                                final isFavorite = favoriteItems.any(
                                    (favoriteItem) =>
                                        favoriteItem.sId == widget.itemId);
                                return GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      // Remove item from favorites
                                      updateFavoriteItem(widget.itemId);
                                    } else {
                                      // Add item to favorites
                                      updateFavoriteItem(widget.itemId);
                                    }
                                  },
                                  child: isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: Text(
                        '£ ${item.price.toString()}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text(
                                item.city ?? 'City',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Category',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              Text(
                                item.category ?? 'Category',
                                style: const TextStyle(
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
                            children: [
                              const Text(
                                'Condition',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              Text(
                                item.condition ?? 'Used',
                                style: const TextStyle(
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
                            item.description ?? 'Description Unknown',
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
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.user!.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Member since ${reverseDateFormat(item.user!.joinAt!)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewProfilePage(
                                          userId: item.user!.sId!,
                                          userName: item.user!.name!,
                                          userPhoto: item.user!.photo!,
                                          joinedAt: item.user!.joinAt!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'See Profile',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor,
                                        fontSize: 20),
                                  ),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "For Your Safety :",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right),
                                Expanded(
                                    child: Text(
                                  "Only meet in public / crowded places for example metro stations and malls.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right),
                                Expanded(
                                    child: Text(
                                  "Never go alone to meet a buyer / seller, always take someone with you.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right),
                                Expanded(
                                    child: Text(
                                  "Check and inspect the product properly before purchasing it..",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_right),
                                Expanded(
                                    child: Text(
                                  "Never pay anything in advance or transfer money before inspecting the product.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomButton(
                    buttonText: 'Chat',
                    onTap: () async {
                      try {
                        final token = await storage.read(key: 'token');
                        final currentUserID = getCurrentUserIdFromToken(token!);
                        if (currentUserID == item.user!.sId) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Failed to create chat room. You can not chat with yourself here'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final chatRoomData =
                              await createChatRoom(item.user!.sId!);
                          final chatRoom = chatRoomData['chatRoom'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleChatRoomPage(
                                chatRoomId: chatRoom['_id'],
                                currentUserID: currentUserID,
                                userImage: item.user!.photo!,
                                userName: item.user!.name!,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (e is Exception &&
                            e
                                .toString()
                                .contains('Failed to create chat room: 500')) {
                          // Handle 500 error
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Failed to create chat room. Please try again later.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Handle other errors
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
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
    );
  }
}
