import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/authentication.dart';
import 'homepage.dart';

class RequestPage extends StatefulWidget {
  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  final requestFormKey = GlobalKey<FormState>();

  String patientName = "";
  String age = "";
  String gender = "";
  String bloodGroup = "";
  String date = "";
  String district = "";
  String contactNumber = "";
  String patientDescription = "";


  static const List<String> bloodGroupList = [
    "Blood Group",
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
    "Location",
    "Dhaka",
    "Faridpur",
    "Gazipur",
    "Gopalganj",
    "Jamalpur",
    "Kishoreganj",
    "Madaripur",
    "Manikganj",
    "Munshiganj",
    "Mymensingh",
    "Narayanganj",
    "Narsingdi",
    "Netrokona",
    "Rajbari",
    "Shariatpur",
    "Sherpur",
    "Tangail",
    "Bogra",
    "Joypurhat",
    "Naogaon",
    "Natore",
    "Nawabganj",
    "Pabna",
    "Rajshahi",
    "Sirajgonj",
    "Dinajpur",
    "Gaibandha",
    "Kurigram",
    "Lalmonirhat",
    "Nilphamari",
    "Panchagarh",
    "Rangpur",
    "Thakurgaon",
    "Barguna ",
    "Barisal",
    "Bhola",
    "Jhalokati",
    "Patuakhali",
    "Pirojpur",
    "Bandarban",
    "Brahmanbaria",
    "Chandpur",
    "Chittagong",
    "Comilla",
    "Cox''s Bazar",
    "Feni",
    "Khagrachari",
    "Lakshmipur",
    "Noakhali",
    "Rangamati",
    "Habiganj",
    "Maulvibazar",
    "Sunamganj",
    "Sylhet",
    "Bagerhat",
    "Chuadanga",
    "Jessore",
    "Jhenaidah",
    "Khulna",
    "Kushtia",
    "Magura",
    "Meherpur",
    "Narail",
    "Satkhira"
  ];


  String bloodGroupDropDownValue = bloodGroupList.first;
  String districtDropDownValue = districtList.first;

  TextEditingController? patientNameController;
  TextEditingController? ageController;
  TextEditingController? genderController;
  TextEditingController? bloodGroupController;
  TextEditingController? dateController;
  TextEditingController? addressController;
  TextEditingController? contactNumberController;
  TextEditingController? patientDescriptionController;

  @override
  void initState() {
    // TODO: implement initState
    patientNameController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    bloodGroupController = TextEditingController();
    dateController = TextEditingController();
    addressController = TextEditingController();
    contactNumberController = TextEditingController();
    patientDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    patientNameController!.dispose();
    ageController!.dispose();
    genderController!.dispose();
    bloodGroupController!.dispose();
    dateController!.dispose();
    addressController!.dispose();
    contactNumberController!.dispose();
    patientDescriptionController!.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Make Request for Blood"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: requestFormKey,
                  child: Column(
                    children: [


                      TextFormField(
                        decoration:  InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(15),
                          //     ),
                          //     borderSide: BorderSide(color: Colors.red)),
                          labelText: "Full Name",
                          // prefix: Text("Name"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Invalid Name";
                          } else {
                            patientName = value;
                          }
                        },
                        controller: patientNameController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),


                      TextFormField(
                        decoration:  InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                           labelText: "Age",
                          // prefix: Text("Name"),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Invalid Age";
                          } else {
                            age = value;
                          }
                        },
                        controller: ageController,
                        keyboardType: TextInputType.number,

                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        decoration:  InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),

                          // border: OutlineInputBorder(
                          //
                          //     borderRadius:
                          //     BorderRadius.all(Radius.circular(15))),
                          labelText: "Contact Number",
                          // prefix: Text("Name"),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Invalid Contact Number";
                          } else {
                            contactNumber = value;
                          }
                        },
                        controller: contactNumberController,
                        keyboardType: TextInputType.number,

                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(

                            border: Border.all(color: Colors.red),
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
                              const BorderRadius.all(Radius.circular(15)),
                              value: bloodGroupDropDownValue,
                              icon: const Icon(Icons.arrow_downward),

                              onChanged: (value) {
                                if (value == null || value == "Blood Group")
                                  return;
                                setState(() {
                                  bloodGroupDropDownValue = value!;
                                });
                                bloodGroup = value;
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
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
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
                              const BorderRadius.all(Radius.circular(15)),
                              value: districtDropDownValue,
                              icon: const Icon(Icons.arrow_downward),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.red,
                              // ),
                              onChanged: (value) {
                                if (value == null || value == "Location")
                                  return;
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

                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 3,
                        decoration: const InputDecoration(

                          contentPadding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 15.0),

                          border: OutlineInputBorder(

                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                        labelText: "Description",
                          // prefix: Text("Name"),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please give description with date";
                          } else {
                            patientDescription = value;
                          }
                        },
                        controller: patientDescriptionController,


                      ),
                      const SizedBox(
                        height: 8,
                      ),

                     ElevatedButton(
                        onPressed: () async {
                          if (bloodGroupDropDownValue == null ||
                              bloodGroupDropDownValue ==
                                  "Blood Group" ||
                              districtDropDownValue == null ||
                              districtDropDownValue == "Location") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                  "Please Select Blood Group and Location"),
                            ));
                            return;
                          }
                          else
                            {
                              await _authService.requestForBlood(patientNameController!.text, ageController!.text, contactNumberController!.text, bloodGroup, district,patientDescriptionController!.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            }


                          // await _authService.sendData(
                          //     patientName,
                          //     FirebaseAuth
                          //         .instance.currentUser!.email!,
                          //     contactNumber,
                          //     bloodGroup,
                          //
                          //     district, null, null, null, null
                          //
                          //    );


                          //   else valid = false;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Update"),
                      ),

                    ],
                  ),
                )
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}
