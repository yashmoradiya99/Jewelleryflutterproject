import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/screens/viewcomment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resource/UrlResource.dart';
import 'package:http/http.dart' as http;
class comment extends StatefulWidget {
  var aid;
  comment({super.key,this.aid});

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  var uid;
  Future<List<dynamic>?>? alldata;


  TextEditingController comment=TextEditingController();
  var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Container(
          decoration: BoxDecoration(
            color:Color(0xff546e7a) ,
            // borderRadius: const BorderRadius.only(
            //   bottomRight: Radius.circular(24),
            //   bottomLeft: Radius.circular(24),
            // ),
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
              child: Text("ARTICLES COMMENT",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff546e7a),
                          Color(0xff546e7a),
                        ],
                      ))),
              Container(
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 3),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                          "img/logo1.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.0,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(height: 60.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2.5,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              const  SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "ADD COMMENT",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff546e7a),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                          TextFormField(
                                                validator: (val){
                                                  if(val!.length<=0)
                                                  {
                                                    return "Please Enter Comment";
                                                  }
                                                  return null;
                                                },
                                                controller: comment,
                                                maxLines: 4,
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.comment),
                                                  border: OutlineInputBorder(

                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide: BorderSide(color: Colors.black),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide: BorderSide(color: Colors.black),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide: BorderSide(color: Color(0xff546e7a)),
                                                  ),
                                                  hintText: "Enter Comment",
                                                  labelText: "Comment",
                                                  labelStyle: TextStyle(color: Colors.black),

                                                ),
                                              ),
                              SizedBox(height: 15,),
                                                ElevatedButton(onPressed: ()async {
    if(formkey.currentState!.validate()) {
      var cmt = comment.text
          .toString();
      print(cmt);
      SharedPreferences prefs = await SharedPreferences
          .getInstance();
      setState(() {
        uid = prefs.getString(
            "userid");
      });
      print(uid);
      print(widget.aid);
      print(cmt);
      Uri uri = Uri.parse(
          UrlResource.COMMENT);
      var responce = await http
          .post(uri, body: {
        "comment": cmt,
        "articles_id": widget.aid,
        "user_id": uid,
      });
      if (responce.statusCode ==
          200) {
        var body = responce.body
            .toString();
        print(body);
        var json = jsonDecode(
            body);
        print("test");
        if (json["status"] ==
            "true") {
          var msg = json["message"]
              .toString();
          print(msg);
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(
              MaterialPageRoute(
                  builder: (context) =>
                      viewcomment()));
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast
                  .LENGTH_SHORT,
              gravity: ToastGravity
                  .CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors
                  .red,
              textColor: Colors
                  .white,
              fontSize: 16.0);
          // Navigator.of(context).push(
          // MaterialPageRoute(builder: (context)=>CustomNavigationBar())
          // );
        }
        else {
          print("demo");
          var msg = json["message"]
              .toString();
          print(msg);
        }
      }
      else {
        print("error");
      }
    }
                                                  },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Color(0xff546e7a),
                                                      onPrimary: Colors.white,
                                                      minimumSize: Size(200, 50),
                                                    ),
                                                    child: Text("Submit")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
