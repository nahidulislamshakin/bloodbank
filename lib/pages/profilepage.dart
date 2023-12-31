import 'package:bloodbank/pages/becomedonorpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? uid;
  String? email;
    String userName = "";
   String imageUrl = "";
  Future<void> getUser() async {
    
    final User currentUser = await FirebaseAuth.instance.currentUser!;
    // return currentUser;
    uid = currentUser.uid;
    email = currentUser.email;
     await FirebaseFirestore.instance.collection("User").doc(uid).get().then((value) {
      setState(() {
        userName = value.get("Name").toString();
        imageUrl = value.get("imageUrl").toString();
      });
    });
  }




  @override
  void initState() {
    super.initState();
    getUser();
    
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(

          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                 width: 120,
                 height: 120,
                child: 
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: imageUrl.isEmpty? CircularProgressIndicator(color: Colors.red,) : 
                  Image.network(
                    imageUrl, 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FittedBox(
                child: userName.isEmpty ? CircularProgressIndicator(color: Colors.red,) :
                  Text("$userName",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BecomeDonorPage(),
                  //   ),
                  // );
                },
                child: Text("Edit Profile",style: TextStyle(fontSize: 18),),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      )),
    );
  }
}
