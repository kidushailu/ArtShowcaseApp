import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/artwork_detail_page.dart';

class UserPosts extends StatelessWidget {
  final String? postId;
  const UserPosts({super.key, this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('artworks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> posts =
                snapshot.data!.docs.map((e) => e.data() as Map).toList();

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 2.0),
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  // get the image at this index
                  Map thisImage = posts[index];
                  // return the widget for the list items
                  if (thisImage['uid'] ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return GestureDetector(
                      child: thisImage.containsKey('image')
                          ? Image.network('${thisImage['image']}')
                          : Container(),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ArtworkDetailPage(
                              imageUrl: thisImage['image'],
                              postId: postId.toString()),
                        ));
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error:${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
