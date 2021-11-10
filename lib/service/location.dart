// import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class Location {
//   Completer<GoogleMapController> _controller = Completer();
//   double latitude 0;
//   double longitude 0;
//   // Location(this.latitude, this.longitude);
//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       latitude = position.latitude;
//       longitude = position.longitude;
//     } catch (e) {
//       print(e);
//     }
//   }
// }
//
// // final CameraPosition _kGooglePlex = await CameraPosition(
// // target: LatLng(this.latitude, this.longitude),
// // zoom: 18.4746,
// // );
