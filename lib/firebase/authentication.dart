import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodbank/user_model/user.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  UserModel? userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return UserModel(email: user.email, password: user.uid);
    }
  }

  Stream<UserModel?>? get user{
  //  try{
      print("get user is worked");
      return _firebaseAuth.authStateChanges().map(userFromFirebase);

   // } on FirebaseAuthException catch(error)
  //  {
  //    print(error.code);
  //  } catch(error)
  //  {
   //   print(error);
  //  }

  }
//
//   User? user(){
//     print("get user is worked");
//     return _firebaseAuth.currentUser;
// }

  Future<UserModel?> signInWithEmailAndPassword(String email, String password)async{
  //  try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(userCredential.user);
 //   } on FirebaseAuthException catch (error){
   //   Fluttertoast.showToast(msg: error.message!, gravity: ToastGravity.TOP);
  //  }
  }

  Future<UserModel?> createAccountWithEmailAndPassword(String email, String password) async{

  //  try{
      final UserCredential? userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(userCredential?.user);
   // }on FirebaseAuthException catch(error){
   //   print(error.code);
  //  }

  }

  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }



}