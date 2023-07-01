import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import '../../services/chat_services.dart';
import '../../widgets/chat_bubbles.dart';

class SingleChatRoomPage extends StatefulWidget {
  final String chatRoomId;
  final String currentUserID;
  final String userImage;
  final String userName;

  const SingleChatRoomPage({
    Key? key,
    required this.chatRoomId,
    required this.currentUserID,
    required this.userImage,
    required this.userName,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SingleChatRoomPageState createState() => _SingleChatRoomPageState();
}

class _SingleChatRoomPageState extends State<SingleChatRoomPage> {
  late Future<Map<String, dynamic>> _futureChatRoom;
  final TextEditingController _textEditingController = TextEditingController();
  List<dynamic> messages = [];

  @override
  void initState() {
    super.initState();
    _futureChatRoom = singleChatRoom(widget.chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://unihub.azurewebsites.net/imgs/users/${widget.userImage}"),
            ),
            const SizedBox(width: 18),
            Text(widget.userName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _futureChatRoom,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final chatRoom = snapshot.data!['chatRoom'];
                  messages = chatRoom['Messages'];
                   final currentUser = widget.currentUserID;
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text('There are no messages yet.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message['user']['_id'] == currentUser;
                      return ChatBubble(
                        message: message['content'],
                        date: message['date'],
                        isMe: isMe,
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
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(255, 213, 213, 213),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12)),
                    style: const TextStyle(color: Colors.black),
                    cursorColor: kPrimaryColor,
                    onSubmitted: (value) async {
                      final messageContent = value;
                      if (messageContent.isNotEmpty) {
                        final mostRecentMessage = await postMessage(
                            widget.chatRoomId, messageContent);
                        setState(() {
                          messages.insert(0, mostRecentMessage);
                        });
                        _textEditingController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final messageContent = _textEditingController.text;
                    if (messageContent.isNotEmpty) {
                      final mostRecentMessage =
                          await postMessage(widget.chatRoomId, messageContent);
                      setState(() {
                        messages.add(mostRecentMessage);
                      });
                      _textEditingController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
