import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/chat_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/providers/auth_provider.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String senderId;
  String receiverId;
  String name;
  ChatScreen({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  // FirebaseAuth.instance.
  final ChatProvider _chatProvider = ChatProvider();
  final AuthProvider _authProvider = AuthProvider();
  void sendMessage() async {
    if (msgController.text.isNotEmpty) {
      await _chatProvider.sendMessage(widget.receiverId, msgController.text);

      msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  _chatProvider.getMessages(widget.receiverId, widget.senderId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went Wrong"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Constants.primaryColor,
                    ),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs
                      .map((doc) => _buildMessageItem(doc))
                      .toList(),
                );
              },
            ),
          ),
          SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration:
                          const InputDecoration(hintText: 'Enter Message'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send, color: Constants.primaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authProvider.getCurrentUser().uid;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isCurrentUser ? Constants.primaryColor : Colors.black54,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              data['message'],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
