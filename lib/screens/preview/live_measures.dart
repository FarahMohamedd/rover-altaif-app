import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rover_alteif/screens/mainScreen/main_page.dart';
import 'package:rover_alteif/screens/mainScreen/start.dart';
import 'package:rover_alteif/screens/preview/live_video.dart';
import '../../Constants.dart';
import '../../services/global_method.dart';
import '../../widgets/circular_widget.dart';
class LiveMeasures extends StatefulWidget {
  const LiveMeasures({Key? key}) : super(key: key);

  @override
  State<LiveMeasures> createState() => _LiveMeasuresState();
}

class _LiveMeasuresState extends State<LiveMeasures>with TickerProviderStateMixin {
  bool isLoading=false;
  late Animation<double> _tempAnimation;
  late AnimationController _progressController;
  late Animation<double> _humidityAnimation;




  DashboardInit(double temp, double humid) async {
    _progressController =  AnimationController(
        vsync: this, duration: Duration(milliseconds: 0)); //5s

    _humidityAnimation =
    Tween<double>(begin: 0, end: humid).animate(_progressController)
      ..addListener(() {
        setState(() {});
      });
    _tempAnimation =
    Tween<double>(begin: 0, end: temp).animate(_progressController) //begin -50
      ..addListener(() {
        setState(() {});
      });




    _progressController.forward();
  }
  double?temp;
  double?humid;
  late Future task;
  Timer? timer;
  //bool start =false;
  @override
  void initState() {
    task=getMeasureData(); // to solve late initialization error
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getMeasureData());
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  getMeasureData() async {
    isLoading = true;
    double?temp;
    double?humid;
    try {
      final DocumentSnapshot measureDoc = await FirebaseFirestore.instance
          .collection('Measures')
          .doc('M_ID')
          .get();
      final DocumentSnapshot measureDoc2 = await FirebaseFirestore.instance
          .collection('Measures')
          .doc('M_ID')
          .get();

      if (measureDoc == null) {
        return;
      } else {
        setState(() {
          humid = measureDoc.get('Humid');
        });
      }
      if (measureDoc2 == null) {
        return;
      } else {
        setState(() {
          temp= measureDoc2.get('Temp');
        });
        DashboardInit(temp!, humid!);
      }
    } catch (err) {
      GlobalMethods.showErrorDialog(error: '$err', context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkBlue,
      appBar: AppBar(
        title: Text("Live Measurements",style: TextStyle(fontSize: 20),),
        backgroundColor: Constants.darkBlue,
      ),
      body: isLoading
          ? Center(
        child: Text(
          'Fetching data',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
        ),
      )
          : Stack(
        children:[
          Center(
              child:
              //isLoading ?
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomPaint(
                    foregroundPainter:
                    CircleProgress(_tempAnimation.value, true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Temperature',style: TextStyle(color: Colors.white),),
                            Text(
                              '${_tempAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    foregroundPainter:
                    CircleProgress(_humidityAnimation.value, false),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Humidity',style: TextStyle(color: Colors.white),),
                            Text(
                              '${_humidityAnimation.value.toInt()}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ],
                        ),
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
                            MaterialPageRoute(builder: (context) =>Main_Page(),),); //////////error
                        },
                          child:Text("Main Screen",style: TextStyle(fontSize: 18,color:Colors.white),),
                        ),
                        // TextButton(onPressed: () {
                        //   Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) =>LiveVideo(),),); //////////error
                        // },
                        //   child:Text("Live Video",style: TextStyle(fontSize: 18,color:Colors.white),),
                        // ),
                      ],
                    ),
                  )

                ],
              )
          ),],
      ),
    );
  }
}
