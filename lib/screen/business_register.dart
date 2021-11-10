import 'package:flutter/material.dart';
import 'package:wakala_search_app/constants/constant.dart';

class Signup extends StatelessWidget {
  // const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kPrimaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter your information",
                style: TextStyle(
                    color: kContentDarkTheme, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your First Name",
                    labelText: "First nane",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Last Name",
                    labelText: "Last nane",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your e-mail",
                    labelText: "E-mail",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    labelText: "Phone",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kContentDarkTheme, width: 2.0),
                    ),
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(color: kContentDarkTheme),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(primary: Colors.white70),
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: kContentDarkTheme),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
