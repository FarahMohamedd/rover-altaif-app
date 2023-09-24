import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rover_alteif/Constants.dart';
import 'package:rover_alteif/screens/onboardingScreens.dart';
import 'package:rover_alteif/user_state.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome=prefs.getBool('showHome')??false;
 await Firebase.initializeApp();
  runApp( MyApp(showHome:showHome));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();
  final bool showHome;
    MyApp({
     Key? key,
    required this.showHome,
}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const

        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text(
                'App is loading..',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
            ),
          ),
        );
      }
      else if (snapshot.hasError) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text(
                'An error has been occured',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
          ),
        );
      }
      return MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Rover app',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEDE7DC),
          primarySwatch: Colors.blue,
        ),
       // home: UserState(),
        home: AnimatedSplashScreen(
            splash : "images/logoTT.png",
            splashIconSize: 90,
            duration: 900,
            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Constants.darkBlue,
            nextScreen:showHome? UserState():onboardingScreens()),
      );
        });
  }
}