import 'package:bloodbank/firebase/authentication.dart';
import 'package:bloodbank/pages/becomedonorpage.dart';
import 'package:bloodbank/pages/homepage.dart';
import 'package:bloodbank/pages/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(
 DevicePreview(
    enabled: !kReleaseMode,

    builder: (context) => MyApp(),

  ),
  );
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
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder:(context,_child)=> MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: "Blood Bank",
          
          home: GoApp(),
        ),
        
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
