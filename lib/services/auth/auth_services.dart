import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign in
  Future<UserCredential> signInWithEmailAndPassword (String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword (String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      });

      // // Store user data in Firestore
      // await _firestore.collection('users').doc(userCredential.user!.uid).set({
      //   'uid' : userCredential.user!.uid,
      //   'email': email,
      //   'createdAt': Timestamp.now(),
      // });

      return userCredential;
    } on FirebaseAuthException catch  (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}