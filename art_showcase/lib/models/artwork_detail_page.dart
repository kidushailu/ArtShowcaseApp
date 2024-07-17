import 'package:flutter/material.dart';
import '../helpers/bottom_bar.dart'; // Ensure the correct import path

class ArtworkDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArtWork Details'),
      ),
      /*
      body:


      */
      bottomNavigationBar: BottomBar(),
    );
  }
}
