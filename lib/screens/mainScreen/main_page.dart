import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rover_alteif/inner_screens/profile.dart';
import 'package:rover_alteif/inner_screens/saved_maps.dart';
import 'package:rover_alteif/screens/mainScreen/start.dart';
import 'package:rover_alteif/screens/preview/live_measures.dart';
import 'package:rover_alteif/screens/preview/live_video.dart';

import '../../Constants.dart';
import '../../widgets/drawer_widget.dart';
class Main_Page extends StatefulWidget {
  const Main_Page({Key? key}) : super(key: key);
  @override
  State<Main_Page> createState() => _Main_PageState();
}
class _Main_PageState extends State<Main_Page> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;
  late String uid = user!.uid;
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  late List pages = [
    Start(start: true),
    SavedMapScreen(),
    ProfileScreen(userID: uid),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: Color(0xFF06050d),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            tabs: const[
              GButton(icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.save_alt,
                text: 'All Maps',
              ),
              GButton(icon: Icons.person,
                text: 'My Profile',
              ),
            ],
            onTabChange: (index) =>
                setState(() {
                  currentIndex = index;
                }),
            backgroundColor: Color(0xFF06050d),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Constants.darkBlue,
            //0xFF131029
            gap: 8,
            padding: EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}