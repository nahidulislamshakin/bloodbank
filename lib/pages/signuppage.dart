import 'package:bloodbank/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/authentication.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signupFormKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

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
  String bloodGroupDropDownValue = bloodGroupList.first;

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
                        TextFormField(
                          decoration: const InputDecoration(
                            // fillColor: Colors.red,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            labelText: "Password",
                            // prefix: Text("Name"),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return "Invalid Password";
                            }
                          },
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final isValid =
                                signupFormKey.currentState?.validate();

                            await _authService
                                .createAccountWithEmailAndPassword(
                                    email.toString().trim(),
                                    password.toString().trim());

                            if (_authService.user != null)
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            //   else valid = false;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text("Sign up"),
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
