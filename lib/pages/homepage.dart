import 'package:bloodbank/pages/about.dart';
import 'package:bloodbank/pages/donarlistpage.dart';
import 'package:bloodbank/pages/signinpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text("Blood Bank"),
        centerTitle: _deviceWidth < 500 ? true : null,
        // leading: IconButton(
        //   onPressed: () => scaffoldKey.currentState!.openDrawer(),
        //   icon: Icon(Icons.menu),
        // ),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.red,
        width: _deviceWidth / 1.5,
        child: ListView(
          shrinkWrap: true,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "$currentUserName",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              accountEmail: Text(
                "$email",
                style: GoogleFonts.openSans(
                    textStyle: const TextStyle(color: Colors.black)),
              ),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.red, Colors.brown])),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.red,
                size: 30,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              onTap: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.developer_board,
                color: Colors.red,
                size: 30,
              ),
              title: const Text(
                "About",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(
                    "images/icons/logout.png",
                  )),
              title: const Text(
                "Sign out",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              onTap: () async {
                await _authService.signOut();
                if (FirebaseAuth.instance.currentUser == null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false);
                }
              },
            ),
          ],
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //   //  MyHeaderDrawer();
          //     Container(
          //       width: double.infinity,
          //       height: _deviceHeight / 3,

          //       // color: Colors.red,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.rectangle,
          //         color: Colors.red,
          //       ),
          //       child: FittedBox(
          //         fit: BoxFit.scaleDown,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(left:8.0),
          //               child: Text(
          //                 "$currentUserName",
          //                 style: TextStyle(fontSize: 20),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left:8.0),
          //               child: Text(
          //                 "$email",
          //                 style: TextStyle(fontSize: 16),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Container(
          //       padding: EdgeInsets.all(5),
          //       child: Column(
          //         children: [
          //           GestureDetector(
          //             onTap: () async{
          //               await _authService.signOut();
          //               if (FirebaseAuth.instance.currentUser == null) {
          //                 Navigator.pushAndRemoveUntil(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => SignInPage()),
          //                     (route) => false);
          //               }
          //             },
          //             child: Text(
          //               "Sign Out",
          //               style: TextStyle(fontSize: 20),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                                // width: 50,
                                height: 50,
                                child: Image.asset(
                                    "images/icons/blood_request.png"),
                              ),
                              "Request"),
                          const SizedBox(
                            width: 10,
                          ),

                          Button(
                              Container(
                                // width: 50,
                                height: 50,
                                child: const Icon(Icons.feed),
                              ),
                              "Feed"),
                          const SizedBox(
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
                      const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: _deviceWidth,
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //   style:ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.red,
                      //   ),
                      //   onPressed: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DonorList()));
                      // },
                      //  child: Text("Find Donor",
                      //  style: TextStyle(fontSize: 20),)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bloodGroupButton("A+", context),
                          bloodGroupButton("B+", context),
                          bloodGroupButton("AB+", context),
                          bloodGroupButton("O+", context),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bloodGroupButton("A-", context),
                          bloodGroupButton("B-", context),
                          bloodGroupButton("AB-", context),
                          bloodGroupButton("O-", context),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset("images/bloodchart.jpg"),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.only(top: 50),
                //       decoration: BoxDecoration(
                //         border: Border.all(),
                //         color: Colors.red,

                //       ),
                //       child: Text("Nahidul Islam Shakin"),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
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
          const SizedBox(
            height: 5,
            // width: 5,
          ),
          Text(iconName),
        ],
      ),
    ),
  );
}

Widget bloodGroupButton(String bloodGroup, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DonorList(
                    bloodGroup: bloodGroup,
                  ))));
    },
    child: Container(
      width: 60,
      height: 60,
      // margin: EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
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
    ),
  );
}
