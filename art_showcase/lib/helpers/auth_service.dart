// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      // after creating new user, create new document for the user in users collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
