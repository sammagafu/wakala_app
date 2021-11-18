import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:wakala_search_app/screen/admin_tabs/transaction_on_move.dart';

import '../dashboard_agent.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  double _latitude = 0;
  double _longitude = 0;
  late var requestingUser;

  final Stream<QuerySnapshot> _transaction = FirebaseFirestore.instance
      .collection('transaction')
      .snapshots(includeMetadataChanges: true);

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

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _transaction,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var _transactionData = snapshot.data!.docs.first;

              var _requestingUser = _transactionData["user"];
              print(_requestingUser);
              return DraggableScrollableSheet(
                  initialChildSize: 0.45,
                  minChildSize: 0.13,
                  maxChildSize: 0.9,
                  builder:
                      (BuildContext buildContext, ScrollController controller) {
                    return Container(
                      color: kPrimaryColor,
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                        children: [
                          Text(
                            "Transaction information",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service provider"),
                              Text(_transactionData["carrier"]),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service"),
                              Text(_transactionData["service"]),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount to ${_transactionData["service"]}"),
                              Text(_transactionData["amount"]),
                            ],
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AgentDashboard.id);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: kErrorColor,
                                    padding: EdgeInsets.all(8)),
                                child: Row(
                                  children: [
                                    Text(
                                      "Decline",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                    Icon(
                                      Icons.cancel,
                                      color: kContentDarkTheme,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print(_transactionData.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionOnMove(
                                                  _transactionData.id)));
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(8),
                                    side: BorderSide(color: Colors.white)),
                                child: Row(
                                  children: [
                                    Text(
                                      "Accept ",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                    Icon(
                                      Icons.done,
                                      color: kContentDarkTheme,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
