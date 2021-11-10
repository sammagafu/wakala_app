import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wakala_search_app/screen/register_agent.dart';
import 'package:wakala_search_app/screen/register_client.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({Key? key}) : super(key: key);
  static final String id = "whoareyou";
  @override
  _WhoAreYouState createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
      child: Column(
        children: [
          SizedBox(height: 100),
          Text(
            "What are you ?",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  NeumorphicButton(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterUserClient.id);
                    },
                    style: NeumorphicStyle(
                      lightSource: LightSource.topLeft,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: kPrimaryColor,
                    ),
                    child: Icon(
                      Icons.person,
                      color: kContentDarkTheme,
                      size: 80,
                    ),
                  ),
                  Text(
                    "Client",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Column(
                children: [
                  NeumorphicButton(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterUserAgent.id);
                    },
                    style: NeumorphicStyle(
                      lightSource: LightSource.topLeft,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: kPrimaryColor,
                    ),
                    child: Icon(
                      Icons.business_center_outlined,
                      color: kContentDarkTheme,
                      size: 80,
                    ),
                  ),
                  Text(
                    "Agent",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 60),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: TextButton.styleFrom(primary: Colors.white70),
            child: Text(
              'Have an account? Login',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
