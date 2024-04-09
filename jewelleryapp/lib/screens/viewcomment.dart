import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class viewcomment extends StatefulWidget {
  const viewcomment({super.key});

  @override
  State<viewcomment> createState() => _viewcommentState();
}



class _viewcommentState extends State<viewcomment> {
  var imgurl= UrlResource.artimg;
  var uid;
  Future<List<dynamic>?>? alldata;
  // Future<List<dynamic>?>? getdata()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = prefs.getString("userid");
  //   });
  //
  //
  //   print("uid = ${uid}");
  //   Uri uri=Uri.parse(UrlResource.VIEWCOMMENT);
  //   print(uri);
  //   var responce=await http.post(uri,body:{
  //     "user_id":uid,
  //   });
  //   print(responce.statusCode);
  //   if (responce.statusCode == 200) {
  //     var body = responce.body.toString();
  //     print(body);
  //     print("demo");
  //     var json = jsonDecode(body);
  //     // return json["data"];
  //     print("object12");
  //     print("json =${json["data"]}");
  //   } else {
  //     print("error");
  //   }
  // }
  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });

    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWCOMMENT);
    print(uri);
    var responce = await http.post(uri, body: {
      "user_id": uid,
    });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body;
      print("Response body: $body");
      print("demo");
      try {
        Map<String, dynamic> jsonData = jsonDecode(body);
        print("Parsed JSON: $jsonData");
        if (jsonData.containsKey("status") && jsonData["status"] == "true" && jsonData.containsKey("data")) {
          List<dynamic> dataList = jsonData["data"];
          print("json  = $dataList");
          return dataList;
        } else {
          print("Invalid response format or status is false.");
        }
      } catch (e) {
        print("Error parsing JSON: $e");
      }
    } else {
      print("Error: ${responce.statusCode}");
    }



  }

  @override
  void initState(){
    super.initState();
    setState(() {
      alldata=getdata();
    });
  }
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
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("MY COMMENT",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: alldata,
          builder: (context,shnapshot){
            if(shnapshot.hasData) {
              if (shnapshot.data!.length <= 0) {
                return Center(child: Text("No Data"),);
              }
              else {
                return
                  Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // height: MediaQuery.sizeOf(context).height,
                            width: MediaQuery.sizeOf(context).width,
                            child: Column(
                              children:shnapshot.data!.map((value){
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
                                                          imgurl+value["img_url"].toString(),

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
                                                      Text(
                                                        value["title"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
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
                                                            "Comment :- ",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Container(
                                                            width: 200,
                                                            child: Text(
                                                              value["comment"].toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
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
      ),
    );
  }
}
