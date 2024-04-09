import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool isvisable = true;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xff546e7a),
        title:Center(child: Text("Register",style:TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
      ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Image.asset("img/logo.png",height: 200, width: 300,),
//             SizedBox(height: 80,),
//             Container(
//               padding: EdgeInsets.all(30),
//               // margin: EdgeInsets.all(10),
//               child: Form(
//                 key: formkey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: name,
//                       keyboardType: TextInputType.name,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true),
//                       ],
//                       validator: (val)
//                       {
//                         if(val!.length<=0)
//                           {
//                             return "Please Enter Name";
//                           }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.supervised_user_circle_sharp),
//                         border: OutlineInputBorder(
//
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
//
//                       ),
//                     ),
//
//                     SizedBox(height: 30,),
//                     TextFormField(
//                       validator: (val){
//                         if(val!.length<=0){
//                           return"Please Enter Emial";
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
//
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
//
//                       ),
//                     ),
//                     SizedBox(height: 30,),
//                     TextFormField(
//                       controller: number,
//                       keyboardType: TextInputType.number,
//                       maxLength: 10,
//
//                       validator: (val)
//                       {
//                         if(val!.length<=0)
//                         {
//                           return "Please Enter No";
//                         }
//                         else if(val.length!=10)
//                           {
//                             return "Please Enter Valid no";
//                           }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.numbers),
//                         border: OutlineInputBorder(
//
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
//                         hintText: "Enter MobileNo:",
//                         labelText: "Mobile No:",
//                         labelStyle: TextStyle(color: Colors.black),
//
//                       ),
//                     ),
//                     SizedBox(height: 30,),
//                     TextFormField(
//                       validator: (val){
//                         if(val!.length<=0){
//                           return "Please Enter Password";
//                         }
//                         else
//                         if (val.length < 8) {
//                         return 'Must be more than 8 charater';
//                         }
//                         // if (!regex.hasMatch(val)) {
//                         //   return 'Enter valid password';
//                         // }
//                         return null;
//                       },
//                       controller: password,
//                       keyboardType: TextInputType.text,
//                       obscureText: isvisable,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.password),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               isvisable = !isvisable!;
//                             });
//                           },
//                           icon: (isvisable)?Icon(Icons.visibility_off):Icon(Icons.remove_red_eye),
//                         ),
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
//                         hintText: "Enter Password",
//                         labelText: "Password",
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                     SizedBox(height: 30,),
//                     ElevatedButton(onPressed: ()async{
//
// if(formkey.currentState!.validate())
//   {
//     var nm=name.text.toString();
//     var em=email.text.toString();
//     var num=number.text.toString();
//     var pas=password.text.toString();
//     print(nm);
//     print(em);
//     print(num);
//     print(pas);
//
//     Uri uri = Uri.parse(UrlResource.REGISTER);
//     var responce = await http.post(uri,body: {
//       "name":nm,
//       "contact":num,
//       "email":em,
//       "password":pas
//     });
//     if(responce.statusCode==200)
//     {
//       var body = responce.body.toString();
//       print(body);
//       var json = jsonDecode(body);
//       print("test");
//       if(json["status"]=="true")
//       {
//         var msg = json["message"].toString();
//         print(msg);
//         Fluttertoast.showToast(
//             msg: msg,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context)=>LoginScreen())
//         );
//       }
//       else
//       {
//         print("demo");
//         var msg = json["message"].toString();
//         print(msg);
//       }
//     }
//     else
//     {
//       print("error");
//     }
//   }
//
//
//                     //   200 ok
//                       //400 not found
//                       //500 server
//
//
//
//
//
//
//                     },
//                         style: ElevatedButton.styleFrom(
//                             primary: Color(0xff546e7a),
//                             onPrimary: Colors.white,
//                           minimumSize: Size(200, 50),
//                         ),
//
//                         child: Text("Sign Up")),
//                     SizedBox(height: 15,),
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Already have an account? "),
//                           InkWell(
//                             onTap: (){
//                               // Navigator.of(context).pop();
//                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                               // print("object");
//
//                             },
//                             onDoubleTap: (){},
//
//                             child: Text("Sign In",style: TextStyle(color:Color(0xff546e7a),fontSize: 20,fontWeight: FontWeight.bold),),
//                           ),
//
//                         ],
//                       ),
//
//                   ],
//
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
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
                        height:590,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true),
                      ],
                      validator: (val)
                      {
                        if(val!.length<=0)
                          {
                            return "Please Enter Name";
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervised_user_circle_sharp),
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
                        hintText: "Enter Name",
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),

                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (val){
                        if(val!.length<=0){
                          return"Please Enter Emial";
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
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: number,
                      keyboardType: TextInputType.number,
                      maxLength: 10,

                      validator: (val)
                      {
                        if(val!.length<=0)
                        {
                          return "Please Enter No";
                        }
                        else if(val.length!=10)
                          {
                            return "Please Enter Valid no";
                          }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
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
                        hintText: "Enter MobileNo:",
                        labelText: "Mobile No:",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),
                    SizedBox(height: 30,),
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
                        //   return 'Enter valid password';
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
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: ()async{

if(formkey.currentState!.validate())
  {
    var nm=name.text.toString();
    var em=email.text.toString();
    var num=number.text.toString();
    var pas=password.text.toString();
    print(nm);
    print(em);
    print(num);
    print(pas);

    Uri uri = Uri.parse(UrlResource.REGISTER);
    var responce = await http.post(uri,body: {
      "name":nm,
      "contact":num,
      "email":em,
      "password":pas
    });
    if(responce.statusCode==200)
    {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      print("test");
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>LoginScreen())
        );
      }
      else
      {
        print("demo");
        var msg = json["message"].toString();
        print(msg);
      }
    }
    else
    {
      print("error");
    }
  }


                    //   200 ok
                      //400 not found
                      //500 server






                    },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff546e7a),
                            onPrimary: Colors.white,
                          minimumSize: Size(200, 50),
                        ),

                        child: Text("Sign Up")),
                    SizedBox(height: 15,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          InkWell(
                            onTap: (){
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                              // print("object");

                            },
                            onDoubleTap: (){},

                            child: Text("Sign In",style: TextStyle(color:Color(0xff546e7a),fontSize: 20,fontWeight: FontWeight.bold),),
                          ),

                        ],
                      ),
                          ],
                      ),
                    ),
                      )
                    )
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
