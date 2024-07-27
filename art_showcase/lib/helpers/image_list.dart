// ignore_for_file: must_be_immutable

import '../pages/artwork_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final String? filter;
  ImageList({super.key, this.filter});

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('artworks')
      .orderBy('timestamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: StreamBuilder(
            stream: (filter != null)
                ? FirebaseFirestore.instance
                    .collection('artworks')
                    .where('tag', isEqualTo: filter)
                    .orderBy('timestamp', descending: true)
                    .snapshots()
                : _stream,
            builder: _displayImages));
  }

  Widget _displayImages(BuildContext context, AsyncSnapshot snapshot) {
    // check error
    if (snapshot.hasError) {
      return Center(
        child: Text("Some error occurred: ${snapshot.error}"),
      );
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    // check if data arrived
    if (snapshot.hasData) {
      // get the data
      QuerySnapshot querySnapshot = snapshot.data;
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      // Convert the documents to maps
      List<Map> images = documents.map((e) => e.data() as Map).toList();

      // display the list
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 2.0),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            // get the image at this index
            Map thisImage = images[index];
            // return the widget for the list items
            return GestureDetector(
              child: thisImage.containsKey('image')
                  ? Image.network('${thisImage['image']}')
                  : Container(),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArtworkDetailPage(
                          imageUrl: thisImage['image'],
                          postId: documents[index].id,
                        )));
              },
            );
          });
    }
    return const Center(child: Text("No data."));
  }
}
