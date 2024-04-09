import 'package:flutter/material.dart';
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/HomeScreen.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:jewelleryapp/screens/bil.dart';

class paymentsucess extends StatelessWidget {
  var oid;
   paymentsucess({super.key,this.oid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: Image.asset("img/p2.png")),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              width: 300,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                      radius: 40,
                      child: Icon(Icons.check,size: 60,color: Colors.white,)),
                  SizedBox(height: 10,),
                  Text("payment Successfull!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("You will redirected to the home page shortly or click here to return to home page",style: TextStyle(fontSize: 18,color: Colors.blue.shade500),),
                  ),
                  SizedBox(height: 35,),
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomNavigationBar()));
                      },style:ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.blue,
                        minimumSize: Size(50,50),
                      ), child: Text("Back to home")),
                      SizedBox(width: 10,),
                      Container(
                        width: 140,
                        child: ElevatedButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>bil(oid: oid,)));
                        },style:ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.blue,
                          minimumSize: Size(50,50),
                        ), child: Text("Show Bil")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
