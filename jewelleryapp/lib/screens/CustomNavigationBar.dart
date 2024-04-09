import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jewelleryapp/screens/HomeScreen.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:jewelleryapp/screens/Setting.dart';
import 'package:jewelleryapp/screens/cart.dart';
import 'package:jewelleryapp/screens/details.dart';
import 'package:jewelleryapp/screens/shop.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  var select = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body:(select==0)?HomeScreen():(select==1)?shop():(select==2)?cart():Setting(),

      bottomNavigationBar: CurvedNavigationBar(

        color: Color(0xff546e7a),
        // buttonBackgroundColor: Colors.purple,
        backgroundColor: Colors.transparent,
        height: 60,
        onTap: (val){
          setState(() {
            select = val;

          });
        },
        // items:items,
        items: <Widget>[
          Container(
            height: 50,
            child: Column(
              children: [Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Icon(Icons.home,color: Colors.white, size: 25),
              ),],
            ),
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [Icon(Icons.shop,color: Colors.white, size: 25),],
              ),
            ),
          ),

          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [Icon(Icons.add_shopping_cart,color: Colors.white, size: 25),],
              ),
            ),
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [Icon(Icons.settings,color: Colors.white, size: 25),],
              ),
            ),
          ),

        ],
        ),
    );
  }
}
