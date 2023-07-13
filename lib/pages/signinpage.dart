import 'package:bloodbank/firebase/authentication.dart';
import 'package:bloodbank/pages/homepage.dart';
import 'package:bloodbank/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
      appBar: AppBar(
        title: const Text("Blood Bank"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        //  hoverColor: Colors.red,
                        hintText: "E-mail",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Email";
                        } else {
                          email = value;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hoverColor: Colors.red,
                        hintText: "Password",
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Password";
                        } else {
                          password = value;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )

                            // foregroundColor: Colors.black,
                            ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await _authentication.login(
                                email: email, password: password);
                            if (FirebaseAuth.instance.currentUser != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          }
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
