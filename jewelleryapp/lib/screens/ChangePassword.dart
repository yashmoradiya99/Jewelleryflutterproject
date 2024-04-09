// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:jewelleryapp/resource/UrlResource.dart';
// import 'package:jewelleryapp/screens/LoginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ChangePassword extends StatefulWidget {
//   const ChangePassword({super.key});
//
//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }
//
// class _ChangePasswordState extends State<ChangePassword> {
//   TextEditingController oldpas=TextEditingController();
//   TextEditingController newpas=TextEditingController();
//   TextEditingController conpas=TextEditingController();
//   RegExp regex =
//   RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   var formkey = GlobalKey<FormState>();
//   bool isvisable=true;
//   bool isvisable1=true;
//   bool isvisable2=true;
//   var uid;
//   checkUid() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       uid = prefs.getString("userid");
//     });
//    // return uid != null;
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkUid();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(55),
//         child: Container(
//           decoration: BoxDecoration(
//             color:Color(0xff546e7a) ,
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(24),
//               bottomLeft: Radius.circular(24),
//             ),
//           ),
//           child: AppBar(
//             iconTheme: IconThemeData(
//               color: Colors.white, //change your color here
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title:
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Text("CHANGE PASSWORD",style: TextStyle(color:Colors.white),),
//             ),
//
//           ),
//         ),
//       ),
//       body:SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.all(10),
//             child: Form(
//               key: formkey,
//               child: Column(
//                 children: [
//                   Image.asset("img/logo.png"),
//                   TextFormField(
//                     validator: (val){
//                       if(val!.length<=0)
//                       {
//                         return "Please Enter OldPassword";
//                       }
//                       else
//                       if (!regex.hasMatch(val)) {
//                         return 'Enter valid password';
//                       }
//                       return null;
//                     },
//                     controller: oldpas,
//                         keyboardType: TextInputType.text,
//                         obscureText: isvisable,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.password),
//                           suffixIcon: IconButton(
//                               onPressed: (
//                                   ){
//                                 setState(() {
//                                   isvisable=!isvisable!;
//                                 });
//                               },
//                               icon: (isvisable)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye)
//                           ),
//                           border: OutlineInputBorder(
//
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Color(0xff546e7a)),
//                           ),
//                           hintText: "Enter Old Password",
//                           labelText: "Old Password",
//                           labelStyle: TextStyle(color: Colors.black),
//
//                         ),
//                       ),
//                   SizedBox(height: 30,),
//                   TextFormField(
//                     validator: (val){
//                       if(val!.length<=0)
//                       {
//                         return "Please Enter Password";
//                       }
//                       else
//                       if (!regex.hasMatch(val)) {
//                         return 'Enter valid password';
//                       }
//                       return null;
//                     },
//                     controller: newpas,
//                     keyboardType: TextInputType.text,
//                     obscureText: isvisable1,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.password),
//                       suffixIcon: IconButton(
//                         onPressed: (
//                             ){
//                           setState(() {
//                             isvisable1=!isvisable1!;
//                           });
//                         },
//                         icon: (isvisable1)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye)
//                       ),
//                       border: OutlineInputBorder(
//
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
//                       hintText: "Enter New Password",
//                       labelText: "New Password",
//                       labelStyle: TextStyle(color: Colors.black),
//
//                     ),
//                   ),
//                   SizedBox(height: 30,),
//                   TextFormField(
//                     validator: (val){
//                       if(val!.length<=0)
//                       {
//                         return "Please Enter ConformPassword";
//                       }
//                       else if(newpas.text != conpas.text){
//                         return "newpassword nd confirm password must be same";
//                       }
//                       return null;
//                     },
//
//                     controller: conpas,
//                     keyboardType: TextInputType.text,
//                     obscureText: isvisable2,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.password),
//                       suffixIcon: IconButton(
//                         onPressed: (){
//                           setState(() {
//                             isvisable2=!isvisable2!;
//                           });
//                         },
//                         icon: (isvisable2)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye),
//                       ),
//                       border: OutlineInputBorder(
//
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
//                       hintText: "Conform Enter Password",
//                       labelText: "Conform Password",
//                       labelStyle: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   SizedBox(height: 30,),
//                   ElevatedButton(onPressed: ()async{
//                    if(formkey.currentState!.validate()){
//                      var old=oldpas.text.toString();
//                      var newp=newpas.text.toString();
//                      var con=conpas.text.toString();
//                      print(old);
//                      print(newp);
//                      print(con);
//                      Uri uri =Uri.parse(UrlResource.CHANGEPASS);
//                      var responce= await http.post(uri,body: {
//                        "old":old,
//                        "new":newp,
//                        "uid":uid,
//                        // "conform":conpas,
//                      });
//                      if(responce.statusCode==200){
//                        var body=responce.body.toString();
//                        print(body);
//
//                        var json = jsonDecode(body.toString());
//                        print("json = ${json}");
//                        if(json["status"]=="true")
//                        {
//
//                          var msg = json["message"].toString();
//                          print(msg);
//                          Fluttertoast.showToast(
//                              msg: msg,
//                              toastLength: Toast.LENGTH_SHORT,
//                              gravity: ToastGravity.CENTER,
//                              timeInSecForIosWeb: 1,
//                              backgroundColor: Colors.red,
//                              textColor: Colors.white,
//                              fontSize: 16.0);
//
//                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                        }
//                        else
//                        {
//                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                          var msg = json["message"].toString();
//                          print(msg);
//                        }
//                      }
//                      else
//                      {
//                        print("error");
//                      }
//                    }
//                   },
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xff546e7a),
//                         onPrimary: Colors.white,
//                         minimumSize: Size(200, 50),
//                       ),
//                       child: Text("Submit")),
//                 ],
//                       ),
//             ),
//           ),
//       ),
//     );
//   }
// }


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../resource/UrlResource.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpas=TextEditingController();
  TextEditingController newpas=TextEditingController();
  TextEditingController conpas=TextEditingController();
  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  var formkey = GlobalKey<FormState>();
  bool isvisable=true;
  bool isvisable1=true;
  bool isvisable2=true;
  var uid;
  checkUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });
   // return uid != null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUid();
  }


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
              padding: const EdgeInsets.only(left: 40),
              child: Text("Change Password",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
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
                      const SizedBox(height: 50.0),
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
                              .height / 1.6,
                          decoration:
                          BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              const  SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Reset Password",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color:  Color(0xff546e7a),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                            validator: (val){
                      if(val!.length<=0)
                      {
                        return "Please Enter OldPassword";
                      }
                      if (val.length < 8) {
                        return 'Must be more than 8 charater';
                      }
                      return null;
                    },
                                controller: oldpas,
                                obscureText: isvisable,
                                decoration: InputDecoration(
                                  hintText: "Old Password",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.password_sharp,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisable = !isvisable;
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    child:  Icon(
                                      isvisable
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                            validator: (val){
                      if(val!.length<=0)
                      {
                        return "Please Enter Password";
                      }
                      if (val.length < 8) {
                        return 'Must be more than 8 charater';
                      }
                      return null;
                    },
                                controller: newpas,
                                obscureText: isvisable1,
                                decoration: InputDecoration(
                                  hintText: "New Password",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.password_sharp,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisable1 = !isvisable1;
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    child:  Icon(
                                      isvisable1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                            validator: (val){
                      if(val!.length<=0)
                      {
                        return "Please Enter ConformPassword";
                      }
                      else if(newpas.text != conpas.text){
                        return "newpassword nd confirm password must be same";
                      }
                      return null;
                    },
                                controller: conpas,
                                obscureText: isvisable2,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.password_sharp,
                                    color: Colors.black,
                                  ),

                                  suffixIcon: CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisable2 = !isvisable2;
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    child:  Icon(
                                      isvisable2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const  SizedBox(
                                height: 50.0,
                              ),
                ElevatedButton(onPressed: ()async{
                   if(formkey.currentState!.validate()){
                     var old=oldpas.text.toString();
                     var newp=newpas.text.toString();
                     var con=conpas.text.toString();
                     print(old);
                     print(newp);
                     print(con);
                     Uri uri =Uri.parse(UrlResource.CHANGEPASS);
                     var responce= await http.post(uri,body: {
                       "old":old,
                       "new":newp,
                       "uid":uid,
                       // "conform":conpas,
                     });
                     if(responce.statusCode==200){
                       var body=responce.body.toString();
                       print(body);

                       var json = jsonDecode(body.toString());
                       print("json = ${json}");
                       if(json["status"]=="true")
                       {

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

                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                       }
                       else
                       {
                       //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                         var msg = json["message"].toString();
                         print(msg);
                       }
                     }
                     else
                     {
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}