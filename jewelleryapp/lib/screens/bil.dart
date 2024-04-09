import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';


class bil extends StatefulWidget {
  var oid;

  bil({Key? key, this.oid}) : super(key: key);

  @override
  State<bil> createState() => _bilState();
}

class _bilState extends State<bil> {

  double totalPrice = 0;
  Map<String, dynamic> items = {
    "total_payment":
    "price"
        "qty"
  };


  double finalprice = 0;
  var qty = 0;
  double discount = 0;

  getTotalPrice() {
    double discountPercentage = 0.1;
    print("demo");
    print("itemData length: ${itemData.length}");
    for (var row in itemData) {
      print("test demo");
      setState(() {
        totalPrice = totalPrice +
            (double.parse(row["qty"].toString()) *
                double.parse(row["price"].toString()));
        qty = qty + int.parse(row["qty"].toString());
        print("qty123 = ${qty}");
      });

      setState(() {
        discount = totalPrice * discountPercentage;
        print("dis = ${discount}");

        finalprice = totalPrice - discount;
        print("fprice = ${finalprice}");
      });
      print("amount : " + row["price"].toString());
      print("qty : " + row["qty"].toString());
      print("final amount : " + totalPrice.toString());
    }
  }


  int getTotalQuantity() {
    int totalQuantity = 0;
    items.forEach((key, value) {
      // totalQuantity += value['quantity'];
    });
    return totalQuantity;
  }

  // double getTotalPayment() {
  //   // Assuming a fixed tax rate of 10%
  //   double taxRate = 0.1;
  //   double totalPayment = getTotalPrice() * (1 + taxRate);
  //   print(totalPayment);
  //   return totalPayment;
  // }


  var imgurl = UrlResource.jwlimg;
  var uid, name, email, contact;
  GlobalKey _globalKey = GlobalKey();
  Future<List<dynamic>?>? alldata;

  List<dynamic> itemData = [];
  List<dynamic> orderData = [];

