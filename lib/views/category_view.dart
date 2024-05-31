import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login/model/locations_model.dart';

class CategoryListView extends StatelessWidget {
  CategoryListView({super.key, required this.locationList});

  Locations locationList;

  @override
  Widget build(BuildContext context) {
    Widget _dispImg = CachedNetworkImage(fit: BoxFit.cover,
      imageUrl: locationList.imageURL,
    );

    if (locationList.imageURL == null || locationList.imageURL == "") {
      _dispImg = CachedNetworkImage(
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/login-43130.appspot.com/o/no_image_available.png?alt=media&token=8881d61a-bed3-4f68-904e-290c52cfe5f7",
      );
    }
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //padding: const EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: 200,
            height: 150,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            child: _dispImg,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [                
                Text(locationList.location),
                //const SizedBox(width: 80,),
                Text(locationList.rating),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
