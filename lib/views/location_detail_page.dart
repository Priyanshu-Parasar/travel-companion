import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:login/booking/booking.dart';
import 'package:login/model/locations_model.dart';
//import '../map/map.dart';
import '../map/map_page.dart';
//import 'review.dart';

class LocationsDetailsPage extends StatelessWidget {
  LocationsDetailsPage({super.key, required this.location});

  Locations location;

  @override
  Widget build(BuildContext context) {
    //print(location.category);

    Widget _dispImg = CachedNetworkImage(
      imageUrl: location.imageURL,
      fit: BoxFit.cover,
    );

    if (location.imageURL == null || location.imageURL == "") {
      _dispImg = CachedNetworkImage(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/login-43130.appspot.com/o/no_image_available.png?alt=media&token=8881d61a-bed3-4f68-904e-290c52cfe5f7",
      );
    }

    //print("--------------------------------");
    //print("lat - ${location.latitude} long - ${location.longitude}");

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: _dispImg,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(999, 45),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapWithMarker(latitude: double.parse(location.latitude),longitude: double.parse(location.longitude)),
                          ),
                        );
                      },
                      child: const Text("Open in Map"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Text(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              location.location.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            location.rating,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "City :- ${location.city}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "State :- ${location.state}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Category :- ${location.category}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Approx. Budget :- Rs. 20000",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Description :- ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      location.description,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // OutlinedButton(
                    //   style: OutlinedButton.styleFrom(
                    //     minimumSize: const Size(999, 45),
                    //     shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(30)),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //       builder: (context) => const ReviewPage(),
                    //     //     ));
                    //   }, // navigate to review page
                    //   child: const Text("Open Reviews"),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(999, 45),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(locName: location.city),
                            ));
                      }, // navigate to review page
                      child: const Text("Book a Trip"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
