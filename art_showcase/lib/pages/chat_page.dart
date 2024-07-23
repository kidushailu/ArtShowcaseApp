import 'package:art_showcase/helpers/chat_service.dart';
import 'package:art_showcase/helpers/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUsername,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      // clear text controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverUsername),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              // messages
              Expanded(
                child: _buildMessageList(),
              ),
              // user input
              _buildMessageInput(),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ));
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList());
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align messages to the right if sender is current user, otherwise to the left
    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          (data['senderId'] == _auth.currentUser!.uid)
              ? const Text('You')
              : Text(widget.receiverUsername),
          ChatBubble(message: data['message']),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(hintText: "Enter Message"),
              obscureText: false,
            )),
            IconButton(
                padding: const EdgeInsets.all(2),
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.arrow_upward,
                  size: 30,
                ))
          ],
        ));
  }
}
