import 'package:bloodbank/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/authentication.dart';

//  const List<String> districtList = [
//   "Gopalganj",
//   "Dhaka",
//   "Khulna",
//   "Barisal",
//   "Rangpur",
//   "Chittagong",
//   "Gazipur",
//   "Sylhet"
// ];

class BecomeDonorPage extends StatefulWidget {
  // get districtLeangth => null;

  @override
  State<BecomeDonorPage> createState() => _BecomeDonorPageState();
}

class _BecomeDonorPageState extends State<BecomeDonorPage> {
  final signupFormKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  String phone = "";
  String bloodgroup = "";
  String district = "";

  TextEditingController? nameController;

  TextEditingController? emailController;

  TextEditingController? phoneController;

  TextEditingController? bloodgroupController;

  TextEditingController? districtController;

  TextEditingController? passwordController;

  static const List<String> bloodGroupList = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-"
  ];
  static const List<String> districtList = [
    "Gopalganj",
    "Dhaka",
    "Khulna",
    "Barisal",
    "Rangpur",
    "Chittagong",
    "Gazipur",
    "Sylhet"
  ];
  List<String> districtGet() {
    return districtList;
  }

  String bloodGroupDropDownValue = bloodGroupList.first;
  String districtDropDownValue = districtList.first;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();

    phoneController = TextEditingController();

    bloodgroupController = TextEditingController();

    districtController = TextEditingController();

    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Blood Bank"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: signupFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: "Full Name",
                            // prefix: Text("Name"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Invalid Name";
                            } else {
                              name = value;
                            }
                          },
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            labelText: "E-mail",
                            // prefix: Text("Name"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Invalid Email";
                            } else {
                              email = value;
                            }
                          },
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            labelText: "Phone",
                            // prefix: Text("Name"),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Invalid Phone Number";
                            } else {
                              phone = value;
                            }
                          },
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          //  padding: const EdgeInsets.only(left: 5,right: 5),
                          //
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 20),
                              child: DropdownButton(
                                //hint: Text("Blood Group"),
                                dropdownColor: Colors.red.shade100,
                                elevation: 5,
                                //  isDense: true,
                                isExpanded: true,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                value: bloodGroupDropDownValue,
                                icon: const Icon(Icons.arrow_downward),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.red,
                                // ),
                                onChanged: (value) {
                                  setState(() {
                                    bloodGroupDropDownValue = value!;
                                  });
                                  bloodgroup = value;
                                },
                                items: bloodGroupList
                                    .map<DropdownMenuItem>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: FittedBox(
                                        child: Text(
                                      value,
                                      style: const TextStyle(color: Colors.red),
                                    )),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          //  padding: const EdgeInsets.only(left: 5,right: 5),
                          //
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 20),
                              child: DropdownButton(
                                //hint: Text("Blood Group"),
                                dropdownColor: Colors.red.shade100,
                                elevation: 5,
                                //  isDense: true,
                                isExpanded: true,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                value: districtDropDownValue,
                                icon: const Icon(Icons.arrow_downward),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.red,
                                // ),
                                onChanged: (value) {
                                  setState(() {
                                    districtDropDownValue = value!;
                                  });
                                  district = value;
                                },
                                items: districtList
                                    .map<DropdownMenuItem>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: FittedBox(
                                        child: Text(
                                      value,
                                      style: const TextStyle(color: Colors.red),
                                    )),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     // fillColor: Colors.red,
                        //     border: OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15))),
                        //     labelText: "Password",
                        //     // prefix: Text("Name"),
                        //   ),
                        //   obscureText: true,
                        //   validator: (value) {
                        //     if (value == null ||
                        //         value.isEmpty ||
                        //         value.length < 8) {
                        //       return "Invalid Password";
                        //     } else {
                        //       password = value;
                        //     }
                        //   },
                        //   controller: passwordController,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (signupFormKey.currentState!.validate()) {
                              // await _authService.signUp(
                              //     email: email, password: password);

                              await _authService.sendData(name, email, phone,
                                  bloodgroup, password, district);
                              if (FirebaseAuth.instance.currentUser != null)
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
                            } else {
                              return null;
                            }

                            //   else valid = false;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
