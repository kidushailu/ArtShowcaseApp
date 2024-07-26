// ignore_for_file: must_be_immutable

import 'package:art_showcase/helpers/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/comment_section.dart';

class ArtworkDetailPage extends StatefulWidget {
  final String imageUrl;
  final String postId;
  const ArtworkDetailPage(
      {super.key, required this.imageUrl, required this.postId});

  @override
  State<ArtworkDetailPage> createState() => _ArtworkDetailPageState();
}

class _ArtworkDetailPageState extends State<ArtworkDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  late Map artDetails = {};
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() async {
    AuthService authService = AuthService();
    Map info = await authService.getDocumentBasedOnContents(widget.imageUrl);

    setState(() {
      artDetails = info;
    });
  }

  // post a comment
  void postComment(String comment) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUser)
        .get()
        .toString();

    // only post is there is something to post
    if (_commentController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('comments').add({
        'comment': comment,
        'username': user,
        'imageId': widget.imageUrl,
        'timestamp': DateTime.now()
      });
    }

    setState(() {
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(artDetails['title'].toString()),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Image.network(widget.imageUrl),
              const SizedBox(
                height: 8,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  artDetails['description'].toString(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Created by ${artDetails['artist'].toString()}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Comments',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ]),
          ),
          Container(
              padding:
                  const EdgeInsets.only(right: 8, left: 8, top: 0, bottom: 8),
              height: 320,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: CommentSection(postId: widget.postId))
        ]));
  }
}
