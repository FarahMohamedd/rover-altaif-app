import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rover_alteif/screens/preview/live_measures.dart';
import 'package:rover_alteif/screens/preview/live_video.dart';
import 'package:rover_alteif/screens/report/all_measures.dart';
import 'package:rover_alteif/screens/report/map.dart';

import '../Constants.dart';
class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkBlue,
          title: Text("Report Screen",style: TextStyle(fontSize: 20),),),
        body: Stack(
          children:[
            CachedNetworkImage(
              imageUrl: "https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png",
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
                        // StreamBuilder(
                        //   //stream:AuthService().firebaseAuth ,
                        //   builder: (context,AsyncSnapshot snapshot)
                        //   {
                        //     if(snapshot.hasData) {
                        //       return MapScreen();
                        //     }
                        //     return AllMeasures();
                        //   },
                        // );
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>MapScreen(),),);
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

                              'Map',
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
                            Icons.map,
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
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>AllMeasures(),),);
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

                              'Report',
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
                            Icons.report,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ) ,),],
        )
    );
  }
}
