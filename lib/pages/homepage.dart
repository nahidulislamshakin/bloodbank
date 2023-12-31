import 'package:bloodbank/pages/about.dart';
import 'package:bloodbank/pages/ambulance.dart';
import 'package:bloodbank/pages/donarlistpage.dart';
import 'package:bloodbank/pages/feedpage.dart';
import 'package:bloodbank/pages/organization.dart';
import 'package:bloodbank/pages/profilepage.dart';
import 'package:bloodbank/pages/requestpage.dart';
import 'package:bloodbank/pages/signinpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../firebase/authentication.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  String currentUserName = "";
  String? uid;
  String email = "";
  String imageUrl = "";

  Future<void> getUser() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User currentUser = await firebaseAuth.currentUser!;
    // return currentUser;
    uid = currentUser.uid;
    email = currentUser.email!;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        currentUserName = value.get("Name").toString();
        imageUrl = value.get("imageUrl").toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
      //  key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text("Blood Bank"),
        centerTitle: _deviceWidth < 600 ? true : false,
        // leading: IconButton(
        //   onPressed: () => scaffoldKey.currentState!.openDrawer(),
        //   icon: Icon(Icons.menu),
        // ),
      ),
      drawer: Drawer(
              // backgroundColor: Colors.red,
              width: _deviceWidth / 1.5,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      "$currentUserName",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    accountEmail: Text(
                      "$email",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.red, Colors.brown]),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.red,
                      size: 30,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.developer_board,
                      color: Colors.red,
                      size: 30,
                    ),
                    title: Text(
                      "About",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutPage(),
                        ),
                      );
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: Image.asset(
                          "images/icons/logout.png",
                        )),
                    title: Text(
                      "Sign out",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp),
                    ),
                    onTap: () async {
                      await _authService.signOut();
                      if (FirebaseAuth.instance.currentUser == null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                            (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: 
                 Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestPage(),
                                ),
                              ),
                              child: Button(
                                  // Image.asset("images/icons/blood_request.png"), "Request")
                                  Container(
                                    // color: Colors.red.shade200,
                                    width: 50.w,
                                    height: 50.h,
                                    child: Image.asset(
                                        "images/icons/blood_request.png"),
                                  ),
                                  "Request",
                                  context),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeedPage(),
                                ),
                              ),
                              child: Button(
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    child: Icon(
                                      Icons.feed,
                                      size: 50,
                                    ),
                                  ),
                                  "Feed",
                                  context),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrganizationPage(),
                                ),
                              ),
                              child: Button(
                                  Container(
                                    width: 50.w,
                                    height: 50.h,
                                    child: Image.asset(
                                        "images/icons/organization-chart.png"),
                                  ),
                                  "Organization",
                                  context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AmbulancePage(),
                                ),
                              ),
                              child: Button(
                                  // Image.asset("images/icons/blood_request.png"), "Request")
                                  Container(
                                    // color: Colors.red.shade200,
                                    // width: 50,
                                    height: 50.h,
                                    child: Image.asset(
                                        "images/icons/ambulance.png"),
                                  ),
                                  "Ambulance",
                                  context),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        //    width: _deviceWidth,
                        //  height: 180,
                        //  color: Colors.green,
                        //  height: _deviceHeight/3,
                        child: Column(
                          children: [
                            Wrap(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                bloodGroupButton("A+", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("B+", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("AB+", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("O+", context),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Wrap(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                bloodGroupButton("A-", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("B-", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("AB-", context),
                                SizedBox(
                                  width: 10.w,
                                ),
                                bloodGroupButton("O-", context),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        "images/bloodchart.jpg",
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

Widget Button(Widget icon, String iconName, BuildContext context) {
  final _deviceHeight = MediaQuery.of(context).size.width;
  final _deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    // color: Colors.red,
    width: 100.w,
    height:  90.h,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        FittedBox(
          child: Text(
            iconName,
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
      ],
    ),
  );
}

Widget bloodGroupButton(String bloodGroup, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonorList(bloodGroup: bloodGroup),
        ),
      );
    },
    child: Container(
      width: 70.w,
      height: 70.h,

      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Center(
        child: Text(
          bloodGroup,
          style: TextStyle(fontSize: 22.sp),
          //textAlign: TextAlign.center,
        ),
      ),
      //   color: Colors.red,
    ),
  );
}
