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
  late var myData;
  late var _distanceInkm;
  late Future<Position> _mylocation;
  late var _receivedData;
  late var _tripid;

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

  Future<void> declineTrip(documentId) {
    return trips
        .doc(documentId.toString())
        .update({'is_declined': true})
        .then((value) => print("Trip Updated"))
        .catchError((error) => print("Failed to update: $error"));
  }

  @override
  void initState() {
    _mylocation = _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _trips,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Looking For a client"),
                  LinearProgressIndicator()
                ],
              ),
            );
          } else {
            _receivedData = snapshot.data!.docs.first.get("transaction");
            _tripid = snapshot.data!.docs.first.id;
            //TODO make queryset  from document

            return Stack(
              children: [
                DraggableScrollableSheet(
                    initialChildSize: 0.3,
                    minChildSize: 0.13,
                    maxChildSize: 0.9,
                    builder: (BuildContext context,
                        ScrollController scrollcontroller) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                        color: kPrimaryColor,
                        child: Column(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('transaction')
                                  // .orderBy("request_time", descending: true)
                                  .doc(_receivedData.toString())
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                return Column(
                                  children: [
                                    Text("Transaction Details"),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Service Provider"),
                                        Text(snapshot.data!.get("carrier")),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Service"),
                                        Text(snapshot.data!.get("service")),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Amout to ${snapshot.data!.get("service")}"),
                                        Text(snapshot.data!.get("amount")),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            print(_tripid);
                                            declineTrip(_tripid);
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: kErrorColor,
                                              padding: EdgeInsets.all(8)),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Decline",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0)),
                                              Icon(
                                                Icons.cancel,
                                                color: kContentDarkTheme,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(8),
                                              side: BorderSide(
                                                  color: Colors.white)),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Accept",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0)),
                                              Icon(
                                                Icons.done,
                                                color: kContentDarkTheme,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            );
          }
        },
      ),
    );
  }
}
