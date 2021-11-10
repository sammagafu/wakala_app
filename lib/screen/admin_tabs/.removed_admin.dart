// child: Stack(
// children: [
// GoogleMap(
// myLocationButtonEnabled: false,
// zoomControlsEnabled: false,
// mapType: MapType.normal,
// initialCameraPosition: _googlePosition,
// onMapCreated: (GoogleMapController controller) {
// _controller.complete(controller);
// },
// markers: {
// Marker(
// markerId: const MarkerId('agentPosition'),
// icon: BitmapDescriptor.defaultMarkerWithHue(
// BitmapDescriptor.hueYellow),
// position: LatLng(_latitude, _longitude),
// infoWindow: InfoWindow(title: "my location")),
// },
// ),
// Align(
// alignment: Alignment.bottomCenter,
// child: StreamBuilder<QuerySnapshot>(
// stream: _database
//     .collection("transaction")
// .where("is_active", isEqualTo: true)
// .limit(1)
// .snapshots(),
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Center(
// child: Text("Looking for trips"),
// );
// }
// final messages = snapshot.data!.docs;
// return Container(
// padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
// color: kPrimaryColor,
// height: 180,
// child: Column(
// children: [
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text("Service"),
// Text(messages.elementAt(0)['service'])
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text("Provider"),
// Text(messages.elementAt(0)['carrier'])
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text("Amount"),
// Text(messages.elementAt(0)['amount'])
// ],
// ),
// Spacer(),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// TextButton(
// onPressed: () {
// Navigator.pushNamed(context, '/who-are-you');
// },
// style: TextButton.styleFrom(
// backgroundColor: kErrorColor,
// padding: EdgeInsets.all(8)),
// child: Row(
// children: [
// Text(
// "Decline",
// style:
// Theme.of(context).textTheme.headline5,
// ),
// Padding(
// padding:
// EdgeInsets.fromLTRB(20, 0, 0, 0)),
// Icon(
// Icons.cancel,
// color: kContentDarkTheme,
// size: 18,
// )
// ],
// ),
// ),
// OutlinedButton(
// onPressed: () {
// var _usergeolocation =
// messages.elementAt(0)['users_location'];
// setState(() {
// marker = Marker(
// markerId:
// const MarkerId('usersPosition'),
// icon: BitmapDescriptor
//     .defaultMarkerWithHue(
// BitmapDescriptor.hueGreen),
// infoWindow:
// InfoWindow(title: "Users Location"),
// position: LatLng(
// _usergeolocation.latitude,
// _usergeolocation.longitude));
// });
// },
// style: TextButton.styleFrom(
// padding: EdgeInsets.all(8),
// side: BorderSide(color: Colors.white)),
// child: Row(
// children: [
// Text(
// "Accept",
// style:
// Theme.of(context).textTheme.headline5,
// ),
// Padding(
// padding:
// EdgeInsets.fromLTRB(20, 0, 0, 0)),
// Icon(
// Icons.done,
// color: kContentDarkTheme,
// size: 18,
// )
// ],
// ),
// ),
// ],
// )
// ],
// ),
// );
// }),
// )
// ],
// ),
