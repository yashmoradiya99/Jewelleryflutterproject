import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jewelleryapp/screens/ChangePassword.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:jewelleryapp/screens/Profile.dart';
import 'package:jewelleryapp/screens/articles.dart';
import 'package:jewelleryapp/screens/comment.dart';
import 'package:jewelleryapp/screens/feedback.dart';
import 'package:jewelleryapp/screens/order.dart';
import 'package:jewelleryapp/screens/viewcomment.dart';
import 'package:jewelleryapp/screens/viewfaq.dart';
import 'package:jewelleryapp/screens/viewfeedback.dart';
import 'package:jewelleryapp/screens/viewgallery.dart';
import 'package:jewelleryapp/screens/viewreview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your other screens here

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var username = "";
  var email;
var islogin;
  checkset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "";
      email = prefs.getString("useremail") ?? "";
      islogin = prefs.getString("islogin").toString();
      print("islogin = ${islogin}");
    });
  }

  @override
  void initState() {
    super.initState();
    checkset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: [
      //     Container(),
      //     Container(
      //       height: 250,
      //       width: MediaQuery.of(context).size.width,
      //
      //       decoration: BoxDecoration(
      //         color: Color(0xff546e7a),
      //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
      //       ),
      //       child: Column(
      //         children: [
      //           SizedBox(height: 50),
      //               Image.asset(
      //                 "img/logo1.png",
      //                 height: 90,
      //               ),
      //               SizedBox(height: 10),
      //               Align(
      //                 child: Column(
      //                   children: [
      //                     Text(
      //                       username ?? "",
      //                       style: TextStyle(fontSize: 25, color: Colors.black),
      //                     ),
      //                     Text(
      //                       email ?? "",
      //                       style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //         ],
      //       ),
      //     ),
      //
      //   ],
      // ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff546e7a),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.0),bottomLeft: Radius.circular(15.0))
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                // Image.asset(
                //   "img/logo1.png",
                //   height: 90,
                // ),
                Image.asset("img/logo2.png", fit: BoxFit.cover, color: Colors.white,height: 90,),
                SizedBox(height: 20),

                Align(
                  child: Column(
                    children: [
                      Text(
                        username ?? "",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        email ?? "",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: ListView(
              children: [
                // Your list items go here
                // Example:
                (islogin != "null")?SizedBox():Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 2,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text("Login"),
                    leading: Image.asset(
                      "img/profile1.png",
                      height: 50,
                      width: 40,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ),
                (islogin != "null")?Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 2,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text("My Profile"),
                    leading: Image.asset(
                      "img/profile1.png",
                      height: 50,
                      width: 40,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                  ),
                ):SizedBox(),
                (islogin != "null")?Container(
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
              title: Text("My Order"),
              leading: Image.asset("img/order.jpg",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>order()));
              },
            ),
          ):SizedBox(),
                (islogin != "null")? Container(
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
              title: Text("My Comment"),
              leading: Image.asset("img/comment.png",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewcomment()));
              },
            ),
          ):SizedBox(),
                (islogin != "null")? Container(
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
              title: Text("My Review"),
              leading: Image.asset("img/review.png",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewreview()));
              },
            ),
          ):SizedBox(),
                (islogin != "null")?Container(
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
              title: Text("Change Password"),
              leading: Image.asset("img/cp.png",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChangePassword()));
              },
            ),
          ):SizedBox(),
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
              title: Text("Articles"),
              leading: Image.asset("img/articles.png",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> articles()));
              },
            ),
          ),
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
              title: Text("My Feedback"),
              leading: Image.asset("img/feedback.jpg",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> viewfeedback()));
              },
            ),
          ),
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
              title: Text("Support"),
              leading: Image.asset("img/support.jpg",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> viewfaq()));
              },
            ),
          ),
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
              title: Text("Gallery"),
              leading: Image.asset("img/gallery.jpg",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> viewgallery()));
              },
            ),
          ),
                (islogin!="null")?Container(
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
              title: Text("Logout"),
              leading: Image.asset("img/logout1.png",height: 50,width: 40,),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              onTap: ()async {
                                SharedPreferences prefs = await SharedPreferences
                                    .getInstance();
                                prefs.clear();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
              },
            ),
          ):SizedBox(),
          SizedBox(height: 30,),


                // Add more list items here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
