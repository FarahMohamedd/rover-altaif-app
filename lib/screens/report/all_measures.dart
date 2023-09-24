// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';//////////razan
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:rover_alteif/screens/mainScreen/main_page.dart';
// import 'package:rover_alteif/screens/report/all_measures.dart';
// import '../../Constants.dart';
// import '../mainScreen/start.dart';
// class AllMeasures extends StatefulWidget {
//   const AllMeasures({Key? key}) : super(key: key);
//
//   @override
//   State<AllMeasures> createState() => _AllMeasuresScreenState();
// }
//
// class _AllMeasuresScreenState extends State<AllMeasures> {
//   FirebaseStorage firebaseStorage= FirebaseStorage.instance;
//   bool loading=false;
//   Map? image;
//   Future<List> loadImages()async{
//     List<Map> files=[];
//     // final ListResult result=await firebaseStorage.ref().listAll();
//     final ListResult result=await firebaseStorage.ref('/reports').list();
//     final List<Reference> allFiles=result.items;
//     await Future.forEach(allFiles,(Reference file)async{
//       final String fileUrl= await file.getDownloadURL();
//       files.add({
//         "url":fileUrl,
//         "path":file.fullPath
//       });
//     });
//     print(files);
//     return files;
//   }
//   Future<void> delete(String ref)async{
//     await firebaseStorage.ref(ref).delete();
//     setState(() {
//       // image=null;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Constants.darkBlue,
//         title: Text("Analyzed Reports",style: TextStyle(fontSize: 20),),
//       ),
//       body: Stack(
//         children: [
//           CachedNetworkImage(
//             imageUrl: "https://cei.org/wp-content/uploads/2019/09/av-3-578x324-c-default.png",
//             placeholder: (context, url) => Image.asset(
//               'images/roverlogin.webp',
//               fit: BoxFit.fill,
//             ),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           StreamBuilder(
//               builder: (context,AsyncSnapshot snapshot) {
//                 if (snapshot.hasError) {
//                   return Text(("Error"));
//                 }
//                 if (snapshot.hasData) {
//                   return FutureBuilder( //////////// stream builder
//                       future: loadImages(),
//                       builder: (context, AsyncSnapshot snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//                         image=snapshot.data[0];
//                         return ListView.builder(
//                             itemCount: snapshot.data.length ?? 0,
//                             itemBuilder: (context, index) {
//                               final Map image = snapshot.data[index];
//                               return Row(
//                                 children: [
//                                   Expanded(child: Card(
//                                     child: Container(
//                                       height: 200,
//                                       child: Image.network(image['url']),
//                                     ),
//
//                                   )),
//                                   IconButton(onPressed: () async {
//                                     await delete(image['path']);
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                       content: Text(
//                                           "image deleted successfully"),));
//                                   },
//                                       icon: Icon(
//                                         Icons.delete, color: Colors.red,))
//                                 ],
//                               );
//                             });
//                       });
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 50,),
//                       Expanded(
//                         child: FutureBuilder(
//                             future: loadImages(),
//                             builder: (context, AsyncSnapshot snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                               return ListView.builder(
//                                 // itemCount: snapshot.data.length,
//                                   itemCount: 1,
//                                   itemBuilder: (context, index) {
//                                     //final Map image = snapshot.data[index];
//                                     image = snapshot.data[0]; ////////////////// lma b3ml delete bizhr al sora ely b3dha
//                                     ///////////////////////// try init state to solve late initialization error
//                                     return Column(
//                                       children: [
//                                         SizedBox(
//                                           height: 140,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(child: Card(
//                                               child: Container(
//                                                 height: 200,
//                                                 child: Image.network(image?['url'],height:1000,width: 1000,),
//                                               ),
//
//                                             )),
//                                           ],
//                                         ),
//                                         // Row(
//                                         //   children: [
//                                         //     SizedBox(width: 250,),
//                                         //     IconButton(onPressed: (){
//                                         //       ScaffoldMessenger.of(context)
//                                         //           .showSnackBar(SnackBar(
//                                         //         content: Text(
//                                         //             "Image Saved successfully"),));
//                                         //
//                                         //     },
//                                         //         icon: Icon(
//                                         //           Icons.save_alt, color: Colors.green,)
//                                         //     ),
//                                         //     IconButton(onPressed: () async {
//                                         //       await delete(image?['path']);
//                                         //       ScaffoldMessenger.of(context)
//                                         //           .showSnackBar(SnackBar(
//                                         //         content: Text(
//                                         //             "image deleted successfully"),));
//                                         //     },
//                                         //         icon: Icon(
//                                         //           Icons.delete, color: Colors.red,)),
//                                         //   ],
//                                         // ),
//                                         SizedBox(
//                                           height: 200,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             TextButton(onPressed: () {
//                                               Navigator.push(context,
//                                                 MaterialPageRoute(builder: (context) =>Main_Page()
//                                                   ,),); //////////error
//                                             },
//                                               child:Text("Main Screen",style: TextStyle(fontSize: 18,color:Colors.white),),
//                                             ),
//                                             // TextButton(onPressed: () {
//                                             //   Navigator.push(context,
//                                             //     MaterialPageRoute(builder: (context) =>AllMeasures(),),); //////////error
//                                             // },
//                                             //   child:Text("Report",style: TextStyle(fontSize: 18,color:Colors.white),),
//                                             // ),
//                                           ],
//                                         ),
//
//                                       ],
//                                     );
//                                   });
//                             }),
//                       ),
//
//                     ],
//                   ),
//                 );
//
//               }
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';              ///////////////////razan
// class SavedMaps extends StatefulWidget {
//   const SavedMaps({Key? key}) : super(key: key);
//
//   @override
//   State<SavedMaps> createState() => _SavedMapsState();
// }
//
// class _SavedMapsState extends State<SavedMaps> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';//////////razan
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rover_alteif/widgets/drawer_widget.dart';
import '../../Constants.dart';
class AllMeasures extends StatefulWidget {
  const AllMeasures({Key? key}) : super(key: key);

