import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/model/deliverable.dart';

class Deliverable extends StatefulWidget {
  const Deliverable({Key? key}) : super(key: key);

  @override
  _DeliverableState createState() => _DeliverableState();
}

class _DeliverableState extends State<Deliverable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 21),
        Material(
          // borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor,
          elevation: 2,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            height: 180,
            child: ListView.builder(
              // padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: delivery.length,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundColor: kContentDarkTheme,
                      radius: 40,
                      backgroundImage: AssetImage(delivery[index].url),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      delivery[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
