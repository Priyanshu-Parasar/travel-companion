import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapWithMarker extends StatefulWidget {
  MapWithMarker({super.key, required this.latitude , required this.longitude});

double latitude;
double longitude;

  @override
  _MapWithMarkerState createState() => _MapWithMarkerState();
}

class _MapWithMarkerState extends State<MapWithMarker> {
  late GoogleMapController _mapController;
  
  

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final LatLng _initialCameraPosition = LatLng(widget.latitude, widget.longitude); 
    //print("--------------------------------");
    //print("lat - ${widget.latitude} long - ${widget.longitude}");  

    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: [
          GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 11,
        ),
        markers: {
          Marker(
            markerId: MarkerId('m1'),
            position: _initialCameraPosition
          ),
        },
      ),
        //   Align(
        //     alignment: Alignment.centerRight,
        //     child: Padding(
        //       padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
        //       child: FloatingActionButton(
        //         onPressed: () {
        //           // Move map back to initial position
        //           _mapController.moveCamera(CameraUpdate.newLatLng(_initialCameraPosition));
        //         },
        //         child: Icon(Icons.center_focus_strong),
        //       ),
        //     ),
        //   ),
         ],
      ),
    );
  }

  // void _addMarker(LatLng position) {
  //   _mapController.addMarker(MarkerOptions(
  //     position: position,
  //     markerId: MarkerId('my_marker'),
  //     infoWindowText: InfoWindowText('Marker at: ${position.latitude}, ${position.longitude}'),
  //   ));
  // }
}
