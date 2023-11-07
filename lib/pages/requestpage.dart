import 'package:flutter/material.dart';

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
  String address = "";
  String contactNumber = "";
  String patientDescription = "";

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                                "Upload your profile picture",
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                print(file?.path);
                                if (file == null) return;
                                String uniqueFileName = DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString();
                                Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                referenceRoot.child("images");
                                Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                                try {
                                  await referenceImageToUpload.putFile(
                                    File(file.path),
                                  );
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                } catch (e) {}
                              },
                              icon: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
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
                              const BorderRadius.all(Radius.circular(15)),
                              value: bloodGroupDropDownValue,
                              icon: const Icon(Icons.arrow_downward),

                              onChanged: (value) {
                                if (value == null || value == "Blood Group")
                                  return;
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
                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ?  CircularProgressIndicator() : ElevatedButton(
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
                          } else if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                  "Please wait for finishing the upload"),
                            ));
                            return;
                          }  if (signupFormKey.currentState!
                              .validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            // await _authService.signUp(
                            //     email: email, password: password);

                            await _authService.sendData(
                                name,
                                FirebaseAuth
                                    .instance.currentUser!.email!,
                                phone,
                                bloodgroup,
                                password,
                                district,
                                imageUrl,
                                FirebaseAuth.instance.currentUser!.uid);
                            if (FirebaseAuth.instance.currentUser !=
                                null)
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                          } else {
                            return null;
                          }
                          setState(() {
                            isLoading = false;
                          });
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
