import 'package:firebase_auth/firebase_auth.dart'; /////////////farah
import 'package:flutter/material.dart';
import 'package:rover_alteif/screens/auth/login.dart';
import 'package:rover_alteif/screens/mainScreen/main_page.dart';
import 'package:rover_alteif/screens/mainScreen/start.dart';

class UserState extends StatelessWidget {
  // bool start=true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            print('User didn\'t login yet');
            return const LoginScreen();
          } else if (userSnapshot.hasData) {
            print('User is logged in');
            //return Start(start: true,);
            return Main_Page();
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text(
                'An error has been occured',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
          );
        });
  }
}