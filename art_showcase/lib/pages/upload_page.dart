import 'package:flutter/material.dart';
import '../helpers/bottom_bar.dart'; // Ensure the correct import path
//import 'package:image_picker/image_picker.dart';
//import 'package:firestore/firestore.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerArtist = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  String? _selectedTag;
  final List<String> _tags = [
    'Painting',
    'Photography',
    'Sculpture',
    'Digital Art',
    'Drawing'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerArtist,
                decoration: const InputDecoration(labelText: 'Artist Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the artist name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerDescription,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                  value: _selectedTag,
                  hint: Text("Select a tag"),
                  items: _tags.map((tag) {
                    return DropdownMenuItem<String>(
                      value: tag,
                      child: Text(tag),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTag = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a tag';
                    }
                    return null;
                  }),
              const IconButton(onPressed: null, icon: Icon(Icons.upload_file)),
              const ElevatedButton(onPressed: null, child: Text('Post'))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
