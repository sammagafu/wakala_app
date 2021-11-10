import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:wakala_search_app/constants/constant.dart';

class SuccessScreen extends StatefulWidget {
  final data;
  const SuccessScreen(this.data);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  PageController controller = PageController();
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, 49.085749655962),
    zoom: 11,
  );
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    print(_transaction.doc(widget.data));
    super.initState();
  }

  Future<void> getMyLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.6,
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return StreamBuilder(
                stream: _transaction.doc(widget.data).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  return Container(
                    color: kPrimaryColor,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              snapshot.data!["service"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Carrier",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              snapshot.data!["carrier"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              snapshot.data!["amount"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Cancel"))
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
