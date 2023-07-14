import 'package:bloodbank/pages/signinpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../firebase/authentication.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? currentUserName;
  String? uid;
  String? email;

  Future<void> getUser() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User currentUser = firebaseAuth.currentUser!;
    // return currentUser;
    uid = currentUser.uid;
    email = currentUser.email;
  }

  Future<void> getUserName() async {
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((value) {
      setState(() {
        currentUserName = value.get("Name").toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Blood Bank"),
          centerTitle: _deviceWidth < 500 ? true : null,
          // leading: IconButton(
          //   onPressed: () => scaffoldKey.currentState!.openDrawer(),
          //   icon: Icon(Icons.menu),
          // ),
        ),
        drawer: Drawer(
          // backgroundColor: Colors.red,
          width: _deviceWidth / 1.5,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: _deviceHeight / 3,

                  // color: Colors.red,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            "$currentUserName",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            "$email",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async{
                          await _authService.signOut();
                          if (FirebaseAuth.instance.currentUser == null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()),
                                (route) => false);
                          }
                        },
                        child: Text(
                          "Sign Out",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Expanded(
                            //   child: Container(
                            //     width: 50,
                            //     height: 50,
                            //     color: Colors.red,
                            //   ),
                            // ),
                            Button(
                                Container(
                                  // color: Colors.red.shade200,
                                  height: 50,
                                  child: Image.asset(
                                      "images/icons/blood_request.png"),
                                ),
                                "Request"),
                            SizedBox(
                              width: 10,
                            ),

                            Button(
                                Container(
                                  // width: 50,
                                  height: 50,
                                  child: Icon(Icons.feed),
                                ),
                                "Feed"),
                            SizedBox(
                              width: 10,
                            ),
                            Button(
                                Container(
                                  // width: 50,
                                  height: 50,
                                  child: Image.asset(
                                      "images/icons/organization-chart.png"),
                                ),
                                "Organization"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Button(
                                Container(
                                  //  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                    'images/icons/ambulance.png',
                                  ),
                                ),
                                "Ambulance"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: _deviceWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Container(
                            //   // width: 50,
                            //   // height: 50,
                            //   // margin: EdgeInsets.all(5),
                            //   padding: EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       color: Colors.red),
                            //   child: FittedBox(
                            //       child: Text(
                            //     "A+",
                            //     style: TextStyle(fontSize: 30),
                            //     //textAlign: TextAlign.center,
                            //   ),),
                            //   //   color: Colors.red,
                            // ),
                            bloodGroupButton("A+"),
                            bloodGroupButton("B+"),
                            bloodGroupButton("AB+"),
                            bloodGroupButton("O+"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            bloodGroupButton("A-"),
                            bloodGroupButton("B-"),
                            bloodGroupButton("AB-"),
                            bloodGroupButton("O-"),
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await _authService.signOut();
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                              (route) => false);
                        }
                      },
                      child: Text("Sign out"))
                ],
              ),
            ),
          ),
        ));
  }
}

Widget Button(Widget icon, String iconName) {
  return Expanded(
    child: Container(
      color: Colors.red,
      // width: 100,
      // height: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: icon,
          ),
          SizedBox(
            height: 5,
            // width: 5,
          ),
          Text(iconName),
        ],
      ),
    ),
  );
}

Widget bloodGroupButton(String bloodGroup) {
  return Container(
    width: 60,
    height: 60,
    // margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(50),
        shape: BoxShape.circle,
        color: Colors.red),
    child: FittedBox(
      child: Text(
        bloodGroup,
        // style: TextStyle(fontSize: 25),
        //textAlign: TextAlign.center,
      ),
    ),
    //   color: Colors.red,
  );
}
