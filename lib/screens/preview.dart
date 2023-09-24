import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rover_alteif/screens/preview/live_measures.dart';
import 'package:rover_alteif/screens/preview/live_video.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool isloading = true;
  _launchURL() async {
    final Uri url = Uri.parse('http://192.168.137.147:5000/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch _url');
    }
  }

  // _launchURL() async{
  //   const url=' http://192.168.137.147:5000/ ';
  //    //const url = ('https://flutter.dev');
  //   if(await canLaunch(url))
  //   {
  //     await launch(url);
  //   }
  //   else{
  //     throw "Couldn't launch the url";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.darkBlue,
          title: Text("Preview Screen", style: TextStyle(fontSize: 20),),),
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: "https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png",
              placeholder: (context, url) =>
                  Image.asset(
                    'images/roverlogin.webp',
                    fit: BoxFit.fill,
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      onPressed: () {
                        // if (isloading == true) {
                        //   Center(child: Text(
                        //     'Fetching data',
                        //     style: TextStyle(fontWeight: FontWeight.bold,
                        //         fontSize: 20,
                        //         color: Colors.white),
                        //   ),);
                        // }
                        _launchURL();
                      },
                      color: Colors.greenAccent.shade400,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: BorderSide.none),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(

                              'Live Model',
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
                            Icons.live_tv,
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
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => LiveMeasures(),),);
                      },
                      color: Colors.greenAccent.shade400,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side: BorderSide.none),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(

                              'Live Measurements',
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
                            Icons.thermostat_auto,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),),
          ],
        )
    );
  }
}