  Future<List<dynamic>?>? getdata() async {
    print("oid:${widget.oid}");
    Uri uri = Uri.parse(UrlResource.BIL);
    print(uri);
    print(widget.oid);
    var response = await http.post(uri, body: {
      "order_id": widget.oid,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      print(body);
      var json = jsonDecode(body);
      // return json["data"];
    setState(() {
      orderData = json["data"];
      itemData = json["items"];
    });
      print("order = ${orderData}");
      print("itemData = ${itemData}");
    } else {
      print("error");
    }
  }



  int _currentIndex = 0;

  checkpro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
      name = prefs.getString("username").toString();
      email = prefs.getString("useremail").toString();
      contact = prefs.getString("usercontact").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    alldata = getdata();
    alldata!.then((_) {
      getTotalPrice();
    });
    getTotalQuantity();
    checkpro();
  }


  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Future<void> _saveAsPdf(Uint8List bytes) async {
  //   final pdfDoc = pw.Document();
  //
  //   pdfDoc.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Image(pw.MemoryImage(bytes)),
  //         );
  //       },
  //     ),
  //   );
  //
  //   final output = await getExternalStorageDirectory();
  //   final file = File("${output!.path}/example.pdf");
  //   await file.writeAsBytes(await pdfDoc.save());
  //
  //   // Save the PDF to the gallery
  //   await GallerySaver.saveImage(file.path, albumName: 'PDFs');
  // }
  Future<void> _saveAsPdf(Uint8List bytes) async {
    final pdfDoc = pw.Document();

    pdfDoc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(bytes)),
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    // final file = File("${output!.path}/example.pdf");
    // await file.writeAsBytes(await pdfDoc.save());
    final file = File("${output!.path}/bill.pdf");
    await file.writeAsBytes(await pdfDoc.save());

    OpenFile.open(file.path);
    print('PDF saved to ${file.path}');
    // Show a message indicating that the PDF has been saved
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF saved to ${file.path}'),
    ));
  }

  Future<void> _saveScreenshot() async {
    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }
    Uint8List? pngBytes = await _capturePng();
    if (pngBytes != null) {
      await _saveAsPdf(pngBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Dream Jewels",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: Column(
            children: [
              Column(
                children: itemData.map<Widget>((value) {
                  // DateTime orderDateTime = DateTime.parse(value["order_date_time"]);
                  // print("odate = ${orderDateTime}");
                  // // Add 5 days to orderDateTime
                  // DateTime deliveryDateTimeThreshold = orderDateTime.add(Duration(days: 5));
                  // print("deliveryDateTimeThreshold = ${deliveryDateTimeThreshold}");
                  // // Parse delivery_date_time to DateTime object
                  // DateTime deliveryDateTime = DateTime.parse(value["delivery_date_time"]);
                  // print("deliveryDateTime = ${deliveryDateTime}");
                  // // Check if deliveryDateTime is after deliveryDateTimeThreshold
                  // bool isDeliveryDelayed = deliveryDateTime.isAfter(deliveryDateTimeThreshold);
                  // print("isDeliveryDelayed = ${isDeliveryDelayed}");
                  // Parse order_date_time to DateTime object
                  DateTime orderDateTime = DateTime.parse(value["order_date_time"]);
                  print("odate = ${orderDateTime}");
                  // Add 5 days to orderDateTime
                  DateTime deliveryDateTimeThreshold = orderDateTime.add(Duration(days: 5));
                  print("deliveryDateTimeThreshold = ${deliveryDateTimeThreshold}");
                  // Parse delivery_date_time to DateTime object
                  DateTime deliveryDateTime = DateTime.parse(value["delivery_date_time"]);
                  print("deliveryDateTime = ${deliveryDateTime}");
                  // Format dates
                  String formattedOrderDateTime = DateFormat('dd/MM/yy').format(orderDateTime);
                  print("formattedOrderDateTime = ${formattedOrderDateTime}");
                  String formattedDeliveryDateTimeThreshold = DateFormat('dd/MM/yy').format(deliveryDateTimeThreshold);
                  print("formattedDeliveryDateTimeThreshold = ${formattedDeliveryDateTimeThreshold}");
                  String formattedDeliveryDateTime = DateFormat("dd/MM/yy").format(deliveryDateTime);
                  // Check if deliveryDateTime is after deliveryDateTimeThreshold
                  bool isDeliveryDelayed = deliveryDateTime.isAfter(deliveryDateTimeThreshold);
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 360,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 10, left: 10),
                                    //   child: Container(
                                    //     width: 70,
                                    //     height: 70,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(15),
                                    //       color: Colors.white,
                                    //       image: DecorationImage(
                                    //         image: NetworkImage(
                                    //             "https://media.istockphoto.com/id/1198714412/photo/bangles-made-of-gold.jpg?s=2048x2048&w=is&k=20&c=NKCGtoAMd6vdjBtnXaLzgCHUuCmqsUutYQ9jUbK230E="),
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Jewellery Details",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                children: [
                                                  // Text(
                                                  //   "Jewellery Name",
                                                  //   style: TextStyle(
                                                  //     fontSize: 18,
                                                  //     fontWeight: FontWeight.normal,
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10, left: 10),
                                                    child: Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: NetworkImage(imgurl+value["img1"].toString(),),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      value["title"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Price",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: Text(
                                                      value["price"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Qty",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      value["qty"].toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "order_date_time",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      // value["order_date_time"].toString(),
                                                      formattedOrderDateTime.toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "delivery_date_time",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      formattedDeliveryDateTimeThreshold.toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              Column(
                children: orderData.map<Widget>((value) {
                  // Parse order_date_time to DateTime object
                  DateTime orderDateTime = DateTime.parse(value["order_date_time"]);
                  print("odate = ${orderDateTime}");
                  // Add 5 days to orderDateTime
                  DateTime deliveryDateTimeThreshold = orderDateTime.add(Duration(days: 5));
                  print("deliveryDateTimeThreshold = ${deliveryDateTimeThreshold}");
                  // Parse delivery_date_time to DateTime object
                  DateTime deliveryDateTime = DateTime.parse(value["delivery_date_time"]);
                  print("deliveryDateTime = ${deliveryDateTime}");
                  // Check if deliveryDateTime is after deliveryDateTimeThreshold
                  bool isDeliveryDelayed = deliveryDateTime.isAfter(deliveryDateTimeThreshold);
                  print("isDeliveryDelayed = ${isDeliveryDelayed}");
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 280,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 10, left: 10),
                                    //   child: Container(
                                    //     width: 70,
                                    //     height: 70,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(15),
                                    //       color: Colors.white,
                                    //       image: DecorationImage(
                                    //         image: NetworkImage(
                                    //             "https://media.istockphoto.com/id/1198714412/photo/bangles-made-of-gold.jpg?s=2048x2048&w=is&k=20&c=NKCGtoAMd6vdjBtnXaLzgCHUuCmqsUutYQ9jUbK230E="),
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "User Details",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Name",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  name ,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  email,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Contact",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  contact,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       "Date Time",
                                          //       style: TextStyle(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: Text(
                                          //         value["order_date_time"]
                                          //             .toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 15,
                                          //           fontWeight: FontWeight.bold,
                                          //         ),
                                          //         textAlign: TextAlign.end,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const Divider(
                                          //   thickness: 1,
                                          //   color: Colors.black,
                                          // ),
                                          Row(
                                            children: [
                                              Text(
                                                "Address",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  value["address"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "City",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  value["city_name"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),

                                          // const Divider(
                                          //   thickness: 3,
                                          //   color: Colors.black,
                                          // ),
                                          // const SizedBox(height: 5),
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       "Total",
                                          //       style: TextStyle(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.normal,
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //       child: Text(
                                          //         "₹" +
                                          //             value["total_payment"]
                                          //                 .toString(),
                                          //         style: TextStyle(
                                          //           fontSize: 16,
                                          //           fontWeight: FontWeight.normal,
                                          //         ),
                                          //         textAlign: TextAlign.end,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              Column(
                children: orderData.map<Widget>((value) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 360,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 10, left: 10),
                                  //   child: Container(
                                  //     width: 70,
                                  //     height: 70,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(15),
                                  //       color: Colors.white,
                                  //       image: DecorationImage(
                                  //         image: NetworkImage(
                                  //             "https://media.istockphoto.com/id/1198714412/photo/bangles-made-of-gold.jpg?s=2048x2048&w=is&k=20&c=NKCGtoAMd6vdjBtnXaLzgCHUuCmqsUutYQ9jUbK230E="),
                                  //         fit: BoxFit.cover,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Payment Details",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Offer Name",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      value["title"].toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Transaction No",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      value["t_number"].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      value["status"].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Qty",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    qty.toString(),
                                                    // value["Total Qty"].toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Price",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    totalPrice.toString(),
                                                    // value["Total price"].toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Discount",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(discount.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              thickness: 3,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Payment",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    // value["total_payment"].toString(),
                                                    finalprice.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveScreenshot();
        },
        tooltip: 'Take Screenshot and Download PDF',
        child: Icon(Icons.save),
      ),
    );
  }
}
