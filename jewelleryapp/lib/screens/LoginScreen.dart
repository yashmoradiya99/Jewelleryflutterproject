import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/ForgetPassword.dart';
import 'package:jewelleryapp/screens/RegisterScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool isvisable = true;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue,
    //   ),
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(90.0),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color:Color(0xff546e7a) ,
    //         borderRadius: const BorderRadius.only(
    //           bottomRight: Radius.circular(24),
    //           bottomLeft: Radius.circular(24),
    //         ),
    //       ),
    //       child: AppBar(
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.all(15.0),
    //       child: Form(
    //         key: formkey,
    //         child: Container(
    //           // height: 800,
    //           width: MediaQuery.of(context).size.width,
    //           child: Column(
    //             children: [
    //               SizedBox(height: 50,),
    //               Image.asset(
    //                 "img/logo.png",
    //                 height: 300,
    //               ),
    //               Column(
    //                 children: [
    //                   TextFormField(
    //                     validator: (val){
    //                       if(val!.length<=0){
    //                         return "Please Enter Email";
    //                       }
    //                       else if(val == null || val.isEmpty || !val.contains('@') || !val.contains('.')){
    //                         return 'Invalid Email';
    //                       }
    //                       return null;
    //                     },
    //                     controller: email,
    //                     keyboardType: TextInputType.emailAddress,
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(Icons.email),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color:Color(0xff546e7a)),
    //                       ),
    //                       hintText: "Enter Email",
    //                       labelText: "Email",
    //                       labelStyle: TextStyle(color: Colors.black),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   TextFormField(
    //                     validator: (val){
    //                       if(val!.length<=0){
    //                         return "Please Enter Password";
    //                       }
    //                       else
    //                       if (val.length < 8) {
    //                         return 'Must be more than 8 charater';
    //                       }
    //                           // if (!regex.hasMatch(val)) {
    //                           // return 'Enter valid password';
    //                           // }
    //                       return null;
    //                     },
    //                     controller: password,
    //                     keyboardType: TextInputType.text,
    //                     obscureText: isvisable,
    //                     decoration: InputDecoration(
    //                       prefixIcon: Icon(Icons.password),
    //                       suffixIcon: IconButton(
    //                         onPressed: () {
    //                           setState(() {
    //                             isvisable = !isvisable!;
    //                           });
    //                         },
    //                         icon: (isvisable)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color: Colors.black),
    //                       ),
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                         borderSide: BorderSide(color: Color(0xff546e7a)),
    //                       ),
    //                       hintText: "Enter Password",
    //                       labelText: "Password",
    //                       labelStyle: TextStyle(color: Colors.black),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   Align(
    //                     alignment: Alignment.centerRight,
    //                     child:
    //                         // Text("forgot password",textAlign: TextAlign.end,)
    //                         InkWell(
    //                       onTap: () {
    //                         // Navigator.of(context).push(
    //                         //     MaterialPageRoute(builder: (context)=>RegisterScreen())
    //                         // );
    //                         Navigator.of(context).push(MaterialPageRoute(
    //                             builder: (context) => ForgetPassword()));
    //                         // print("object");
    //                       },
    //                       onDoubleTap: () {},
    //                       child: Text(
    //                         "forgot password",
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   ElevatedButton(
    //                       onPressed: () async {
    //                        if(formkey.currentState!.validate()){
    //                          var em = email.text.toString();
    //                          var pas = password.text.toString();
    //                          print(em);
    //                          print(pas);
    //
    //                          Uri uri = Uri.parse(UrlResource.LOGIN);
    //                          print(uri);
    //                          var responce = await http.post(uri, body: {"email": em, "password": pas});
    //                          if (responce.statusCode == 200) {
    //                            var body = responce.body.toString();
    //                            print(body);
    //                            var json = jsonDecode(body);
    //                            if (json["status"] == "true") {
    //                              var msg = json["message"].toString();
    //                              print(msg);
    //                              print(json["data"]);
    //                              var userid = json["data"]["user_id"].toString();
    //                              var username = json["data"]["name"].toString();
    //                              var usercontact = json["data"]["contact"].toString();
    //                              var useremail = json["data"]["email"].toString();
    //
    //
    //                              print(userid);
    //                              print(username);
    //                              print(usercontact);
    //                              print(useremail);
    //
    //                              SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    //                              prefs.setString("userid", userid);
    //                              prefs.setString("username", username).toString();
    //                              prefs.setString("usercontact", usercontact).toString();
    //                              prefs.setString("useremail", useremail).toString();
    //                              prefs.setString("islogin", "yes").toString();
    //
    //                              var log = prefs.getString("islogin").toString();
    //                              print("login demo = ${log}");
    //
    //                              var uid = prefs.getString("userid").toString();
    //                              print("userid demo = ${uid}");
    //                              var login = prefs.getString("islogin").toString();
    //                              print("login demo = ${login}");
    //                              Navigator.of(context).pushAndRemoveUntil(
    //                                MaterialPageRoute(builder: (context) => CustomNavigationBar()),
    //                                    (Route<dynamic> route) => false,
    //                              );
    //                            } else {
    //                              var msg = json["message"].toString();
    //                              print(msg);
    //                              Fluttertoast.showToast(
    //                                  msg: msg,
    //                                  toastLength: Toast.LENGTH_SHORT,
    //                                  gravity: ToastGravity.CENTER,
    //                                  timeInSecForIosWeb: 1,
    //                                  backgroundColor: Colors.red,
    //                                  textColor: Colors.white,
    //                                  fontSize: 16.0);
    //                            }
    //                          } else {
    //                            print("error");
    //                            Fluttertoast.showToast(
    //                                msg: "Error!",
    //                                toastLength: Toast.LENGTH_SHORT,
    //                                gravity: ToastGravity.CENTER,
    //                                timeInSecForIosWeb: 1,
    //                                backgroundColor: Colors.red,
    //                                textColor: Colors.white,
    //                                fontSize: 16.0);
    //                          }
    //                        }
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                         primary: Color(0xff546e7a),
    //                         onPrimary: Colors.white,
    //                         minimumSize: Size(200, 50),
    //                       ),
    //                       child: Text("Sign In")),
    //                   SizedBox(
    //                     height: 10,
    //                   ),
    //                   Text(
    //                     "or",
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(fontSize: 15),
    //                   ),
    //                   SizedBox(
    //                     height: 10,
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Text("Don't have an account? "),
    //                       InkWell(
    //                         onTap: () {
    //                           // Navigator.of(context).push(MaterialPageRoute(
    //                           //     builder: (context) => RegisterScreen()));
    //                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    //                               builder: (context) => RegisterScreen()), (Route route) => false);
    //                           // print("object");
    //                         },
    //                         onDoubleTap: () {},
    //                         child: Text(
    //                           "Sign Up",
    //                           style: TextStyle(color: Color(0xff546e7a), fontSize: 20,fontWeight: FontWeight.bold),
    //                         ),
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
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
                      .height,
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
                margin: EdgeInsets.only(top:250),
                height: 590,
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
                        height: 590,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                         child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff546e7a),
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    TextFormField(
                                      validator: (val){
                                        if(val!.length<=0){
                                          return "Please Enter Email";
                                        }
                                        else if(val == null || val.isEmpty || !val.contains('@') || !val.contains('.')){
                                          return 'Invalid Email';
                                        }
                                        return null;
                                      },
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
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
                                          borderSide: BorderSide(color:Color(0xff546e7a)),
                                        ),
                                        hintText: "Enter Email",
                                        labelText: "Email",
                                        labelStyle: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      validator: (val){
                                        if(val!.length<=0){
                                          return "Please Enter Password";
                                        }
                                        else
                                        if (val.length < 8) {
                                          return 'Must be more than 8 charater';
                                        }
                                            // if (!regex.hasMatch(val)) {
                                            // return 'Enter valid password';
                                            // }
                                        return null;
                                      },
                                      controller: password,
                                      keyboardType: TextInputType.text,
                                      obscureText: isvisable,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.password),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isvisable = !isvisable!;
                                            });
                                          },
                                          icon: (isvisable)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye),
                                        ),
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
                                        hintText: "Enter Password",
                                        labelText: "Password",
                                        labelStyle: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:
                                          // Text("forgot password",textAlign: TextAlign.end,)
                                          InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(builder: (context)=>RegisterScreen())
                                          // );
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ForgetPassword()));
                                          // print("object");
                                        },
                                        onDoubleTap: () {},
                                        child: Text(
                                          "forgot password",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                         if(formkey.currentState!.validate()){
                                           var em = email.text.toString();
                                           var pas = password.text.toString();
                                           print(em);
                                           print(pas);
        
                                           Uri uri = Uri.parse(UrlResource.LOGIN);
                                           print(uri);
                                           var responce = await http.post(uri, body: {"email": em, "password": pas});
                                           if (responce.statusCode == 200) {
                                             var body = responce.body.toString();
                                             print(body);
                                             var json = jsonDecode(body);
                                             if (json["status"] == "true") {
                                               var msg = json["message"].toString();
                                               print(msg);
                                               print(json["data"]);
                                               var userid = json["data"]["user_id"].toString();
                                               var username = json["data"]["name"].toString();
                                               var usercontact = json["data"]["contact"].toString();
                                               var useremail = json["data"]["email"].toString();
        
        
                                               print(userid);
                                               print(username);
                                               print(usercontact);
                                               print(useremail);
        
                                               SharedPreferences prefs = await SharedPreferences.getInstance();
        
                                               prefs.setString("userid", userid);
                                               prefs.setString("username", username).toString();
                                               prefs.setString("usercontact", usercontact).toString();
                                               prefs.setString("useremail", useremail).toString();
                                               prefs.setString("islogin", "yes").toString();
        
                                               var log = prefs.getString("islogin").toString();
                                               print("login demo = ${log}");
        
                                               var uid = prefs.getString("userid").toString();
                                               print("userid demo = ${uid}");
                                               var login = prefs.getString("islogin").toString();
                                               print("login demo = ${login}");
                                               Navigator.of(context).pushAndRemoveUntil(
                                                 MaterialPageRoute(builder: (context) => CustomNavigationBar()),
                                                     (Route<dynamic> route) => false,
                                               );
                                             } else {
                                               var msg = json["message"].toString();
                                               print(msg);
                                               Fluttertoast.showToast(
                                                   msg: msg,
                                                   toastLength: Toast.LENGTH_SHORT,
                                                   gravity: ToastGravity.CENTER,
                                                   timeInSecForIosWeb: 1,
                                                   backgroundColor: Colors.red,
                                                   textColor: Colors.white,
                                                   fontSize: 16.0);
                                             }
                                           } else {
                                             print("error");
                                             Fluttertoast.showToast(
                                                 msg: "Error!",
                                                 toastLength: Toast.LENGTH_SHORT,
                                                 gravity: ToastGravity.CENTER,
                                                 timeInSecForIosWeb: 1,
                                                 backgroundColor: Colors.red,
                                                 textColor: Colors.white,
                                                 fontSize: 16.0);
                                           }
                                         }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff546e7a),
                                          onPrimary: Colors.white,
                                          minimumSize: Size(200, 50),
                                        ),
                                        child: Text("Sign In")),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "or",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Don't have an account? "),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) => RegisterScreen()));
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                builder: (context) => RegisterScreen()), (Route route) => false);
                                            // print("object");
                                          },
                                          onDoubleTap: () {},
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(color: Color(0xff546e7a), fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                builder: (context) => CustomNavigationBar()), (Route route) => false);
                                            // Handle button tap
                                            print('Button tapped');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            onPrimary: Colors.white,
                                            primary: Color(0xff546e7a),
                                          ),
                                          child: Text(
                                            'Skip',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                    ),
                ),
              ),
                          ],
                        ),
                      ),
            ]  ),
            ),
      )
    );
  }
}
