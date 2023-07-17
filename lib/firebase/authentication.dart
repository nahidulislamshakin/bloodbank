import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodbank/user_model/user.dart';

class Authentication {
  // UserModel? userFromFirebase(User? user) {
  //   if (user == null) {
  //     return null;
  //   } else {
  //     return UserModel(email: user.email, password: user.uid);
  //   }
  // }

  // Stream<UserModel?>? get user {
  //   print("get user is worked");
  //   return FirebaseAuth.instance.authStateChanges().map(userFromFirebase);
  // }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return null;
      // if(FirebaseAuth.instance.currentUser!=null){

      // }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> sendData(String name, String email, String phone,
      String bloodgroup, String Password, String district,String imageUrl, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "Name": name,
        "Email": email,
        "Phone": phone,
        "Blood Group": bloodgroup,
        "Password": Password,
        "District": district,
        "Uid":uid,
        "imageUrl":imageUrl
      });
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    //  return;
  }
}
