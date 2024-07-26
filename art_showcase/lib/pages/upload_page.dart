import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home_page.dart';
import '../helpers/bottom_bar.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('artworks');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(key: _formkey, children: [
          Column(
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
                  hint: const Text("Select a tag"),
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
              imageUrl.isEmpty
                  ? IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (file == null) return;

                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        try {
                          await referenceImageToUpload.putFile(File(file.path));

                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (e) {}
                      },
                      icon: const Icon(Icons.upload_file))
                  : Container(
                      child: Image.network(imageUrl),
                    ),
              ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please upload an image")));
                      return;
                    }

                    // Create a map of data
                    Map<String, dynamic> dataToSend = {
                      'title': _controllerTitle.text,
                      'artist': _controllerArtist.text,
                      'description': _controllerDescription.text,
                      'tag': _selectedTag,
                      'timestamp': Timestamp.now(),
                      'image': imageUrl,
                      'uid': _auth.currentUser!.uid
                    };

                    // Add new item
                    _reference.add(dataToSend);

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text('Post'))
            ],
          ),
        ]),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
