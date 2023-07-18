import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Developer : Nahidul Islam Shakin",style: TextStyle(fontSize: 17),),
                    SelectableText("Contact : 01954841508",style: TextStyle(fontSize: 17),),
                    SelectableText("Email : shakinhabib2000@gmail.com",style: TextStyle(fontSize: 17),),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back to Homepage"))
                  ],
                ),
              ))),
    );
  }
}
