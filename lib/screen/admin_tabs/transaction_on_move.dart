import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakala_search_app/screen/admin_tabs/message.dart';

class TransactionOnMove extends StatefulWidget {
  static final String id = "transaction on move";
  final data;

  const TransactionOnMove(this.data);

  @override
  _TransactionOnMoveState createState() => _TransactionOnMoveState();
}

class _TransactionOnMoveState extends State<TransactionOnMove> {
  double _latitude = 0;
  double _longitude = 0;

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.6,
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_latitude, _longitude),
                        zoom: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 75, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launch("tel:+255788419991");
                        },
                        child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 25,
                          child: Icon(
                            Icons.phone,
                            color: kContentDarkTheme,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(widget.data);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Message(widget.data)));
                        },
                        child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 25,
                          child: Icon(
                            Icons.message,
                            color: kContentDarkTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            padding: EdgeInsets.fromLTRB(24, 16, 24, 16)),
                        onPressed: () {},
                        child: Text(
                          "Finish Transaction",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )),
                ),
              ],
            );
          } else {
            return Container(
              color: kPrimaryColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
