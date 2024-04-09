import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var imgurl = UrlResource.catimg;
  var imgurl1 = UrlResource.subcatimg;
  var imgurl2=UrlResource.galleryimg;
  var uid;
  Future<List<dynamic>?>? alldata;
  Future<dynamic>? alldata1;

  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });

    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWCAT);
    print(uri);
    var responce = await http.post(uri);
    // var responce = await http.get(uri);
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      return json["data"];
      // print("json =${json["data"]}");
    } else {
      print("error");
    }
  }
  List<dynamic> galleryData = [];
  Future<List<dynamic>?>? alldata2;
  Future<List<dynamic>?>? getdata1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });

    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWGALLERYADD);
    print(uri);
    var responce = await http.post(uri);
    // var responce = await http.get(uri);
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
     setState(() {
       galleryData = json["data"];

     });
      print("jsongallery =${galleryData}");
    } else {
      print("error");
    }
  }

  List<String>? images;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    alldata = getdata();
    alldata2=getdata1();
    print(imgurl);
  }

  var catid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Container(
          decoration: BoxDecoration(
            color:Color(0xff546e7a) ,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
            Center(child: Text("HOME PAGE",style: TextStyle(color:Colors.white),)),
          ),
        ),
      ),
      body:
          SingleChildScrollView(
            child: Column(

             children: [
               SizedBox(height: 0,),

               SizedBox(
                 height: 10,
               ),

               SizedBox(
                 height: 10,
               ),

               SizedBox(height: 15),
               CarouselSlider(
                 items: (galleryData as List<dynamic>).map<Widget>((value) {
                   images = [imgurl2 + value["img_url"].toString()];
                   // print(images);
                   return Container(
                     margin: EdgeInsets.all(6.0),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8.0),
                       image: DecorationImage(
                         image: NetworkImage(imgurl2 + value["img_url"]),
                         fit: BoxFit.cover,
                       ),
                     ),
                   );
                 }).toList(),
                 options: CarouselOptions(
                   onPageChanged: (index, reason) {
                     setState(() {
                       _currentIndex = index;
                       print("index = ${_currentIndex}");
                     });
                   },
                   height: 180.0,
                   enlargeCenterPage: true,
                   autoPlay: true,
                   aspectRatio: 16 / 9,
                   autoPlayCurve: Curves.fastOutSlowIn,
                   enableInfiniteScroll: true,
                   autoPlayAnimationDuration: Duration(milliseconds: 800),
                   viewportFraction: 0.8,
                 ),
               ),


               DotsIndicator(
                 // dotsCount: images != null ? images!.length : 0,
                 // position: _currentIndex.toInt(),
                 dotsCount: 3,
                 position: _currentIndex.toInt(),
                 decorator: DotsDecorator(
                   size: const Size.square(8.0),
                   color: Colors.black,
                   activeColor: Color(0xff546e7a),
                   activeSize: const Size(20.0, 8.0),
                   activeShape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(5.0),
                   ),
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.only(left: 8.0),
                 child: Align(alignment: Alignment.centerLeft, child: Text(
                   "Category",
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize:20,
                     color: Colors.black,
                   ),
                 )),
               ),


               FutureBuilder(
                 future: alldata,
                 builder: (context, snapshot) {
                   if (snapshot.hasData) {
                     if (snapshot.data!.length <= 0) {
                       return Center(
                         child: Text("No Data"),
                       );
                     } else {
                       return SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Row(
                           children: snapshot.data!.map<Widget>((value) {
                             return Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Container(
                                 // width: 200,
                                 child: Column(
                                   children: [
                                     GestureDetector(

                                       child: Container(
                                         height: 150,
                                         width: 150,
                                         child: AspectRatio(
                                           aspectRatio: 2.62 / 3,
                                           child: Container(
                                             margin: EdgeInsets.only(right: 5.0),
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(20),
                                               image: DecorationImage(fit: BoxFit.cover, image:   NetworkImage(imgurl + value["cat_img"].toString()),),
                                             ),
                                             child: Container(
                                               decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(20),
                                                   gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                                                     0.1,
                                                     0.9
                                                   ], colors: [
                                                     Colors.black.withOpacity(.100),
                                                     Colors.black.withOpacity(.1)
                                                   ])),
                                             ),
                                           ),
                                         )


                                       ),
                                       onTap: ()async{

                                           catid = value["cat_id"].toString();
                                           print(catid);


                                           Uri uri = Uri.parse(UrlResource.VIEWSUB);
                                           print(uri);
                                           var responce = await http.post(uri, body: {
                                             "cid": catid,
                                           });
                                           // var responce = await http.get(uri);
                                           print(responce.statusCode);
                                           if (responce.statusCode == 200) {
                                             print("object");
                                             var body = responce.body.toString();
                                             print(body);
                                             var json = jsonDecode(body);
                                             setState(() {
                                               alldata1 = Future.value(json["data"]);
                                             });
                                             // print("json =${json["data"]}");
                                           } else {
                                             print("error");
                                           }

                                       },
                                     ),
                                     SizedBox(height: 10),
                                     Text(value["cat_name"].toString(),
                                       style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize:20,
                                         color: Colors.black,
                                       ),
                                     ), // Assuming there's a key named "cat_name"
                                   ],
                                 ),
                               ),
                             );
                           }).toList(),
                         ),
                       );
                     }
                   } else {
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                 },
               ),

               FutureBuilder(
                 future: alldata1,
                 builder: (BuildContext context, AsyncSnapshot snapshot) {
                   if (snapshot.hasData) {
                     if (snapshot.data!.length <= 0) {
                       return Center(
                         child: Text("No Data"),
                       );
                     } else {
                       return SingleChildScrollView(
                         scrollDirection: Axis.vertical,
                         child: Column(
                           children: snapshot.data!.map<Widget>((value) {
                             return  Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 10),
                               child: Container(
                                   height: 150,
                                   width: 370,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20),
                                     image: DecorationImage(
                                         fit: BoxFit.cover, image:NetworkImage(imgurl1 +value["subcat_img"].toString())),
                                   ),
                                   child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         gradient: LinearGradient(
                                             begin: Alignment.bottomRight,
                                             stops: [
                                               0.3,
                                               0.9
                                             ],
                                             colors: [
                                               Colors.black.withOpacity(.7),
                                               Colors.black.withOpacity(.2)
                                             ]),
                                       ),
                                       child: Align(
                                         alignment: Alignment.bottomLeft,
                                         child: Padding(
                                           padding: const EdgeInsets.all(20),
                                           child: Text(value["subcat_name"].toString(),
                                             style: TextStyle(color: Colors.white, fontSize: 20),
                                           ),
                                         ),
                                       ))),
                             );
                           }).toList(),
                         ),
                       );
                     }
                   } else {
                     return Column(
                       children: [
                         SizedBox(height: 10,),
                         Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15), // Set your desired border radius here
                           ),
                           child: Image.asset("img/anushka.png",width: 400,),
                         ),
                         SizedBox(height: 40,),
                       ],
                     );


                   }
                 },
               ),

SizedBox(height: 70,)
             ],
            ),
          ),

    );
  }
}

Widget promo(image) {
  return AspectRatio(
    aspectRatio: 2.62 / 3,
    child: Container(
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
              0.1,
              0.6
            ], colors: [
              Colors.black.withOpacity(.0),
              Colors.black.withOpacity(.0)
            ])),
      ),
    ),
  );
}
