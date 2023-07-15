import 'package:bloodbank/pages/becomedonorpage.dart';
import 'package:bloodbank/pages/donarlistpage.dart';
import 'package:flutter/material.dart';

const List<String> districtList = [
  "Gopalganj",
  "Dhaka",
  "Khulna",
  "Barisal",
  "Rangpur",
  "Chittagong",
  "Gazipur",
  "Sylhet"
];

class DistrictPage extends StatefulWidget {
  @override
  State<DistrictPage> createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          shrinkWrap: true,
            itemCount: districtList.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonorList()));
                },
                child: ListTile(
                  leading: Icon(Icons.list),
                  title: Text(districtList[index]),
                ),
              );
            }));
  }
}
