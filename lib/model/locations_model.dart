import 'package:cloud_firestore/cloud_firestore.dart';

class Locations {
  String location;
  String imageURL;
  String rating;
  String city;
  String state;
  String category;
  String description;
  String latitude;
  String longitude;

  Locations({
    required this.location,
    required this.imageURL,
    required this.rating,
    required this.city,
    required this.state,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Locations.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data() as Map<String, dynamic>;

    // var temprating = d["rating"];

    // print(temprating as double);
    // print(d["rating"]);
    // print("-----------------");

    return Locations(
      location: d["location_name"] ?? "",
      imageURL: d["imageURL"] ?? "",
      rating: d["rating"] ?? 0.0,
      city: d["city"] ?? "",
      state: d["state"] ?? "",
      category: d["category"] ?? "",
      description: d["description"] ?? "",
      latitude: d["latitude"] ?? "",
      longitude: d["longitude"] ?? "",
    );
  }
}

// List<Locations> locations = [
//   Locations(
//       location: "location",
//       imageURL: "assets/images/unsplash-eqzxve5bpuo.png",
//       rating: "rating",
//       city: "city",
//       state: "state",
//       category: "category",
//       description: "description"),
//   Locations(
//       location: "location",
//       imageURL: "assets/images/unsplash-rcgccbqdqk.png",
//       rating: "rating",
//       city: "city",
//       state: "state",
//       category: "category",
//       description: "description"),
//   Locations(
//       location: "location",
//       imageURL: "assets/images/unsplash-qqwx49ov8uy.png",
//       rating: "rating",
//       city: "city",
//       state: "state",
//       category: "category",
//       description: "description"),
//   Locations(
//       location: "location",
//       imageURL: "assets/images/unsplash-eqzxve5bpuo.png",
//       rating: "rating",
//       city: "city",
//       state: "state",
//       category: "category",
//       description: "description"),
//   Locations(
//       location: "location",
//       imageURL: "assets/images/unsplash-rcgccbqdqk.png",
//       rating: "rating",
//       city: "city",
//       state: "state",
//       category: "category",
//       description: "description"),
// ];
