import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class viewreview extends StatefulWidget {
   viewreview({super.key});

  @override
  State<viewreview> createState() => _viewreviewState();
}

class _viewreviewState extends State<viewreview> {
  var imgurl= UrlResource.jwlimg;
  var imgurl1=UrlResource.reviewimg;
  var ratindno;
  var uid;
  Future<List<dynamic>?>? alldata;
  Future<List<dynamic>?>? getdata()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      uid=prefs.getString("userid");
    });
    print("uid:${uid}");
    Uri uri=Uri.parse(UrlResource.VIEWREVIEW);
    print(uri);
    var responce=await http.post(uri,body:{
      "user_id":uid,
    });
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
  @override
  void initState(){
    super.initState();
    alldata=getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
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
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("MY REVIEW",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),

      body: FutureBuilder(
        future: alldata,
        builder: (context,shnapshot){
          if(shnapshot.hasData) {
            if (shnapshot.data!.length <= 0) {
              return Center(child: Text("No Data"),);
            }
            else {
              return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // height: MediaQuery.sizeOf(context).height,
                            width: MediaQuery.sizeOf(context).width,
                            child: Column(
                              children:shnapshot.data!.map((value){
                                // return Padding(
                                //   padding: const EdgeInsets.only(bottom: 18.0,top: 20),
                                //   child: Column(
                                //     children: [
                                //       Container(
                                //         width: 350,
                                //         child: Card(
                                //           elevation: 4,
                                //           color: Color(0xff546e7a),
                                //           child: Column(
                                //             children: [
                                //               Padding(
                                //                 padding: const EdgeInsets.all(20.0),
                                //                 child: Text(value["title"].toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                //               ),
                                //                SizedBox(height: 10,),
                                //                RatingBar.builder(
                                //                       initialRating: double.tryParse(value["rating"] ?? "") ?? 0.0,
                                //                       ignoreGestures: true,
                                //                       minRating: 1,
                                //                       direction: Axis.horizontal,
                                //                       allowHalfRating: true,
                                //                       itemCount: 5,
                                //                       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                //                       itemBuilder: (context, _) => Icon(
                                //                         Icons.star,
                                //                         color: Colors.amber,
                                //                       ),
                                //                       onRatingUpdate: (rating) {
                                //                         setState(() {
                                //                           ratindno = rating;
                                //                         });
                                //                         print(rating);
                                //                       },
                                //                     ),
                                //               Padding(
                                //                 padding: const EdgeInsets.all(15.0),
                                //                 child: Text(value["review_text"].toString(),style: TextStyle(color: Colors.white),),
                                //               ),
                                //               Image.network(imgurl+value["img1"].toString(),height: 200,width: 300,),
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // );
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 10, left: 10),
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      imgurl+value["img1"].toString(),

                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 135),
                                                    child: Text(
                                                      "Dream Jewels",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:250,
                                                        child: Text(
                                                          value["title"].toString(),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.black,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Review :- ",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Container(
                                                            width: 200,
                                                            child: Text(
                                                              value["review_text"].toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBar.builder(
                                                                                  initialRating: double.tryParse(value["rating"] ?? "") ?? 0.0,
                                                                                  ignoreGestures: true,
                                                                                  minRating: 1,
                                                                                  direction: Axis.horizontal,
                                                                                  allowHalfRating: true,
                                                                                  itemCount: 5,
                                                                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                                                  itemBuilder: (context, _) => Icon(
                                                                                    Icons.star,
                                                                                    color: Colors.amber,
                                                                                  ),
                                                                                  onRatingUpdate: (rating) {
                                                                                    setState(() {
                                                                                      ratindno = rating;
                                                                                    });
                                                                                    print(rating);
                                                                                  },
                                                                                ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 150,

                                                              alignment: Alignment.topLeft,
                                                              child: Image.network(imgurl1+value["img"].toString(),)),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator(),);
      
          }
        },
      ),
    );
  }
}
