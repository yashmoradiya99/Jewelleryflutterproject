import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/screens/details.dart';

class jewll extends StatefulWidget {
  var id;
  jewll({super.key,this.id});

  @override
  State<jewll> createState() => _jewllState();
}

class _jewllState extends State<jewll> {
  Future<List<dynamic>?>? alldata;
  var imgurl= UrlResource.jwlimg;

  Future<List<dynamic>?>? getdata() async {



print(widget.id);
    print("object");
    Uri uri = Uri.parse(UrlResource.jewel);
    print(uri);
    var responce = await http.post(uri, body: {
      "subid": widget.id,
    });
    // var responce = await http.get(uri);
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      print("object");
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
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Text(widget.id),
      // ),
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
              padding: const EdgeInsets.only(left: 20),
              child: Text("JEWELLERY PAGE",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      // body: FutureBuilder(
      //   future: alldata,
      //   builder: (context,shnapshot)
      //   {
      //     if(shnapshot.hasData)
      //     {
      //       if(shnapshot.data!.length<=0)
      //       {
      //         return Center(child: Text("No Data"),);
      //       }
      //       else {
      //         return GridView.builder(
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               mainAxisSpacing: 10,
      //               crossAxisSpacing: 10
      //           ),
      //           itemCount: shnapshot.data!.length,
      //           itemBuilder: (context,index){
      //             // return Text(shnapshot.data![index]["cat_name"].toString());
      //             return GestureDetector(
      //               onTap: (){
      //                 Navigator.of(context).push(
      //                     MaterialPageRoute(builder: (context)=>details(title:shnapshot.data![index]["title"].toString(),desc:shnapshot.data![index]["description"].toString(),price: shnapshot.data![index]["price"].toString(),spec:shnapshot.data![index]["specification"].toString(),user:shnapshot.data![index]["usertype"].toString(),jid:shnapshot.data![index]["jewellery_id"].toString(),img1:shnapshot.data![index]["img1"].toString(),img2:shnapshot.data![index]["img2"].toString(),img3:shnapshot.data![index]["img3"].toString(),video:shnapshot.data![index]["video_url"].toString(),))
      //                 );
      //               },
      //               child: Container(
      //                 height: 190,
      //                 width: 170,
      //                 child: Card(
      //                   elevation: 20,
      //                   color: Color(0xff546e7a),
      //                   child: Column(
      //                     children: [
      //                       SizedBox(height: 5,),
      //                       Text("₹"+shnapshot.data![index]["price"].toString(), style: TextStyle(
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 15),),
      //                       SizedBox(height: 5,),
      //                       Image.network(imgurl + shnapshot.data![index]["img1"],
      //                         height: 140, width: 220,),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         );
      //
      //       }
      //     }
      //     else
      //     {
      //       return Center(child: CircularProgressIndicator(),);
      //
      //     }
      //   },
      // ),


      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: SizedBox(
          //     height: 50,
          //     width: 400,
          //     child: TextFormField(
          //       keyboardType: TextInputType.text,
          //       decoration: InputDecoration(
          //         prefixIcon: Icon(Icons.search),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: BorderSide(color: Colors.black),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: BorderSide(color: Colors.black),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: BorderSide(color: Color(0xff546e7a)),
          //         ),
          //         hintText: "Enter a search term ",
          //         labelText: "Search",
          //         labelStyle: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: FutureBuilder(
              future: alldata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData && snapshot.data!.length > 0) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var value = snapshot.data![index];
                      return GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>details(title:value["title"].toString(),desc:value["description"].toString(),price: value["price"].toString(),spec:value["specification"].toString(),user:value["usertype"].toString(),jid:value["jewellery_id"].toString(),img1:value["img1"].toString(),img2:value["img2"].toString(),img3:value["img3"].toString(),video:value["video_url"].toString(),))
                                          );
                                        },
                                        child: Container(
                                          height: 190,
                                          width: 170,
                                          child: Card(
                                            elevation: 20,
                                            color: Color(0xff546e7a),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5,),
                                                Text("₹"+value["price"].toString(), style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),),
                                                SizedBox(height: 5,),
                                                Image.network(imgurl + value["img1"],
                                                  height: 140, width: 220,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                    },
                  );
                }
                return Center(
                  child: Text("No Data"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
