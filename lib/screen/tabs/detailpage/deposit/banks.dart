import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/model/banks.dart';
import 'package:wakala_search_app/screen/success_transfer.dart';

class WithdrawBank extends StatefulWidget {
  final banks;
  const WithdrawBank(this.banks);

  @override
  _WithdrawBankState createState() => _WithdrawBankState();
}

class _WithdrawBankState extends State<WithdrawBank> {
  final _auth = FirebaseAuth.instance.currentUser;
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final banks = Banks;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: new Text("Deposit to ${widget.banks.name} Agent".toLowerCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 100, 15, 80),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.money,
                    color: kContentDarkTheme,
                  ),
                  labelText: "Enter amount",
                  labelStyle: TextStyle(color: kContentDarkTheme),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kContentDarkTheme,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kContentDarkTheme,
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Amount");
                  }
                  if (value.length > 6) {}
                },
              ),
              SizedBox(height: 24),
              Text("The maximum withdraw is TZS 200,000"),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Complete deposit"),
                  NeumorphicButton(
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.all(25),
                    onPressed: deposit,
                    style: NeumorphicStyle(
                      lightSource: LightSource.topLeft,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: kPrimaryColor,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: kContentDarkTheme,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deposit() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return _transaction
          .add({
            "amount": amountController.text,
            "carrier": widget.banks.name,
            "is_active": true,
            "is_completed": false,
            "request_time": Timestamp.now(),
            "service": "deposit",
            "user": _auth!.uid,
            "users_location": GeoPoint(position.latitude, position.longitude)
          })
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SuccessScreen(value.id))))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
