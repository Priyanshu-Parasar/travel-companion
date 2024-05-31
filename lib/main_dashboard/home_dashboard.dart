import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/views/category_view.dart';
import 'package:login/views/location_views.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/locations_model.dart';
import '../views/location_detail_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _MyAppState();
}

class _MyAppState extends State<Dashboard> {
  List<String> imgList = [
    "assets/images/the_great_himalayan _national_park.png",
    "assets/images/gurudongmar_lake.png",
    "assets/images/damdama.png"
  ];

  // Category value provide into this list
  final List _categories = [
    {"Icons": Icons.fireplace, "Text": "Popular"},
    {"Icons": Icons.forest, "Text": "Forest"},
    {"Icons": Icons.water, "Text": "Lakes"},
    {"Icons": Icons.hiking, "Text": "Hill Station"},
    {"Icons": Icons.beach_access, "Text": "Beach"}
  ];
  // {Icons.forest,"Forest"}, {Icons.water,"Lakes"}, {Icons.hiking,"Mountains"}];

  List<Locations> _data = [];

  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  //final DocumentSnapshot locsnapshot = FirebaseFirestore.instance.collection("tourist_locations").doc() ;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> loc =
        firebase.collection("tourist_locations").snapshots();

    //final Stream<QuerySnapshot> categorylist =
    //   firebase.collection("tourist_locations").snapshots();

    final Stream<QuerySnapshot> categoryValues = firebase
        .collection("tourist_locations")
        .where("rating", whereIn: [
          "4.0",
          //"4.1",
          "4.3",
          "4.4",
          "4.5",
          "4.6",
          "4.7",
          "4.8",
          "4.9",
          "5.0"
        ])
        .orderBy("rating")
        .limit(5)
        .snapshots();
    //print(loc);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 5,
          // ),
          // const SearchBar(
          //   hintText: "Search",
          //   textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 22)),
          //   hintStyle: MaterialStatePropertyAll(TextStyle(fontSize: 22)),
          //   backgroundColor:
          //       MaterialStatePropertyAll(Color.fromARGB(101, 193, 192, 192)),
          //   elevation: MaterialStatePropertyAll(0),
          //   shape: MaterialStatePropertyAll(
          //     RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(30)),
          //       side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          //     ),
          //   ),
          //   leading: Icon(size: 30, Icons.search),
          // ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Where should we go Today ?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          CarouselSlider(
            items: imgList.map(
              (img) {
                return Row(children: [
                  Container(
                    //padding: const EdgeInsets.symmetric(horizontal: 10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    width: 226,
                    //margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //decoration: BoxDecoration(color: Colors.white,),
                    child: Image.asset(img, fit: BoxFit.cover),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                ]);
              },
            ).toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              enableInfiniteScroll: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Categories",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map(
                (category) {
                  //print(_categories);
                  return Row(children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        category["Icons"] as IconData,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      label: Text(
                        category["Text"],
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ]);
                },
              ).toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 200,
              child: StreamBuilder<QuerySnapshot>(
                stream: categoryValues,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error Loading the Data");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading ... ");
                  }

                  var catData = snapshot.data;

                  //print(snapshot.data?.docs);
                  List<DocumentSnapshot> _snap = [];
                  _snap.addAll(
                      catData?.docs as Iterable<DocumentSnapshot<Object?>>);

                  _data = _snap.map((e) => Locations.fromFirestore(e)).toList();
                  //notifyListeners();

                  // print(_snap);
                  // print("--------------------------");
                  // print(_data);
                  //final data = snapshot.requireData;

                  // print(data);
                  // print(data.docs.length);
                  // print(data.docs);
                  //print(d);
                  //print(d[1]);

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _data.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        Locations location = _data[index];

                        //Locations location = Locations.fromFirestore(snapshot);

                        //print(location);
                        //print(locations);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationsDetailsPage(
                                          location: location,
                                        )));
                          },
                          child: CategoryListView(
                            locationList: location,
                          ),
                        );

                        // print(data.docs[index]);
                        // print(data.docs[index]["location_name"]);

                        //return Text("Under test");
                      });
                },
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Popular destinations you might like",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
                stream: loc,
                builder: (
                  BuildContext ctx,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text("Error Loading the Data");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading ... ");
                  }

                  //print(snapshot.data?.docs);
                  List<DocumentSnapshot> _snap = [];
                  _snap.addAll(snapshot.data?.docs
                      as Iterable<DocumentSnapshot<Object?>>);

                  _data = _snap.map((e) => Locations.fromFirestore(e)).toList();
                  //notifyListeners();

                  // print(_snap);
                  // print("--------------------------");
                  // print(_data);
                  //final data = snapshot.requireData;

                  // print(data);
                  // print(data.docs.length);
                  // print(data.docs);
                  //print(d);
                  //print(d[1]);

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _data.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        Locations location = _data[index];

                        //Locations location = Locations.fromFirestore(snapshot);

                        //print(location);
                        //print(locations);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationsDetailsPage(
                                          location: location,
                                        )));
                          },
                          child: LocationListView(
                            locationList: location,
                          ),
                        );

                        // print(data.docs[index]);
                        // print(data.docs[index]["location_name"]);

                        //return Text("Under test");
                      });
                }),
          )
          // Column(
          //   children: [
          //     Card(
          //       margin:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             height: 100,
          //             child:
          //                 Image.asset("assets/images/unsplash-eqzxve5bpuo.png"),
          //           ),
          //           const SizedBox(
          //             width: 80,
          //           ),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               Text("Location"),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text("Rating"),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Card(
          //       margin:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             height: 100,
          //             child:
          //                 Image.asset("assets/images/unsplash-qqwx49ov8uy.png"),
          //           ),
          //           const SizedBox(
          //             width: 80,
          //           ),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               Text("Location"),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text("Rating"),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Card(
          //       margin:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             height: 100,
          //             child:
          //                 Image.asset("assets/images/unsplash-rcgccbqdqk.png"),
          //           ),
          //           const SizedBox(
          //             width: 80,
          //           ),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               Text("Location"),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text("Rating"),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Card(
          //       margin:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             height: 100,
          //             child:
          //                 Image.asset("assets/images/unsplash-eqzxve5bpuo.png"),
          //           ),
          //           const SizedBox(
          //             width: 80,
          //           ),
          //           const Column(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               Text("Location"),
          //               SizedBox(
          //                 height: 20,
          //               ),
          //               Text("Rating"),
          //             ],
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
