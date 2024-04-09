import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/placeorder.dart';
import 'package:jewelleryapp/screens/checkoutnavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';

class cart extends StatefulWidget {

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  var imgurl = UrlResource.jwlimg;
  var uid;

  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });
    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWCART);
    print(uri);
    var responce = await http.post(uri, body: {
      "user_id": uid,
    });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      return json["data"];
    } else {
      print("error");
    }
  }

  var finalamount = 0.0;
  var pid;
  Future<List<dynamic>?>? alldata3;
  List cartdata = [];

  Future<List<dynamic>?>? getcartdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("object = ${uid}");
    Uri uri = Uri.parse(UrlResource.CART);
    print(uri);
    var responce = await http.post(uri, body: {
      "user_id": uid,
    });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      print("data");
      // print("json = ${json["data"]}");
      return json["data"];
    } else {
      print("error");
    }
  }

var totalcart = 0;
  var totalprice = 0;
  var fnprice = 0;
  gettotal() async {
print("123");
      alldata3 = getcartdata();
      alldata3?.then((data) {
        finalamount = 0.0; // Reset finalamount before recalculating
        print("object1111");
        data?.forEach((row) {
          print("test");
         setState(() {
           finalamount += (double.parse(row["qty"].toString()) *
               double.parse(row["price"].toString()));

           print("uuid = ${uid}");
           print("uuid = ${row["user_id"].toString()}");

           fnprice += int.parse(row["price"].toString());

           if(row["user_id"]==uid)
             {
               totalcart = totalcart + 1;
               print("totalcart = ${totalcart}");
               print("yes data");
             }
           else
             {
               print("no data");
             }

         });

          pid = row["jewellery_id"].toString();
          print("amount : " + row["price"].toString());
          print("qty : " + row["qty"].toString());
          print("final amount : " + fnprice.toString());
        });
      });

  }
  getftotal() async {
    print("123");
    alldata3 = getcartdata();
    alldata3?.then((data) {

      data?.forEach((row) {
        print("test");
        setState(() {

          if(row["user_id"]==uid)
          {
            totalcart = totalcart + 1;
            print("totalcart = ${totalcart}");
            print("yes data");
          }
          else
          {
            print("no data");
          }

        });


      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
      alldata3 = getcartdata();
      gettotal();
    });
  }
// Function to update alldata
  void updateData() {
    setState(() {
      alldata = getdata();
      alldata!.then((_) {
        print("objectdemo");
        // gettotal();
        getftotal();
      });
       // Update the total when an item is deleted
    });
  }
  var select = 0;
  var qty = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff546e7a),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, color: Colors.white),
            //   onPressed: () => Navigator.of(context).push(),
            // ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:
            Center(child: Text(
              "CART PAGE", style: TextStyle(color: Colors.white),)),

          ),
        ),
      ),
        body: Builder(
        builder: (context) {
          return FutureBuilder(
            future: alldata,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display loading indicator while data is being fetched
              } else if (snapshot.hasError) {
                return  Center(
                  child: Image.asset('img/empty.jpg'),
                );
              } else {
                // Once data is fetched, display it using createCartList
                return ListView(
                  children: <Widget>[
                    createHeader(),
                    createSubTitle(),
                    createCartList(snapshot.data), // Pass fetched data here
                    footer(context)
                  ],
                );
              }
            },
          );
        }
    ),
    );
  }
  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "${fnprice}",
                  style: TextStyle(
                      color: Colors.blue.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => placeorder(price: fnprice,)));
            }, style: ElevatedButton.styleFrom(primary: Colors.blue, padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),),
            // color: Colors.green,
            // padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text("CheckOut",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total($totalcart) Items",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList(dynamic data) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        // Pass individual data to createCartListItem
        return createCartListItem(data[position]);
      },
      // Use the length of the fetched data
      itemCount: data.length,
    );
  }

  createCartListItem(dynamic value) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  color: Colors.blue.shade200,
                  image: DecorationImage(
                    image: NetworkImage(UrlResource.jwlimg + value["img1"].toString()),
                    fit: BoxFit.cover, // Adjust the BoxFit property as per your requirement
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 15, top: 4),
                        child: Text(
                          // "NIKE XTM Basketball Shoeas",
                          value["title"].toString(),
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        value["usertype"].toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "₹" + value["price"].toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      value["qty"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.transparent,
            height: 45,
            width: 50,
             margin: EdgeInsets.only(top: 15),

            child: Stack(
              children:[
                Positioned(
                  top: 5,
                  left: 8,
                  bottom: 5,
                  // right: 1,
                  child: Container(
                    color: Colors.blue,
                    height: 25,
                    width: 30,
                    padding: EdgeInsets.only(left: 5,right: 5),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var cid = value["cart_id"].toString();
                    print(cid);
                    Uri uri = Uri.parse(UrlResource.DELETECART);
                    var response = await http.post(uri, body: {"cart_id": cid});
                    if (response.statusCode == 200) {
                      var body = response.body.toString();
                      print(body);
                      var json = jsonDecode(body);
                      print("test");
                      if (json["status"] == "true") {
                        print("demo test");
                        var msg = json["message"].toString();
                        print(msg);
                        var dprice = json["data"][0]["price"].toString();
                        print("dprice = ${dprice}");
                        print("object");
                        setState(() {
                          totalcart = 0;
                          fnprice = int.parse(fnprice.toString()) - int.parse(dprice);
                          print("final price = ${fnprice}");
                        });

                        // Navigator.of(context).pop();
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context)=>CustomNavigationBar())
                        // );
                        updateData();

                      } else {
                        print("demo");
                        var msg = json["message"].toString();
                        print(msg);
                      }
                    } else {
                      print("error");
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    //size: 15,
                  ),
                ),
              ]
            ),
          ),
        )


    ],
    );
  }
}
