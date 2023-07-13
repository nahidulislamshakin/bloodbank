import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Blood Bank"),
          centerTitle: _deviceWidth < 500 ? true : null,
          leading: IconButton(
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
            icon: Icon(Icons.menu),
          ),
        ),
        drawer: Container(
          width: _deviceWidth / 2,
          color: Colors.red,
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
                          SizedBox(height: 10,),

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
                      ))
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
