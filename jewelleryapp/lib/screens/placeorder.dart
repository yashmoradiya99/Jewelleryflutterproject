
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/CustomNavigationBar.dart';
import 'package:jewelleryapp/screens/paymentsuccess.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

var formkey = GlobalKey<FormState>();

class placeorder extends StatefulWidget {
  var price ;
  placeorder({super.key,this.price});

  @override
  State<placeorder> createState() => _placeorderState();
}

class _placeorderState extends State<placeorder> {
  Future<List<dynamic>?>? alldata1;
  List<dynamic> cityData = [];

  Razorpay _razorpay = Razorpay();

  var city = "3";

  Future<List<dynamic>?>? getcitydata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("object");
    Uri uri = Uri.parse(UrlResource.CITY);
    print(uri);
    var responce = await http.get(uri, headers: {});
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      setState(() {
        cityData = json["data"];
      });
      // print("json =${json["data"]}");
    } else {
      print("error");
    }
  }

  Future<List<dynamic>?>? alldata2;
  List<dynamic> offerData = [];
  var offer = null;
  List<String?> specificFields = [];
  List<String?> specificFieldsdis = [];
  var discount;
  Future<List<dynamic>?>? getofferdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("object");
    Uri uri = Uri.parse(UrlResource.OFFER);
    print(uri);
    var responce = await http.get(uri, headers: {});
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      setState(() {
        offerData = json["data"];
      });

      offerData!.forEach((item) {
        print("demo");
        var specificField = item["coupon"];
        specificFields.add(specificField);
        discount = item["discount"];
        specificFieldsdis.add(discount);
        print("specificField = ${specificField}");
        print("discount = ${discount}");
      });

      return offerData;
      print("json =${json["data"]}");
    } else {
      print("error");
    }
  }

  Future<List<dynamic>?>? alldata3;
  List cartdata = [];

  Future<List<dynamic>?>? getcartdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });
    print("uid = ${uid}");
    print("object");
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
      // setState(() {
      //   offerdata =  json["data"];
      // });
      // print("json =${json["data"]}");
      return json["data"];
    } else {
      print("error");
    }
  }

  var uid, name, email, contact;

  checkpro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
      name = prefs.getString("username").toString();
      email = prefs.getString("useremail").toString();
      contact = prefs.getString("usercontact").toString();
    });
  }

  var finalamount = 0.0;
  var pid;
  TextEditingController addresh = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pincode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkpro();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    setState(() {
      alldata1 = getcitydata();
    });

    setState(() {
      alldata2 = getofferdata();
    });

    alldata3 = getcartdata();
    alldata3?.then((data) {
      print("object1111");
      data?.forEach((row) {
        print("test");
        finalamount = finalamount +
            (double.parse(row["qty"].toString()) *
                double.parse(row["price"].toString()));
        pid = row["jewellery_id"].toString();

        print("amount : " + row["price"].toString());
        print("qty : " + row["qty"].toString());
        print("final amount : " + finalamount.toString());
      });
      finalamount = finalamount.roundToDouble(); // Round the final amount
    });
  }

  var orderid;
  double discountedTotal = 0.0;
  void _handlePaymentSuccess(PaymentSuccessResponse paymentresponse) async {
    // Do something when payment succeeds

    var add = addresh.text.toString();
    var lan = landmark.text.toString();
    var pin = pincode.text.toString();
    var cityid = city.toString();
    // var offerid = offer.toString();

    var offerid;
    // if (offer == null) {
    //   setState(() {
    //     offerid = offer!["offer_id"].toString();
    //   });
    // } else {
    //   setState(() {
    //     offerid = offerData![0]["offer_id"].toString();
    //   });
    // }

    print(add);
    print(lan);
    print(pin);
    print("cityid = ${cityid}");
    print("offerid = ${offerid}");

    print("aa = ${paymentresponse.paymentId}");
    print("aa = ${paymentresponse.orderId}");
    print("aa = ${paymentresponse.signature}");
    setState(() {
      orderid = paymentresponse.paymentId;
    });
    // print(pw);

    Map<String, dynamic> prafm = {
      "address": add,
      "landmark": lan,
      "pincode": pin,
      "status": "Done",
      "is_pay": "Yes",
      "city_id": cityid,
      "t_number": paymentresponse.paymentId,
      "user_id": uid,
      "offer_id": offerData![0]["offer_id"].toString(),
      "total_payment": finalamount.toString(),
      "discount": discountedTotal.toString(),

      // "productid":pid.toString()
    };
    print("data = ${prafm}");
    Uri uri = Uri.parse(UrlResource.ORDER);
    var responce = await http.post(uri, body: prafm);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      if (json["status"] == "true") {
        print("Payment successfully");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => paymentsucess(oid: orderid.toString(),)));
      } else {
        print("not Payment");
      }
    } else {
      print("api error");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fails");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("Wallet Error");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

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
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text("CART PAGE", style: TextStyle(color: Colors.white),),
            ),

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Image.asset("img/logo.png",height: 300, width: 300,),
            SizedBox(height: 100,),
            Container(
              padding: EdgeInsets.all(30),
              // margin: EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    // Text("test"+widget.price.toString()),
                    TextFormField(
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "Please Enter Addresh";
                        }
                        return null;
                      },
                      controller: addresh,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
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
                        hintText: "Enter Addressh",
                        labelText: "Address",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),

                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "Please Enter LandMark";
                        }
                        return null;
                      },
                      controller: landmark,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pin_drop),
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
                        hintText: "Enter LandMark",
                        labelText: "LandMark",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (val) {
                        if (val!.length <= 0) {
                          return "Please Enter Number";
                        }
                        else if (val.length != 6) {
                          return "Please Enter Valid no";
                        }
                        return null;
                      },
                      maxLength: 6,
                      controller: pincode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pin),
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
                        hintText: "Enter Pincode",
                        labelText: "Pin Code",
                        labelStyle: TextStyle(color: Colors.black),

                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      // width: 10,
                      // decoration: BoxDecoration(
                      //   border:
                      //   Border.all(width: 1, color: Colors.white),
                      //   borderRadius:
                      //   const BorderRadius.all(Radius.circular(50)),
                      // ),
                      height: 65,
                      width: 340,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xff546e7a)
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.location_city_sharp),
                          SizedBox(width: 10,),
                          Text("City Name :", style: TextStyle(
                              color: Colors.black, fontSize: 15),),
                          Expanded(
                            child: cityData.isNotEmpty
                                ? DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "Select City",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                              // dropdownColor: Color(0xffa4469c),
                              value: city == null ||
                                  city
                                      .toString()
                                      .isEmpty
                                  ? null
                                  : city,

                              items: cityData.map((value) {
                                return DropdownMenuItem(
                                  value: value["city_id"],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black, // Border color
                                          // width: 2.0, // Border width
                                        ),
                                      ),
                                    ),
                                    width: 130,
                                    child: Text(
                                      value["city_name"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );

                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  city = val!.toString();
                                  print(city);
                                });
                              },
                            )
                                : Container(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    (offer == null) ? Container(
                      // width: 30,
                      // decoration: BoxDecoration(
                      //   border:
                      //   Border.all(width: 1, color: Colors.white),
                      //   borderRadius:
                      //   const BorderRadius.all(Radius.circular(50)),
                      // ),
                      height: 65,
                      width: 340,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xff546e7a)
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.location_city_sharp),
                          SizedBox(width: 10,),
                          Text("Offer Name :"),
                          Expanded(
                            child: offerData!.isNotEmpty
                                ? DropdownButtonFormField(
                              value: offer == null || offer!.isEmpty ? null : offer,
                              decoration: InputDecoration(
                                hintText: "Select offer",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                              hint: Text(
                                "Select Offer",
                                style: TextStyle(color: Colors.grey),
                              ),
                              items: offerData!.map((value) {
                                print(value["discount"]);

                                return DropdownMenuItem(
                                  value: value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black, // Border color
                                          // width: 2.0, // Border width
                                        ),
                                      ),
                                    ),
                                    width: 130,
                                    child: Text(
                                      value["title"] + "    " + value["discount"] + "%",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  offer = value!;
                                  print("offer = ${offer}");
                                  discountedTotal = finalamount; // Initialize with the original total

                                  if (offer != null) {
                                    // Apply the discount if an offer is selected
                                    setState(() {
                                      print("price = ${offer["discount"]}");
                                      double discount = double.parse(offer["discount"].toString());
                                      discountedTotal -= (discount / 100) * finalamount;
                                      print("test data = ${discountedTotal}");
                                      finalamount = discountedTotal;
                                    });
                                  }
                                });
                              },
                            )
                                : Container(),
                          ),
                        ],
                      ),
                    ) : Container(),


                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: () {
                      if (formkey.currentState!.validate()) {
                        var options = {
                          'key': 'rzp_test_hdkvBuBbG18tVE',
                          // rzp_test_t2F4QxEnOl9c0d
                          // rzp_test_8Ku0hxAhaDb9it
                          'amount': finalamount.toInt() * 100,
                          'name': 'Dream Jewels.',
                          'description': 'YOUR DREAM, OUR MASTERPIECES',
                          'prefill': {
                            'contact': contact,
                            'email': email
                          }
                        };

                        _razorpay.open(options);
                      };
                    },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff546e7a),
                          minimumSize: Size(200, 50),
                        ),

                        child: Text("Place Order ₹ ${finalamount.toInt()}")),
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
