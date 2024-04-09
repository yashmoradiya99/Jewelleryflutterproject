// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:jewelleryapp/resource/UrlResource.dart';
// import 'package:jewelleryapp/screens/LoginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController contact = TextEditingController();
//   var formkey = GlobalKey<FormState>();
//
//   // var uname;
//   // var uemail;
//   var uid;
//
//   checkpro() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       uid = prefs.getString("userid");
//       name.text = prefs.getString("username").toString();
//       email.text = prefs.getString("useremail").toString();
//       contact.text = prefs.getString("usercontact").toString();
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkpro();
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.blue,
//       //   title:Text("Register",textAlign: TextAlign.center,),
//       // ),
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
//               padding: const EdgeInsets.only(left: 70),
//               child: Text("PROFILE",style: TextStyle(color:Colors.white),),
//             ),
//
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.asset(
//               "img/logo.png",
//               height: 300,
//               width: 300,
//             ),
//             Container(
//               padding: EdgeInsets.all(30),
//               // margin: EdgeInsets.all(10),
//               child: Form(
//                 key: formkey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true),
//                       ],
//                       validator: (val){
//                         if(val!.length<=0)
//                         {
//                           return "Please Enter Name";
//                         }
//                         return null;
//                     },
//                       controller: name,
//                       keyboardType: TextInputType.name,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.supervised_user_circle_sharp),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Color(0xff546e7a)),
//                         ),
//                         hintText: "Enter Name",
//                         labelText: "Name",
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     TextFormField(
//                       validator: (val){
//                         if(val!.length<=0)
//                         {
//                           return "Please Enter Email";
//                         }
//                         else if(val == null || val.isEmpty || !val.contains('@') || !val.contains('.')){
//                           return 'Invalid Email';
//                         }
//                         return null;
//                       },
//                       controller: email,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color:Color(0xff546e7a)),
//                         ),
//                         hintText: "Enter Email",
//                         labelText: "Email",
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     TextFormField(
//                       maxLength: 10,
//                       validator: (val){
//                         if(val!.length<=0)
//                         {
//                           return "Please Enter MobileNo";
//                         }
//                         else if(val.length!=10)
//                         {
//                           return "Please Enter Valid no";
//                         }
//                         return null;
//                       },
//                       controller: contact,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.numbers),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color:Color(0xff546e7a)),
//                         ),
//                         hintText: "Enter MobileNo:",
//                         labelText: "Mobile No:",
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     ElevatedButton(
//                         onPressed: () async {
//                           if(formkey.currentState!.validate()){
//                             var name1 = name.text.toString();
//                             var email1 = email.text.toString();
//                             var contact1 = contact.text.toString();
//                             print(name1);
//                             print(email1);
//                             print(contact1);
//                             Uri uri = Uri.parse(UrlResource.CHANGEPROF);
//                             var responce = await http.post(uri, body: {
//                               "uid": uid,
//                               "username": name1,
//                               "email": email1,
//                               "contact": contact1,
//                             });
//                             if (responce.statusCode == 200) {
//                               var body = responce.body.toString();
//                               print(body);
//
//                               var json = jsonDecode(body);
//                               if (json["status"] == "true") {
//
//                                 print("object");
//                                 var msg = json["message"].toString();
//                                 print(msg);
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => LoginScreen()));
//
//                               } else {
//                                 print("object11");
//                                 var msg = json["message"].toString();
//                                 print(msg);
//                               }
//                             } else {
//                               print("error");
//                             }
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: Color(0xff546e7a),
//                           onPrimary: Colors.white,
//                           minimumSize: Size(200, 50),
//                         ),
//                         child: Text("Edit Profile")),
//                     SizedBox(
//                       height: 15,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'LoginScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var uid;
var islogin;
  checkpro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
      name.text = prefs.getString("username").toString();
      email.text = prefs.getString("useremail").toString();
      contact.text = prefs.getString("usercontact").toString();

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpro();
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
              padding: const EdgeInsets.only(left: 80),
              child: Text("PROFILE",style: TextStyle(color:Colors.white),),
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
                            .height / 1.8,
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
                                "Edit Profile",
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
                                inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true),
                                                ],
                                                validator: (val){
                          if(val!.length<=0)
                          {
                            return "Please Enter Name";
                          }
                          return null;
                                              },
                                controller: name,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                maxLength: 10,
                                validator: (val){
                                  if(val!.length<=0)
                                  {
                                    return "Please Enter MobileNo";
                                  }
                                  else if(val.length!=10)
                                  {
                                    return "Please Enter Valid no";
                                  }
                                  return null;
                                },
                                controller: contact,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: "Phone",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone_outlined,
                                    color: Colors.black,
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
                            return "Please Enter Email";
                          }
                          else if(val == null || val.isEmpty || !val.contains('@') || !val.contains('.')){
                            return 'Invalid Email';
                          }
                          return null;
                                                },
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const  SizedBox(
                                height: 50.0,
                              ),
                          ElevatedButton(
                          onPressed: () async {
                            if(formkey.currentState!.validate()){
                              var name1 = name.text.toString();
                              var email1 = email.text.toString();
                              var contact1 = contact.text.toString();
                              print(name1);
                              print(email1);
                              print(contact1);
                              Uri uri = Uri.parse(UrlResource.CHANGEPROF);
                              var responce = await http.post(uri, body: {
                                "uid": uid,
                                "username": name1,
                                "email": email1,
                                "contact": contact1,
                              });
                              if (responce.statusCode == 200) {
                                var body = responce.body.toString();
                                print(body);
                          
                                var json = jsonDecode(body);
                                if (json["status"] == "true") {
                          
                                  print("object");
                                  var msg = json["message"].toString();
                                  print(msg);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                          
                                } else {
                                  print("object11");
                                  var msg = json["message"].toString();
                                  print(msg);
                                }
                              } else {
                                print("error");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff546e7a),
                            onPrimary: Colors.white,
                            minimumSize: Size(200, 50),
                          ),
                          child: Text("Edit Profile")),
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
