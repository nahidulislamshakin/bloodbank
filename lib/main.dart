import 'package:bloodbank/firebase/authentication.dart';
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
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCOFTrF8gq9sThCRhIa35mm9RQ_Sd7Bgb0", 
      appId: "1:955654170426:android:9568ad4e8e6d8e375c1203", 
      messagingSenderId: "955654170426", 
      projectId: "blood-bank-4c29b"
      )  
  );
  await ScreenUtil.ensureScreenSize();
  //  await SystemChrome.setPreferredOrientations([
  //    DeviceOrientation.portraitUp,
  //  ]);
  runApp(
 DevicePreview(
    enabled: true,
    builder: (context) => 
    MyApp(),

  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (context) => Authentication(),
        ),
      ],
      child:
       ScreenUtilInit(
       designSize: Size(_deviceWidth, _deviceHeight),
       minTextAdapt: true,
       splitScreenMode: true,
        builder:(context,_child)=> 
        MaterialApp(
          theme: ThemeData( 
            brightness: Brightness.light,
            primaryColor: Colors.red,
            appBarTheme: AppBarTheme(
              
              backgroundColor: Colors.red,
              centerTitle: true,
              elevation: 8.0,
              titleTextStyle: TextStyle(fontSize: 17.sp),
              
            ),
            

          ),
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
