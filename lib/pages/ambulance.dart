import 'package:flutter/material.dart';

class AmbulancePage extends StatefulWidget {
  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ambulance"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              
            ),
          ),
        ),
      ),
    );
  }
}
