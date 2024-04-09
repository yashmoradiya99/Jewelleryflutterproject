import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/screens/bil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  var uid;
  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });


    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWORDER);
    print(uri);
    var responce = await http.post(uri, body: {
      "user_id": uid,
    });
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
  @override
  void initState() {
    super.initState();
    alldata = getdata();

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
              padding: const EdgeInsets.only(left: 70),
              child: Text("MY ORDER",style: TextStyle(color:Colors.white),),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        // height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          children:shnapshot.data!.map((value){

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => bil(oid:value["t_number"].toString(),)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 178,
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
                                                  // image: NetworkImage(
                                                  //   imgurl +
                                                  //       snapshot.data![index]
                                                  //       ["seat_image"]
                                                  //           .toString(),
                                                  // ),
                                                  image: AssetImage(
                                                      "img/logo2.png"
                                                  ),
                                                  fit: BoxFit.contain,
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
                                                    // snapshot.data![index]["bus_type"]
                                                    //     .toString(),
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
                                                      "Bil No :- ",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      // snapshot.data![index]["bus_number"]
                                                      //     .toString(),
                                                      value["t_number"].toString(),
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
                                                          "Payment :- ",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          value["total_payment"].toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 30),
                                                        Text(
                                                          "Status :- ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          value["status"].toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Book Date :- ",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          value["order_date_time"].toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
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
                              ),
                            );
                                }
                        ).toList(),
                      ),
                                        ),
                    ],
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