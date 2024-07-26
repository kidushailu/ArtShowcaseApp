import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'comment.dart';

class CommentSection extends StatefulWidget {
  final String postId;
  const CommentSection({super.key, required this.postId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController _commentController = TextEditingController();

  // add comment
  void postComment(String comment) async {
    DocumentSnapshot docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.email)
        .get();

    Map<String, dynamic> docData = docRef.data() as Map<String, dynamic>;

    // write comment to firestore under comments collection for this post
    FirebaseFirestore.instance
        .collection('artworks')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'text': comment,
      'user': docData['username'],
      'time': Timestamp.now()
    });
  }

  // dialog box for adding comment
  void showCommentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add a comment'),
              content: TextField(
                controller: _commentController,
                decoration:
                    const InputDecoration(hintText: 'Write a comment...'),
              ),
              actions: [
                //save button
                TextButton(
                    onPressed: () {
                      postComment(_commentController.text);
                      Navigator.pop(context);
                      _commentController.clear();
                    },
                    child: const Text('Post')),

                // cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentController.clear();
                    },
                    child: const Text('Cancel'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _commentList(),
        Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              padding: const EdgeInsets.all(20),
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: Colors.grey[600],
              ),
              onPressed: () => showCommentDialog(context),
            ))
      ],
    );
  }

  Widget _commentList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('artworks')
            .doc(widget.postId)
            .collection('comments')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // get the message
                  final post = snapshot.data!.docs[index];
                  return Comment(
                    text: post['text'],
                    user: post['user'],
                    time: post['time'],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error:${snapshot.error}',
            ));
          }
          return const Center(
            child: Text('No comments.'),
          );
        });
  }
}
