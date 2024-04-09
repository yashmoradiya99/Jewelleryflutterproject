import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/viewfeedback.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController feedback = TextEditingController();
  var formkey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.only(left: 40),
              child: Text("APP FEEDBACK",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Center(child: Text("FeedBack",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)),
            SizedBox(height: 50,),
            Container(
              padding: EdgeInsets.all(30),
              // margin: EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
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
                          return"Please Enter Email";
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
                          borderSide: BorderSide(color: Color(0xff546e7a)),
                        ),
                        hintText: "Enter Email",
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: contact,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
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
                          return "Please Enter Feedback";
                        }
                        return null;
                      },
                      maxLines: 3,
                      controller: feedback,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.feed),
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
                        hintText: "Enter Feedback",
                        labelText: "Feedback",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: ()async{

                      if(formkey.currentState!.validate())
                      {
                        var nm=name.text.toString();
                        var em=email.text.toString();
                        var con=contact.text.toString();
                        var feed=feedback.text.toString();
                        print(nm);
                        print(em);
                        print(con);
                        print(feed);

                        Uri uri = Uri.parse(UrlResource.FEEDBACK);
                        var responce = await http.post(uri,body: {
                          "name":nm,
                          "email":em,
                          "contact":con,
                          "feedback":feed,
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
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>viewfeedback())
                            );
                            Fluttertoast.showToast(
                                msg: msg,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

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

                        child: Text("Submit")),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
