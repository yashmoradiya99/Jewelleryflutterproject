import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/screens/jewll.dart';

class subcategory extends StatefulWidget {

  var id;
   subcategory({super.key,this.id});

  @override
  State<subcategory> createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {
  var imgurl = UrlResource.subcatimg;

  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {




    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWSUB);
    print(uri);
    var responce = await http.post(uri, body: {
      "cid": widget.id,
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
              child: Text("SUBCATEGORY PAGE",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
     body: FutureBuilder(
       future: alldata,
       builder: (context,shnapshot){
         if(shnapshot.hasData){
           if(shnapshot.data!.length<=0)
           {
             return Center(child: Text("No Data"),);
           }
           else{
            return SingleChildScrollView(
              child: Column(
                children:shnapshot.data!.map((value){
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>jewll(id: value["subcat_id"].toString(),))
                        );
                      },
                      child: Stack(
                        children: [
                          // SizedBox(height: 300,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(imgurl+ value["subcat_img"].toString(),),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                height: 30,
                                // padding: EdgeInsets.all(20),
                                // width: 100,
                                child: Center(child: Text(value["subcat_name"].toString(),style: TextStyle(color: Color(0xff546e7a),fontSize: 20,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          )
                          // SizedBox(height: 100,),
                          // Text(value["subcat_name"].toString()),
                          // Container(
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8.0),
                          //     image: DecorationImage(
                          //       // image: AssetImage("img/j2.png"),
                          //       // image: NetworkImage('https://picsum.photos/250?image=9'),
                          //       image: NetworkImage(imgurl+ value["subcat_img"].toString(),),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
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
