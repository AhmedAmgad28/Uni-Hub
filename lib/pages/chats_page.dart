import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_v2/pages/Account_page.dart';
import '../helper/constants.dart';
import '../services/chat_services.dart';
import 'single_chat_page.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key, required this.userId}) : super(key: key);
  static String id = 'ChatsPage';
  final String userId;

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late Future<Map<String, dynamic>> _futureChatRooms;
  String? userId;

  String reverseDateFormat(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(parsedDate);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    _futureChatRooms = fetchChatRooms();
    userId = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
            'Chats',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureChatRooms,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final chatRooms = snapshot.data!['chatRooms'];
            if (chatRooms.length > 1) {
              chatRooms.sort((a, b) {
                final aDate = a['Messages'].isNotEmpty
                    ? DateTime.parse(a['Messages'].last['date'])
                    : DateTime(2000);
                final bDate = b['Messages'].isNotEmpty
                    ? DateTime.parse(b['Messages'].last['date'])
                    : DateTime(2000);
                return bDate.compareTo(aDate);
              });
            }
            const defaultProfileImgUrl =
                'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/626fd8140423801.6241b91e24d9c.png';
            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                final lastMessage = chatRoom['Messages'].isNotEmpty
                    ? chatRoom['Messages'].last
                    : null;
                final lastMessageDate = lastMessage != null
                    ? reverseDateFormat(lastMessage['date'])
                    : 'No messages';
                final lastMessageContent = lastMessage != null
                    ? lastMessage['content'].toString()
                    : '';
                final reciever = chatRoom['reciever'];
                final sender = chatRoom['sender'];
                final isCurrentUserReciever = userId == reciever['_id'];
                final profileImgUrl = isCurrentUserReciever
                    ? sender['photo'] != null &&
                            Uri.parse(sender['photo']).isAbsolute
                        ? sender['photo']
                        : defaultProfileImgUrl
                    : reciever['photo'] != null &&
                            Uri.parse(reciever['photo']).isAbsolute
                        ? reciever['photo']
                        : defaultProfileImgUrl;
                final name =
                    isCurrentUserReciever ? sender['name'] : reciever['name'];
                return GestureDetector(
                  onTap: () async {
                    final userId = widget.userId;
                    // ignore: unnecessary_null_comparison
                    if (userId != null) {
                      // ignore: unused_local_variable
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleChatRoomPage(
                            chatRoomId: chatRoom['_id'],
                            currentUserID: userId,
                            userImage: profileImgUrl,
                            userName: name,
                          ),
                        ),
                      );
                    }
                  },
                  // ignore: sized_box_for_whitespace
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: 100,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 4.0),
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(profileImgUrl),
                              ),
                              const SizedBox(width: 14.0),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          lastMessageDate,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      lastMessageContent,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
