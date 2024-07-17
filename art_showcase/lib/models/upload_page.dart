import 'package:flutter/material.dart';
import '../helpers/bottom_bar.dart'; // Ensure the correct import path

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      /*
      body:

      */
      bottomNavigationBar: BottomBar(),
    );
  }
}
