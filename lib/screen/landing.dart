import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wakala_search_app/constants/constant.dart';
import 'package:wakala_search_app/screen/login.dart';
import 'package:wakala_search_app/screen/whoareyou.dart';

class LandingScreen extends StatelessWidget {
  final String logo = 'assets/images/logo.svg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/images/onboarding.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 100,
          child: SvgPicture.asset(
            logo,
            height: 100.0,
            color: kContentDarkTheme,
          ),
        ),
        Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Connects you to the nearby mobile agent",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WhoAreYou.id);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          padding: EdgeInsets.all(20)),
                      child: Row(
                        children: [
                          Text(
                            "Creeate an account",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: kContentDarkTheme,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Login.id);
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          side: BorderSide(color: Colors.white)),
                      child: Row(
                        children: [
                          Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: kContentDarkTheme,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "This app does not do any transaction",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
