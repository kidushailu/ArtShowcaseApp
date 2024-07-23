import 'package:flutter/material.dart';
import '../helpers/bottom_bar.dart'; // Ensure the correct import path

class ArtworkDetailPage extends StatelessWidget {
  const ArtworkDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArtWork Details'),
      ),
      /*
      body:


      */
      bottomNavigationBar: const BottomBar(),
    );
  }
}
