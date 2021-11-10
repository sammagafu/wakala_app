import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/screen/dashboard/withdraw/banks.dart';
import 'package:wakala_search_app/screen/dashboard/withdraw/mno.dart';

class Withdraw extends StatefulWidget {
  static String id = "withdraw";
  const Withdraw({Key? key}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
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
              "Withdraw",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Mno(),
          BanksWidget(),
        ],
      ),
    );
  }
}
