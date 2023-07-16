import 'package:flutter/material.dart';

class OrganizationPage extends StatefulWidget {
  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Organization"),
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
