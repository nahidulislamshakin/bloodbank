// ignore_for_file: use_build_context_synchronously

import 'package:bloodbank/firebase/authentication.dart';
import 'package:bloodbank/pages/homepage.dart';
import 'package:bloodbank/pages/becomedonorpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";
  String name = "";
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final formKey = GlobalKey<FormState>();

  // Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authentication = Provider.of<Authentication>(context);
    return Scaffold(
      //backgroundColor: Colors.blue,
      body:  FlutterLogin(

              onLogin: (loginData) async {
                await _authentication.login(
                    email: loginData.name, password: loginData.password);
                if (FirebaseAuth.instance.currentUser != null) {
                  return Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                } else {
                  print("Current user is null");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Invalid email or password"),
                  ));
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                }
              },

              onRecoverPassword: (email) async {
                return await _authentication.forgotPassword(email);
              },

              onSignup: (signupData) async {
                if (signupData.name == null ||
                    signupData.password == null ||
                    signupData.password!.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Please input email and password correctly"),
                  ));
                  return "Please input email and password";
                } else if (await checkIfEmailInUse(signupData.name!) == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Email is already used"),
                  ));
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                }
                await _authentication.signUp(
                    email: signupData.name!, password: signupData.password!);
                if (FirebaseAuth.instance.currentUser != null) {
                  return Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BecomeDonorPage()),
                      (route) => false);
                }
              },
              userType: LoginUserType.email,
              footer: "Developer : Nahidul Islam Shakin",
              navigateBackAfterRecovery: true,
              passwordValidator: (value) {
                if (value!.length < 8) {
                  return "Password's leangth should be 8 or greater";
                }
              },
              title: "Blood Bank",
              
              loginAfterSignUp: true,
              scrollable: true,
              
              // logo: Image.asset("image/applogo.jpg"),
              //titleTag: "Signup",
              // additionalSignupFields: [

              // ],
              // children: [
              //   TextFormField(
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(15),
              //           ),
              //           borderSide: BorderSide(color: Colors.red)),
              //       labelText: "Full Name",
              //       // prefix: Text("Name"),
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return "Invalid Name";
              //       } else {
              //         name = value;
              //       }
              //     },
              //     controller: nameController,
              //   ),
              // ],
            ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Blood Bank"),
    //     centerTitle: true,
    //     backgroundColor: Colors.red,
    //   ),
    //   body: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(15),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Form(
    //             key: formKey,
    //             child: Column(
    //               children: [
    //                 TextFormField(
    //                   controller: emailController,
    //                   decoration: const InputDecoration(
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(20),
    //                       ),
    //                     ),
    //                     //  hoverColor: Colors.red,
    //                     hintText: "E-mail",
    //                   ),
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Invalid Email";
    //                     } else {
    //                       email = value;
    //                     }
    //                   },
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 TextFormField(
    //                   controller: passwordController,
    //                   decoration: const InputDecoration(
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(20),
    //                       ),
    //                     ),
    //                     hoverColor: Colors.red,
    //                     hintText: "Password",
    //                   ),
    //                   obscureText: true,
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return "Invalid Password";
    //                     } else {
    //                       password = value;
    //                     }
    //                   },
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 Container(
    //                   width: double.infinity,
    //                   child: ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         backgroundColor: Colors.red,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                         )

    //                         // foregroundColor: Colors.black,
    //                         ),
    //                     onPressed: () async {
    //                       if (formKey.currentState!.validate()) {
    //                         await _authentication.login(
    //                             email: email, password: password);
    //                         if (FirebaseAuth.instance.currentUser != null) {
    //                           Navigator.pushReplacement(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) => HomePage()));
    //                         }
    //                       }
    //                     },
    //                     child: const Text(
    //                       "Sign in",
    //                       style: TextStyle(fontSize: 17),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text("Don't have an account?"),
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).push(
    //                     MaterialPageRoute(
    //                       builder: (context) => SignUpPage(),
    //                     ),
    //                   );
    //                 },
    //                 child: Text(
    //                   "Sign up",
    //                   style: TextStyle(color: Colors.redAccent),
    //                 ),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
