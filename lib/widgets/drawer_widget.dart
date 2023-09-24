import 'package:firebase_auth/firebase_auth.dart'; //////////////farah
import 'package:flutter/material.dart';
import 'package:rover_alteif/inner_screens/saved_maps.dart';
import 'package:rover_alteif/inner_screens/saved_measures.dart';
import 'package:rover_alteif/screens/mainScreen/start.dart';
import '../Constants.dart';
import '../inner_screens/profile.dart';
import '../user_state.dart';

class DrawerWidget extends StatelessWidget {
  //bool start=true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color:  Constants.darkBlue),
                child: Column(
                  children: [
                    Flexible(
                        child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/947/947680.png')),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: Text(
                          'Alteif Rover',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                        ))
                  ],
                )),
            SizedBox(
              height: 30,
            ),


            _listTiles(
                label: 'My Profile',
                fct: () {
                  _navigateToProfileScreen(context);
                },
                icon: Icons.account_box_rounded),

            _listTiles(
                label: 'Main screen',
                fct: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Start(start: true),),);
                },
                icon: Icons.start),

            _listTiles(
                label: 'All maps',
                fct: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>SavedMapScreen(),),);
                },
                icon: Icons.map),

            // _listTiles(
            //     label: 'Saved reports',
            //     fct: () {
            //       Navigator.push(context,
            //         MaterialPageRoute(builder: (context) =>SavedReports(),),);
            //     },
            //     icon: Icons.report),


            Divider(
              thickness: 1,
            ),
            _listTiles(
                label: 'Logout',
                fct: () {
                  _logout(context);
                },
                icon: Icons.logout_outlined),
          ],
        ));
  }



  void _navigateToProfileScreen(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userID: uid,
        ),
      ),
    );
  }



  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3889/3889524.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Log Out'),
                ),
              ],
            ),
            content: Text(
              'Do you want to Log out ?',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => UserState(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(
        icon,
        color: Constants.darkBlue,
      ),
      title: Text(
        label,
        style: TextStyle(
            color: Constants.darkBlue,
            fontSize: 20,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}