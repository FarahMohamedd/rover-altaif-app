import 'package:flutter/material.dart';
import 'package:rover_alteif/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onboardingScreens extends StatefulWidget {
  const onboardingScreens({Key? key}) : super(key: key);

  @override
  State<onboardingScreens> createState() => _onboardingScreensState();
}

class _onboardingScreensState extends State<onboardingScreens> {
  final controller=PageController();
  bool isLastPage=false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(() {
              isLastPage= index==2;
            });
          },
          children: [
            Container(
              child: Stack(
                children: [
                  Image(
                    image: AssetImage("images/background.jpeg"),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      color: Colors.white24,

                      child:
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Hello dear Scientist, I'm Altaif Rover, I will be your explorer in hard exploring places.",style:
                        TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),)
                ],
              ),
            ),
            Container(
              color:Color(0xFF78c4eb),
              //color: Color(0xFFfefc83),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("images/object.jpg"),
                    // fit: BoxFit.fill,
                    width: 350,
                    height: 200,
                  ),
                  Container(
                      color: Colors.white30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("I can detect objects",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      )),
                  Image(
                    image: AssetImage("images/map.jpeg"),
                    // fit: BoxFit.fill,
                    // width: double.infinity,
                    width: 350,
                    height: 250,
                  ),
                  Container(
                      color: Colors.white30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("I can get map of my journey",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      )),
                ],
              ),
            ),

            Container(
              // color:Color(0xFF78c4eb),
              color: Color(0xFFfefc83),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("images/humid.png"),
                    // fit: BoxFit.fill,
                    // width: double.infinity,
                    height: 300,
                  ),
                  Container(
                      color: Colors.white30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("I can measure temprature and humidity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      )),
                  Image(
                    image: AssetImage("images/mazee.png"),
                    // fit: BoxFit.fill,
                    // width: double.infinity,
                    height: 300,
                  ),
                  Container(
                      color: Colors.white30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("I can solve mazes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage?
      TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
              ),
              primary: Colors.white,
              backgroundColor: Colors.teal.shade700,
              minimumSize: const Size.fromHeight(70)
          ),
          onPressed: ()
          async{
            final prefs =await SharedPreferences.getInstance();
            prefs.setBool("showHome", true);

            //

            Navigator.of(context).pushReplacement(MaterialPageRoute
              (builder: (context)=>UserState()));

            //
          }, child: const Text('Get Started',style: TextStyle(fontSize: 24),)):

      Container(
        padding: const  EdgeInsets.symmetric(horizontal:30),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){controller.jumpToPage(2);}, child: const Text("SKIP")),
            Center(
              child: SmoothPageIndicator(
                controller:controller,
                count:3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index)=>controller.animateToPage(index, duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(onPressed: ()=>controller.nextPage(
                duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
                child: Text("NEXT",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),

          ],
        ),
      ),
    );
  }
}
