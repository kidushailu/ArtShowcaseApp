// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      // sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // create new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  dynamic getDocumentBasedOnContents(String imageUrl) async {
    // Initialize Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Specify the collection and the field to query
    CollectionReference collectionRef = firestore.collection('artworks');

    // Perform the query
    QuerySnapshot querySnapshot =
        await collectionRef.where('image', isEqualTo: imageUrl).get();

    // Process the results
    if (querySnapshot.docs.isNotEmpty) {
      Map info = querySnapshot.docs.map((e) => e.data() as Map).toList().first;
      return info;
    }
    return;
  }
}
