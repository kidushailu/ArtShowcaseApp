import 'package:art_showcase/helpers/text_box.dart';
import 'package:art_showcase/helpers/user_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).primaryColorLight,
              title: Text(
                'Edit $field',
                style: const TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter new $field',
                    hintStyle: TextStyle(color: Colors.grey[200])),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                // cancel button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    )),

                // save button
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      // only update if there is something in textfield
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.email)
          .update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // get user data
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[300]),
                      child: const Icon(
                        Icons.person,
                        size: 72,
                      )),
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'My details',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  MyTextBox(
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField('username'),
                  ),
                  MyTextBox(
                    text: userData['bio'],
                    sectionName: 'Bio',
                    onPressed: () => editField('bio'),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // user posts
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'My posts',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      height: 500,
                      width: 400,
                      child: const UserPosts())
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
