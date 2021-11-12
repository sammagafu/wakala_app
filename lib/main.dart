import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wakala_search_app/screen/dashboard_agent.dart';
import 'package:wakala_search_app/screen/dashboard_user.dart';
import 'package:wakala_search_app/screen/landing.dart';
import 'package:wakala_search_app/screen/login.dart';
import 'package:wakala_search_app/screen/register_agent.dart';
import 'package:wakala_search_app/screen/register_client.dart';
import 'package:wakala_search_app/screen/tabs/deposit.dart';
import 'package:wakala_search_app/screen/tabs/withdraw.dart';
import 'package:wakala_search_app/screen/whoareyou.dart';
import 'package:wakala_search_app/theme/main_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: wakalaTheme(),
      home:
          FirebaseAuth.instance.currentUser == null ? LandingScreen() : Login(),
      routes: {
        Login.id: (context) => Login(),
        WhoAreYou.id: (context) => WhoAreYou(),
        RegisterUserAgent.id: (context) => RegisterUserAgent(),
        RegisterUserClient.id: (context) => RegisterUserClient(),
        Dashboard.id: (context) => Dashboard(),
        AgentDashboard.id: (context) => AgentDashboard(),
        Deposit.id: (context) => Deposit(),
        Withdraw.id: (context) => Withdraw(),
      },
    );
  }
}
