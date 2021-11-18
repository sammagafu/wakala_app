import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'dart:async';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  double _latitude = 0;
  double _longitude = 0;
  bool isdismissable = false;
  late var myData;
  late var _distanceInkm;
  late Future<Position> _mylocation;
  late var _receivedData;
  late var _tripid;
  final _transaction = FirebaseFirestore.instance.collection("transaction");

  final Stream<QuerySnapshot> _trips = FirebaseFirestore.instance
      .collection('trips')
      .where("is_declined", isEqualTo: false)
      .limit(1)
      .snapshots();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var _mylocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = _mylocation.latitude;
      _longitude = _mylocation.longitude;
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Completer<GoogleMapController> _controller = Completer();
  final _auth = FirebaseAuth.instance.currentUser;
  final _database = FirebaseFirestore.instance;
  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');

  @override
  void initState() {
    _mylocation = _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: transaction.where("is_active", isEqualTo: true).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: LinearProgressIndicator(),
                );
              } else {
                return Text("working");
              }
            },
          )
        ],
      ),
    );
  }
}


Column(
children: [

],
);