import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/feedback.dart';

class viewfeedback extends StatefulWidget {
  const viewfeedback({super.key});

  @override
  State<viewfeedback> createState() => _viewfeedbackState();
}

class _viewfeedbackState extends State<viewfeedback> {
  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    Uri uri = Uri.parse(UrlResource.VIEWFEEDBACK);
    print(uri);
    var responce = await http.post(uri, body: {});
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
              padding: const EdgeInsets.only(left: 35),
              child: Text("MY FEEDBACK",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff546e7a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: (){
          Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>feedback()));
      }, child: Icon(Icons.add,color: Colors.white,),),
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
                                    // padding: const EdgeInsets.all(6),
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
                                                width: 60,
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
                                                        "Name:- ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      Text(
                                                        value["name"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Contact:- ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      Text(
                                                        value["contact"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Email:- ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      Text(
                                                        value["email"].toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Feedback:- ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 201,
                                                        child: Text(
                                                          value["feedback"].toString(),
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
                                        // const Divider(
                                        //   thickness: 1,
                                        //   color: Colors.black,
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(4.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //             children: [
                                        //               Row(
                                        //                 children: [
                                        //                   Text(
                                        //                     "Payment :- ",
                                        //                     style: TextStyle(
                                        //                       fontSize: 18,
                                        //                       fontWeight: FontWeight.normal,
                                        //                     ),
                                        //                   ),
                                        //                   const SizedBox(width: 5),
                                        //                   Text(
                                        //                     value["total_payment"].toString(),
                                        //                     style: TextStyle(
                                        //                       fontSize: 14,
                                        //                       fontWeight: FontWeight.bold,
                                        //                     ),
                                        //                   ),
                                        //                   const SizedBox(width: 30),
                                        //                   Text(
                                        //                     "Status :- ",
                                        //                     style: TextStyle(
                                        //                       fontSize: 14,
                                        //                       fontWeight: FontWeight.normal,
                                        //                     ),
                                        //                   ),
                                        //                   const SizedBox(width: 5),
                                        //                   Text(
                                        //                     value["status"].toString(),
                                        //                     style: TextStyle(
                                        //                       fontSize: 14,
                                        //                       fontWeight: FontWeight.bold,
                                        //                       color: Colors.green,
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               Row(
                                        //                 children: [
                                        //                   Text(
                                        //                     "Book Date :- ",
                                        //                     style: TextStyle(
                                        //                       fontSize: 18,
                                        //                       fontWeight: FontWeight.normal,
                                        //                     ),
                                        //                   ),
                                        //                   const SizedBox(width: 5),
                                        //                   Text(
                                        //                     value["order_date_time"].toString(),
                                        //                     style: TextStyle(
                                        //                       fontSize: 14,
                                        //                       fontWeight: FontWeight.bold,
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               )
                                        //             ],
                                        //           )),
                                        //     ],
                                        //   ),
                                        // ),
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
