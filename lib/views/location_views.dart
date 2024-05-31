import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login/model/locations_model.dart';

class LocationListView extends StatelessWidget {
  LocationListView({super.key, required this.locationList});

  Locations locationList;

  @override
  Widget build(BuildContext context) {
    Widget _dispImg = CachedNetworkImage(
      imageUrl: locationList.imageURL,
      fit: BoxFit.cover,
    );

    if (locationList.imageURL == null || locationList.imageURL == "") {
      _dispImg = CachedNetworkImage(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/login-43130.appspot.com/o/no_image_available.png?alt=media&token=8881d61a-bed3-4f68-904e-290c52cfe5f7",
      );
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: 130,
            height: 100,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            child: _dispImg ,
          ),
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: Text(locationList.location,textAlign: TextAlign.end),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: Text(locationList.rating),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
