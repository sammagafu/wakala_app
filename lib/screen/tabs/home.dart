import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wakala_search_app/screen/tabs/deposit.dart';
import 'package:wakala_search_app/screen/tabs/withdraw.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance.currentUser;
  final _database = FirebaseFirestore.instance;
  var _currentUserProfile = '';
  var _currentDeposit = '';
  var _currentWithdraw = '';
  late Future<String?> userToken;

  Future<void> getUserProfile() async {
    var userprofie = await _database
        .collection("user_profile")
        .where("uiid", isEqualTo: _auth?.uid)
        .get();
    setState(() {
      _currentUserProfile = userprofie.docs.first.get("fullname");
    });
  }

  Future<void> getLastDeposit() async {
    await _database
        .collection("transaction")
        .where("service", isEqualTo: "deposit")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _currentDeposit = querySnapshot.docs.first.get("amount");
        print(_currentDeposit);
      });
    });
  }

  Future<void> getLastWithdraw() async {
    await _database
        .collection("transaction")
        .where("service", isEqualTo: "withdraw")
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _currentWithdraw = querySnapshot.docs.first.get("amount");
        print(_currentWithdraw);
      });
    });
  }

  @override
  void initState() {
    getUserProfile();
    getLastDeposit();
    getLastWithdraw();
    print(_currentWithdraw);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 65, 15, 30),
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Welcome",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "$_currentUserProfile",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(height: 65),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pushNamed(context, Deposit.id);
          //       },
          //       style: TextButton.styleFrom(
          //           backgroundColor: kContentColorLightTheme,
          //           padding: EdgeInsets.all(18)),
          //       child: Row(
          //         children: [
          //           Text(
          //             "Deposit",
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //         ],
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pushNamed(context, Deposit.id);
          //       },
          //       style: TextButton.styleFrom(
          //           backgroundColor: kSecondaryColor,
          //           padding: EdgeInsets.all(20)),
          //       child: Row(
          //         children: [
          //           Text(
          //             "Deposit",
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //         ],
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pushNamed(context, Withdraw.id);
          //       },
          //       style: TextButton.styleFrom(
          //           backgroundColor: kContentColorLightTheme,
          //           padding: EdgeInsets.all(20)),
          //       child: Row(
          //         children: [
          //           Text(
          //             "Withdraw",
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                borderRadius: BorderRadius.circular(10),
                color: kContentColorLightTheme,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "Last withdraw",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text("$_currentWithdraw",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: kSecondaryColor,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "Last Deposit",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: kContentColorLightTheme),
                      ),
                      Text(
                        "$_currentDeposit",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 65),
          Text("My last activities"),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("transaction")
                  .where("user", isEqualTo: _auth?.uid)
                  .limit(8)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final messages = snapshot.data!.docs;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(messages.elementAt(index)['service']),
                                Text(messages.elementAt(index)['carrier']),
                                Text(messages.elementAt(index)['amount']),
                              ],
                            ),
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
