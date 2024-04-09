import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:jewelleryapp/screens/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class articles extends StatefulWidget {
  const articles({super.key});

  @override
  State<articles> createState() => _articlesState();
}

class _articlesState extends State<articles> {
  var islogin;
  var imgurl = UrlResource.artimg;
  var uid;
  Future<List<dynamic>?>? alldata;
  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });
    print("uid=${uid}");
    Uri uri = Uri.parse(UrlResource.ARTICLES);
    print(uri);
    var responce = await http.get(uri, headers: {
    });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      return json["data"];
      // print("json =${json["data"]}");
    }
    else {
      print("error");
    }
  }
  @override
  void initState() {
    super.initState();
    alldata=getdata();
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
              padding: const EdgeInsets.only(left: 60),
              child: Text("ARTICLES",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      body:  FutureBuilder(
        future: alldata,
        builder: (context, shnapshot) {
          if (shnapshot.hasData) {
            if (shnapshot.data!.length <= 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {

              return ListView.builder(
                itemCount: shnapshot.data!.length,
                itemBuilder: (context,index){
                  // return Text(shnapshot.data![index]["cat_name"].toString());

                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 20),
                    child: Card(
                      // color:Color(0xff546e7a) ,
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Image.network(imgurl + shnapshot.data![index]["img_url"].toString(),height: 200,width: 150,),
                          ],
                        ),
                      ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(
                                children: [
                                  Text(shnapshot.data![index]["title"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff546e7a),),),
                                  SizedBox(width: 70,),
                                  // (islogin != "null")? IconButton(onPressed: (){
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>comment(aid:shnapshot.data![index]["articles_id"].toString() ,)));
                                  // },
                                  //   icon: Icon(Icons.comment,color: Color(0xff546e7a),),):SizedBox(),

                                  (uid != null) ? IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => comment(aid: shnapshot.data![index]["articles_id"].toString())));
                                    },
                                    icon: Icon(Icons.comment),
                                  ) : SizedBox(), // Hide the IconButton if uid is null

                                ],
                              ),
                                Container(
                                  width:100,
                                    child: Text(shnapshot.data![index]["discription"].toString(),style:TextStyle(color: Color(0xff546e7a),))
                                ),
                    Container(
                    width: 100,
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          children: [
                            TextSpan(
                              text: shnapshot.data![index]["ref_website_url"].toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(shnapshot.data![index]["ref_website_url"].toString());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),


                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
