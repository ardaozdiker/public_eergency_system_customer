import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:public_eergency_system_customer/user%20screen%20contents/reportstatusPage.dart';

class getLocationScreen extends StatefulWidget {
  const getLocationScreen({Key? key}) : super(key: key);

  @override
  State<getLocationScreen> createState() => _getLocationScreenState();
}

class _getLocationScreenState extends State<getLocationScreen> {

  

GoogleMapController? _ccontroller;
  double lat= 0;
  double long=0;
  Location currentLocation = Location();
  Set<Marker> _markers={};

/*   Completer<GoogleMapController> _controller = Completer(); */
  static final CameraPosition camerapos =
      CameraPosition(target: LatLng(35.134168, 33.9225247), zoom: 15);

  static final Marker _googlemarker = Marker(
      markerId: MarkerId("Location"),
      infoWindow: InfoWindow(title: "Your Location"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(45.1341684, 35.9225247));
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text("Where Is Location?"),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: _markers,

      onTap:  (pos) {

        print(pos);
        Marker f =

        Marker(markerId: MarkerId('1'),icon: BitmapDescriptor.defaultMarker, position: LatLng(pos.latitude,pos.longitude //konum pos la alınır kontrol ed
        ));

        setState(() {

          _markers.add(f);
        lat=pos.latitude;
        long=pos.longitude;
        });

              },
        initialCameraPosition: camerapos, //Starting point of map
         onMapCreated: (GoogleMapController controller) {
          _ccontroller= controller;
        } ,
      ),
       floatingActionButton: FloatingActionButton.extended(
        onPressed:() {GetLoc(lat,long);
         Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StatusPage()));
        }
        ,
        
          // moves to Current Location(Cihazın konumunu verir)
        icon: Icon(Icons.description),
        label: Text("Report!"),

        backgroundColor: Colors.orange[800],
      ), 
      
    );
  }
 GetLoc(double lat, double long){

   print(lat);
   print(long);

   print("location got successfully");
  
  

}
  
}
