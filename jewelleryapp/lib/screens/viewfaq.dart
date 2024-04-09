import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../resource/UrlResource.dart';

class viewfaq extends StatefulWidget {
  const viewfaq({super.key});
  @override
  State<viewfaq> createState() => _viewfaqState();
}

class _viewfaqState extends State<viewfaq> {
  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    Uri uri = Uri.parse(UrlResource.VIEWFAQ);
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
            color: Color(0xff546e7a),
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
              child: Text("SUPPORT", style: TextStyle(color: Colors.white),),
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10,right: 10,left: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 2,
                        spreadRadius: 0
                    )
                  ]
              ),
              child:
              ListTile(
                title: Text("Contact HelpLine No :-"),
                leading: Image.asset("img/feedback.jpg",height: 50,width: 40,),
                trailing:IconButton(
            icon: Icon(Icons.call), // Icon you want to display
            onPressed: () {
        setState(() {
          _callNumber();
        });
            }
        
            ),
              ),
            ),
        
            FutureBuilder(
              future: alldata,
              builder: (context, shnapshot) {
                if (shnapshot.hasData) {
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
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width,
                                child: Column(
                                  children: shnapshot.data!.map((value) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
        
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Container(
                                            // height: 100,
                                            width: 400,
                                            child: Card(
                                              // color: Color(0xff546e7a),
                                              color: Colors.grey.shade200,
                                              // elevation: 20,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,top: 5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(value["questions"].toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20),),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.chevron_right),
                                                        SizedBox(width: 10,),
                                                        Container(
                                                            width: 290,
                                                            child: Text(value["answer"]
                                                                .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
        
          ],
        ),
      ),

    );
  }
}
_callNumber() async{
  const number = '7069590159'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