  @override
  State<AllMeasures> createState() => _AllMeasuresState();
}

class _AllMeasuresState extends State<AllMeasures> {
  FirebaseStorage firebaseStorage= FirebaseStorage.instance;
  bool loading=false;

  Future<List> loadImages()async{
    List<Map> files=[];
    final ListResult result=await firebaseStorage.ref('/reports').listAll();
    //final ListResult result=await firebaseStorage.ref().listAll();
    final List<Reference> allFiles=result.items;
    await Future.forEach(allFiles,(Reference file)async{
      final String fileUrl= await file.getDownloadURL();
      files.add({
        "url":fileUrl,
        "path":file.fullPath

      });
    });
    print(files);
    return files;
  }

  Future<void> delete(String ref)async{
    await firebaseStorage.ref(ref).delete();
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkBlue,
        title: Text("   Analyzed Reports",style: TextStyle(fontSize: 20),),
      ),
      //drawer: DrawerWidget(),
      body: Stack(
        children: [
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
          StreamBuilder(
              builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(("Error"));
                }
                if (snapshot.hasData) {
                  return FutureBuilder( //////////// stream builder
                      future: loadImages(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.length??0,
                            itemBuilder: (context, index) {
                              final Map image = snapshot.data[index];
                              return Row(
                                children: [
                                  Expanded(child: Card(
                                    child: Container(
                                      height: 200,
                                      child: Image.network(image['url']),
                                    ),

                                  )),
                                  IconButton(onPressed: () async {
                                    await delete(image['path']);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "image deleted successfully"),));
                                  },
                                      icon: Icon(
                                        Icons.delete, color: Colors.red,))
                                ],
                              );
                            });
                      });
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Expanded(
                        child: FutureBuilder( //////////// stream builder
                            future: loadImages(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data.length??0,
                                  itemBuilder: (context, index) {
                                    final Map image = snapshot.data[index];
                                    return Row(
                                      children: [
                                        Expanded(child: Card(
                                          child: Container(
                                            height: 200,
                                            child: Image.network(image['url']),
                                          ),

                                        )),
                                        IconButton(onPressed: () async {
                                          await delete(image['path']);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "image deleted successfully"),));
                                        },
                                            icon: Icon(
                                              Icons.delete, color: Colors.red,))
                                      ],
                                    );
                                  });
                            }),
                      ),

                    ],
                  ),
                );

              }
          ),
        ],
      ),
    );
  }
}

