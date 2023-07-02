import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:project_v2/helper/constants.dart';
import '../../models/product_model.dart';
import '../../services/Favourite_service.dart';
import '../../services/chat_services.dart';
import '../../services/item_services.dart';
import 'product_details_page.dart';
import '../chat/single_chat_page.dart';

class ViewProfilePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ViewProfilePage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userPhoto,
      required this.joinedAt});
  final String userId;
  final String userName;
  final String userPhoto;
  final String joinedAt;
  static String id = 'ViewProfilePage';

  @override
  // ignore: library_private_types_in_public_api
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final storage = const FlutterSecureStorage();
  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

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

  late Future<itemsModel> _futureItemsModel;
  final defaultProfileImgUrl =
      'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/626fd8140423801.6241b91e24d9c.png';

  @override
  void initState() {
    super.initState();
    _futureItemsModel = getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          '${widget.userName}\'s Profile',
          style: const TextStyle(
            color: kBackgroundColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            "https://unihub.azurewebsites.net/imgs/users/${widget.userPhoto}",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Text(
                                'Joined at: ${reverseDateFormat(widget.joinedAt)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Chat with ${widget.userName}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        final token =
                                            await storage.read(key: 'token');
                                        final currentUserID =
                                            getCurrentUserIdFromToken(token!);
                                        if(currentUserID == widget.userId){
                                          // ignore: use_build_context_synchronously
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content:  const Text(
                                                  'Failed to create chat room. You can'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                        final chatRoomData =
                                            await createChatRoom(widget.userId);
                                        final chatRoom =
                                            chatRoomData['chatRoom'];
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleChatRoomPage(
                                              chatRoomId: chatRoom['_id'],
                                              currentUserID: currentUserID,
                                              userImage: widget.userPhoto,
                                              userName: widget.userName,
                                            ),
                                          ),
                                        );
                                        }
                                      } catch (e) {
                                        if (e is Exception &&
                                            e.toString().contains(
                                                'Failed to create chat room: 500')) {
                                          // Handle 500 error
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Failed to create chat room. Please try again later.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
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
                                    icon: const Icon(
                                      Icons.chat_rounded,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      "${widget.userName}'s Ads:",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: FutureBuilder<itemsModel>(
                      future: _futureItemsModel,
                      builder: (BuildContext context,
                          AsyncSnapshot<itemsModel> snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!.data;
                          final items = data!.items!
                              .where((item) =>
                                  item.user!.sId ==
                                  widget.userId) // filter the items
                              .toList();
                          return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = items[index];
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
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 0,
                                              offset: const Offset(10, 10)),
                                        ],
                                      ),
                                      child: Card(
                                        elevation: 16,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 14,
                                              bottom: 12,
                                              top: 12,
                                              left: 40),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 70),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        item.title!,
                                                        style: const TextStyle(
                                                            color:
                                                                kPrimaryColor,
                                                            fontSize: 20,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ),
                                                    ),
                                                    FutureBuilder<List<Items>>(
                                                      future: getFavourites(),
                                                      builder:
                                                          (context, snapshot) {
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
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                          );
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.red,
                                                          );
                                                        } else {
                                                          return const Icon(
                                                            Icons
                                                                .favorite_border,
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
                                                padding: const EdgeInsets.only(
                                                    left: 70),
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
                                                padding: const EdgeInsets.only(
                                                    left: 70),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.category!,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      item.city!,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      reverseDateFormat(
                                                          item.createAt!),
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.blueGrey,
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
            ),
          ),
        ],
      ),
    );
  }
}
