import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart'; //////////////farah
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:rover_alteif/screens/preview/live_measures.dart';
import 'package:rover_alteif/widgets/drawer_widget.dart';

import '../../Constants.dart';
import '../../inner_screens/profile.dart';
import '../../inner_screens/saved_maps.dart';
import '../preview.dart';
import '../report.dart';
class Start extends StatefulWidget {
  bool start=true ;
  Start({required this.start}) ;
  @override
  State<Start> createState() => _StartState();
}
class _StartState extends State<Start> with AutomaticKeepAliveClientMixin {
  late final FirebaseApp app;
  // bool start=true;
  bool report=false;
  late DatabaseReference dbRef;
  /////////////////////
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;
  late String uid = user!.uid;
  bool cur=true;
  int currentIndex=0;
  void onTap(int index){
    setState(() {
      currentIndex=index;
    });
  }

  late List pages=[
    Start(start: true),
    SavedMapScreen(),
    ProfileScreen(userID: uid),
  ];
  /////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.start=true;
    dbRef=FirebaseDatabase.instance.ref().child('Move');
  }
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkBlue,
          title: Text("   Main Screen",style: TextStyle(fontSize: 20),),),
      // bottomNavigationBar: Container(
      //   color: Color(0xFF06050d),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
      //     child: GNav(
      //       tabs: const[
      //         GButton(icon: Icons.home,
      //           text: 'Home',
      //         ),
      //         GButton(icon: Icons.save_alt,
      //           text: 'All Maps',
      //         ),
      //         GButton(icon: Icons.person,
      //           text: 'My Profile',
      //         ),
      //       ],
      //       onTabChange:(index)=>setState(() {
      //         cur=false;
      //         currentIndex=index;
      //         // if(currentIndex==0){
      //         //   cur=true;
      //         //   currentIndex=index;
      //         // }
      //         // else {
      //         //   currentIndex = index;
      //         //   cur=false;
      //         // }
      //       }),
      //       backgroundColor: Color(0xFF06050d),
      //       color: Colors.white,
      //       activeColor: Colors.white,
      //       tabBackgroundColor: Constants.darkBlue,//0xFF131029
      //       gap: 8,
      //       padding: EdgeInsets.all(16),
      //     ),
      //   ),
      // ),

        // drawer:DrawerWidget(),
        body:
        //cur?
        // Stack(
        //   children:[
        //     CachedNetworkImage(
        //       imageUrl: "https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png",
        //       placeholder: (context, url) => Image.asset(
        //         'images/roverlogin.webp',
        //         fit: BoxFit.fill,
        //       ),
        //       errorWidget: (context, url, error) => const Icon(Icons.error),
        //       fit: BoxFit.cover,
        //       width: double.infinity,
        //       height: double.infinity,
        //     ),
        //
        //     Center(
        //
        //     child:Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(15.0),
        //           child: MaterialButton(
        //             onPressed:(){
        //               if(widget.start==true) {
        //                 FirebaseFirestore.instance.collection("Mission").doc("MissionState").set({"State" : 1});
        //                  dbRef.set({'move':1});
        //
        //                 setState(() {
        //                   widget.start=false;
        //                   report=false;
        //                 });
        //               }
        //               else{
        //                 FirebaseFirestore.instance.collection("Mission").doc("MissionState").set({"State" : 0});
        //                   dbRef.set({'move':0});
        //                 setState(() {
        //                   widget.start=true;
        //                   report=true;
        //                 });
        //               }
        //
        //             },
        //             color: widget.start? Colors.greenAccent.shade400:Colors.red.shade600,
        //             elevation: 10,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(13),
        //                 side: BorderSide.none),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Padding(
        //                   padding: EdgeInsets.symmetric(vertical: 14),
        //                   child:  Text(
        //                     widget.start?
        //                     'Start Rover':'Stop and return rover',
        //                     style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 20,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 10,
        //                 ),
        //                 Icon(
        //                   widget.start?
        //                   Icons.start:Icons.stop_circle,
        //                   color: Colors.white,
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               widget.start? Text(" "):
        //               TextButton(onPressed: () {
        //                 Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) =>PreviewScreen(),),); //////////error
        //                 },
        //                 child:Text("Preview",style: TextStyle(fontSize: 18,color:Colors.white),),
        //               ),
        //               report?TextButton(onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) =>  ReportScreen(),
        //                   ),
        //                 );
        //               }, child: Text("Report",style: TextStyle(fontSize: 18,color:Colors.white),),
        //               ):Text(" "),
        //             ],
        //           ),
        //         )
        //       ],
        //     ) ,),],
        // ):pages[currentIndex],
        /////////////////////////////////////////////////////////////////////////////// new start

        Stack(
          children:[
            CachedNetworkImage(
              // imageUrl: "https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png",
              imageUrl: 'https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png',
              placeholder: (context, url) => Image.asset(
                'images/roverlogin.webp',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      onPressed:(){

                        FirebaseFirestore.instance.collection("Mission").doc("MissionState").set({"State" : 1});
                        dbRef.set({'move':1});

                      },
                      color:Colors.greenAccent.shade400,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: BorderSide.none),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child:  Text(
                              'Start Rover',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.start,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      onPressed:(){
                        FirebaseFirestore.instance.collection("Mission").doc("MissionState").set({"State" : 0});
                        dbRef.set({'move':0});
                      },
                      color:Colors.red.shade600,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: BorderSide.none),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child:  Text(

                              'Stop Rover',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.stop_circle,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>PreviewScreen(),),); //////////error
                        },
                          child:Text("Preview",style: TextStyle(fontSize: 18,color:Colors.white),),
                        ),
                        TextButton(onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ReportScreen(),
                            ),
                          );
                        }, child: Text("Report",style: TextStyle(fontSize: 18,color:Colors.white),),
                        )
                      ],
                    ),
                  )
                ],

              ) ,),],
        )

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
