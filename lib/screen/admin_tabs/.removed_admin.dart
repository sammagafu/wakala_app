return Scaffold(
backgroundColor: kPrimaryColor,
body: Center(
child: FutureBuilder(
future: _mylocation,
builder: (BuildContext context, AsyncSnapshot snapshot) {
if (snapshot.hasData) {
myData = snapshot.data;
return StreamBuilder<QuerySnapshot>(
stream: _transactionStream,
builder: (BuildContext context,
AsyncSnapshot<QuerySnapshot> snapshot) {
if (snapshot.hasError) {
return Text('Something went wrong');
}
if (snapshot.connectionState ==
ConnectionState.waiting) {
return Text("Loading");
}
if (snapshot.hasData) {
_receivedData = snapshot.data!.docs;
if (snapshot.data!.docs.length < 1) {
return Center(
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text("Looking For clients"),
SizedBox(
height: 18,
),
LinearProgressIndicator()
],
),
);
} else {
// print(snapshot.data!.docs);
double distanceInMeters =
Geolocator.distanceBetween(
_receivedData
    .elementAt(0)['users_location']
    .latitude,
_receivedData
    .elementAt(0)['users_location']
    .longitude,
myData.latitude,
myData.longitude);
var _distanceInkm =
(distanceInMeters / 1000).round();
return Stack(
children: [
Expanded(
child: GoogleMap(
myLocationButtonEnabled: false,
zoomControlsEnabled: false,
mapType: MapType.normal,
initialCameraPosition: CameraPosition(
target: LatLng(_latitude, _longitude),
zoom: 18),
onMapCreated:
(GoogleMapController controller) {
_controller.complete(controller);
},
markers: {
Marker(
markerId:
const MarkerId('agentPosition'),
icon: BitmapDescriptor
    .defaultMarkerWithHue(
BitmapDescriptor.hueYellow),
position:
LatLng(_latitude, _longitude),
infoWindow:
InfoWindow(title: "my location")),
},
),
),
Expanded(
flex: 2,
child: DraggableScrollableSheet(
initialChildSize: 0.3,
minChildSize: 0.13,
maxChildSize: 0.9,
builder: (BuildContext context,
ScrollController scrollcontroller) {
return Container(
padding:
EdgeInsets.fromLTRB(30, 15, 30, 15),
color: kPrimaryColor,
child: Column(
children: [
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Text("Service Requested"),
Text(_receivedData
    .elementAt(0)['service'])
],
),
SizedBox(
height: 8,
),
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Text("Service Provider"),
Text(_receivedData
    .elementAt(0)['carrier'])
],
),
SizedBox(
height: 8,
),
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Text(
"Amount to be ${_receivedData.elementAt(0)['service']}"),
Text(_receivedData
    .elementAt(0)['amount'])
],
),
SizedBox(
height: 8,
),
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Text("Distance between"),
Text(
"${_distanceInkm.toString()} KM")
],
),
SizedBox(
height: 8,
),
Spacer(),
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
TextButton(
onPressed: () {
Navigator.pushNamed(context,
'/who-are-you');
},
style: TextButton.styleFrom(
backgroundColor:
kErrorColor,
padding:
EdgeInsets.all(8)),
child: Row(
children: [
Text(
"Decline",
style: Theme.of(context)
    .textTheme
    .headline5,
),
Padding(
padding: EdgeInsets
    .fromLTRB(
20, 0, 0, 0)),
Icon(
Icons.cancel,
color:
kContentDarkTheme,
size: 18,
)
],
),
),
OutlinedButton(
onPressed: () {},
style: TextButton.styleFrom(
padding:
EdgeInsets.all(8),
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
padding: EdgeInsets
    .fromLTRB(
20, 0, 0, 0)),
Icon(
Icons.done,
color:
kContentDarkTheme,
size: 18,
)
],
),
),
],
),
],
),
);
},
),
)
],
);
}
} else {
return Center(
child: Container(
padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
color: kPrimaryColor,
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Center(
child: Text(
"Looking For clients to withdraw or deposit")),
LinearProgressIndicator()
],
),
),
);
}
});
} else {
return CircularProgressIndicator();
}
}),
));





children: [
DraggableScrollableSheet(
initialChildSize: 0.3,
minChildSize: 0.13,
maxChildSize: 0.3,
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

    .collection("transaction")