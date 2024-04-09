import 'package:flutter/material.dart';

class checkoutnavigation extends StatefulWidget {
  const checkoutnavigation({super.key});

  @override
  State<checkoutnavigation> createState() => _checkoutnavigationState();
}

class _checkoutnavigationState extends State<checkoutnavigation>

{
  var select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("custom navigation"),
      ),
      body: Stack(
        children: [
          Container
            (
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfffff8e1),
          ),
          Positioned(
            bottom: 10,
              right: 10,
              left: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(15)
                ),
    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Text("CHECK OUT",style: TextStyle(fontSize: 15,color: Colors.white),),
                IconButton(onPressed: () {
                  setState(() {
                    select = 0;
                  });
                }, icon: Icon(Icons.home,color: Colors.white,))
              ],
            ),

              ))
        ],
      ),
    );
  }
}
