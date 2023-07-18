import 'package:bloodbank/firebase/authentication.dart';
import 'package:bloodbank/pages/becomedonorpage.dart';
import 'package:bloodbank/pages/homepage.dart';
import 'package:bloodbank/pages/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (context) => Authentication(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Blood Bank",
        
        home: GoApp(),
      ),
    );
  }
}

 class GoApp extends StatelessWidget {
   const GoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!=null?HomePage():SignInPage();
  }
}
