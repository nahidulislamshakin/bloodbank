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


  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      e.message;
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

  //  Future<UserModel?> SignUP(String email, String password, String name, String phone, String bloodgroup, String district) async{

  //   try{
  //     final UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
  //       await FirebaseFirestore.instance.collection("user").doc(value.user?.uid).set({
  //         "email":value.user?.email,
  //         "name":name,
  //         "phone":phone,
  //         "location":district,
  //       "password":password,
  //       "Blood Group":bloodgroup,
  //       },
  //       );

  //     });
  //     return userFromFirebase(userCredential?.user);
  //  } catch(error){
  //    print(error);
  //  }

//}

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  Future<void> sendData(String name, String email, String phone,
      String bloodgroup, String Password, String district) async {
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
    });
    return;
  }
}
