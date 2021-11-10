import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/screen/dashboard/deliverable.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.fromLTRB(15, 65, 15, 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Deliverable Services",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Deliverable(),
        ],
      ),
    );
  }
}
