import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorList extends StatefulWidget {
  final String bloodGroup;
  DonorList({required this.bloodGroup});

  @override
  State<DonorList> createState() => _DonorListState(bloodGroup: bloodGroup);
}

class _DonorListState extends State<DonorList> {
  //String district = "";
  final String bloodGroup;
  _DonorListState({required this.bloodGroup});

  List allResult = [];
  List searchResult = [];
  TextEditingController? districtController;

  @override
  void initState() {
    districtController = TextEditingController();

    districtController!.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    searchFromFirebase();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    districtController!.removeListener(_onSearchChanged);
    districtController!.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(districtController!.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (districtController!.text != null) {
      for (var userSnapShot in allResult) {
        var district = userSnapShot["District"].toString().toLowerCase();
        if (district.contains(districtController!.text.toLowerCase())) {
          showResults.add(userSnapShot);
        }
      }
    } else {
      showResults = List.from(allResult);
    }
    setState(() {
      searchResult = showResults;
    });
  }

  searchFromFirebase() async {
    final result = await FirebaseFirestore.instance
        .collection("User")
        .orderBy("Blood Group").get();
    setState(() {
      allResult = result.docs;
      //super.initState();
    });
    searchResultList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.back_hand,
              color: Colors.red,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: CupertinoSearchTextField(
            controller: districtController,
          ),

          // Card(
          //   child: TextField(
          //     onChanged: (district) {
          //       //  searchFromFirebase(district);
          //       // districtController!.clear();
          //       setState(() {
          //         district = district;
          //         searchFromFirebase(district);
          //       });
          //     },
          //     controller: districtController,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(),
          //       // labelText: "District Name",
          //       hintText: "District",
          //     ),
          //   ),
          // ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    // var data = snapshots.data!.docs[index].data()
                    //     as Map<String, dynamic>;
                    // if (district.isEmpty) {
                    return ListTile(
                      leading: Text(
                        searchResult[index]["Blood Group"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        searchResult[index]["Name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        searchResult[index]["District"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      trailing: Text(searchResult[index]["Phone"]),
                    );
                    //  }
                    // if (data["District"] == district) {
                    //   // searchFromFirebase(district);
                    //   return ListTile(
                    //     title: Text(
                    //       data[district],
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     subtitle: Text(
                    //       data["District"],
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     leading: CircleAvatar(
                    //         // backgroundImage: NetworkImage(data['image']),
                    //         ),
                    //   );
                    // }
                  })),
        ));
  }
}
