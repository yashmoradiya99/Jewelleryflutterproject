
import 'dart:convert';
import 'dart:io'; // Importing File class from dart:io
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/viewreview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Review extends StatefulWidget {
  var jid;

  Review({Key? key, required this.jid}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  File? uploadImage;

  TextEditingController review = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var uid;
  Future<List<dynamic>?>? alldata;

  var ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Container(
          decoration: BoxDecoration(
            color:Color(0xff546e7a) ,

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
              child: Text("REVIEW",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 0),
//             child: Column(
//               children: [
//                 Text(
//                   "What is your rate ?",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 RatingBar.builder(
//                   initialRating: 0,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                   itemBuilder: (context, _) => Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     setState(() {
//                       ratingValue = rating;
//                     });
//                     print(rating);
//                   },
//                 ),
//                 SizedBox(
//                   height: 90,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20, right: 20),
//                   child: Text(
//                     "Please share your opinion about the jewellery",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   maxLines: 4,
//                   controller: review,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.amber),
//                     ),
//                     hintText: "Your review",
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Column(
//                   children: <Widget>[
//                     uploadImage == null
//                         ? Container()
//                         : SizedBox(
//                             height: 150,
//                             child: Image.file(uploadImage!),
//                           ),
//                     ElevatedButton.icon(
//                       onPressed: () async {
//                         AlertDialog alert = AlertDialog(
//                           title: Text("Select Image"),
//                           actions: [
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   final ImagePicker picker = ImagePicker();
// // Pick an image.
//                                   final XFile? image = await picker.pickImage(
//                                       source: ImageSource.gallery);
//
//                                     setState(() {
//                                       uploadImage = File(image!.path);
//                                     });
//
//                                     // List<int> imageBytes = uploadImage!.readAsBytesSync();
//                                     // String base64Image = base64Encode(imageBytes);
//                                     //
//                                     // print("base = ${base64Image}");
//                                     //
//                                     // SharedPreferences prefs =await SharedPreferences.getInstance();
//                                     // var id = prefs.getString("userid").toString();
//                                     //
//                                     // var url=Uri.parse(UrlResource.IMAGEUPLOAD);
//                                     // var response = await http.post(url,body: {
//                                     //   "id":id,
//                                     //   "profile":base64Image
//                                     // });
//                                     //
//                                     // if(response.statusCode==200)
//                                     // {
//                                     //   var body = response.body.toString();
//                                     //   if(body!="no")
//                                     //   {
//                                     //     prefs.setString("photo", body)
//                                     //         .toString();
//                                     //
//                                     //     print("photo add");
//                                     //
//                                     //     // getdata();
//                                     //   }
//                                     // }
//
//
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text("Gallery")),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   final ImagePicker picker = ImagePicker();
// // Pick an image.
//                                   final XFile? image = await picker.pickImage(
//                                       source: ImageSource.camera);
//                                   setState(() {
//                                     uploadImage = File(image!.path);
//                                   });
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text("Camera"))
//                           ],
//                         );
//                         showDialog(context: context, builder: (context){
//                           return alert;
//                         });
//                       },
//                       // onPressed: chooseImage,
//                       icon: Icon(Icons.folder_open),
//                       label: Text("CHOOSE IMAGE"),
//                     ),
//                     // ElevatedButton.icon(
//                     //   onPressed: () async {
//                     //     // await uploadImageToServer();
//                     //   },
//                     //   icon: Icon(Icons.file_upload),
//                     //   label: Text("UPLOAD IMAGE"),
//                     // ),
//                   ],
//                 ),
//                 ElevatedButton(
//                     onPressed: () async {
//                       var rev = review.text.toString();
//                       print(rev);
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       uid = prefs.getString("userid").toString();
//                       print("uid " + uid);
//                       Uri reviewUri = Uri.parse(UrlResource.REVIEW);
//                       print(reviewUri);
//                       print(widget.jid);
//                       print(rev);
//                       print(ratingValue);
//                       // Inside the onPressed function of the Submit button
//                       var reviewResponse = await http.post(reviewUri, body: {
//                         "user_id": uid,
//                         "jewellery_id": widget.jid,
//                         "review_text": rev,
//                         "rating": ratingValue.toString(),
//                       });
//                       if (reviewResponse.statusCode == 200) {
//                         var reviewBody = reviewResponse.body.toString();
//                         print(reviewBody);
//                         var reviewJson = jsonDecode(reviewBody);
//                         print("test");
//                         if (reviewJson["status"] == "true") {
//                           var msg = reviewJson["message"].toString();
//                           var reviewId = reviewJson["review_id"]; // Extract the review ID
//                           print(msg);
//
//                           // Call IMAGEUPLOAD API after successful review submission
//                           if (uploadImage != null) {
//                             var imageBytes = uploadImage!.readAsBytesSync();
//                             String base64Image = base64Encode(imageBytes);
//                             var imageUri = Uri.parse(UrlResource.IMAGEUPLOAD);
//                             var imageResponse = await http.post(imageUri, body: {
//                               "id": reviewId.toString(), // Pass the review ID instead of UID
//                               "profile": base64Image.toString(),
//                             });
//
//                             if (imageResponse.statusCode == 200) {
//                               var imageBody = imageResponse.body.toString();
//                               if (imageBody != "no") {
//                                 prefs.setString("photo", imageBody).toString();
//                                 print("photo add");
//                               }
//                             }
//                           }
//
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => viewreview()));
//                         } else {
//                           print("demo");
//                           var msg = reviewJson["message"].toString();
//                           print(msg);
//                         }
//                       } else {
//                         print("error");
//                       }
//
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Color(0xff546e7a),
//                       onPrimary: Colors.white,
//                       minimumSize: Size(280, 50),
//                     ),
//                     child: Text("Submit"))
//
//               ],
//             ),
//           ),
//         )
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
                            .height / 1.9,
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
                                "ADD REVIEW",
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
                                validator: (val){
                                  if(val!.length<=0)
                                  {
                                    return "Please Enter Comment";
                                  }
                                  return null;
                                },
                                controller: review,
                                maxLines: 4,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.comment),
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
                                  hintText: "Enter Review",
                                  labelText: "Review",
                                  labelStyle: TextStyle(color: Colors.black),

                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                          RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                    print(rating);
                  },
                ),
                              const SizedBox(
                                height: 15.0,
                              ),
                          ElevatedButton.icon(
                      onPressed: () async {
                        AlertDialog alert = AlertDialog(
                          title: Text("Select Image"),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
// Pick an image.
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);

                                    setState(() {
                                      uploadImage = File(image!.path);
                                    });
                                  Navigator.of(context).pop();
                                },
                                child: Text("Gallery")),
                            ElevatedButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
// Pick an image.
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    uploadImage = File(image!.path);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text("Camera"))
                          ],
                        );
                        showDialog(context: context, builder: (context){
                          return alert;
                        });
                      },
                      // onPressed: chooseImage,
                      icon: Icon(Icons.folder_open),
                      label: Text("CHOOSE IMAGE"),
                    ),
                              const SizedBox(
                                height: 15.0,
                              ),
                ElevatedButton(
                    onPressed: () async {
    if(formkey.currentState!.validate()) {
      var rev = review.text.toString();
      print(rev);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uid = prefs.getString("userid").toString();
      print("uid " + uid);
      Uri reviewUri = Uri.parse(UrlResource.REVIEW);
      print(reviewUri);
      print(widget.jid);
      print(rev);
      print(ratingValue);
      // Inside the onPressed function of the Submit button
      var reviewResponse = await http.post(reviewUri, body: {
        "user_id": uid,
        "jewellery_id": widget.jid,
        "review_text": rev,
        "rating": ratingValue.toString(),
      });
      if (reviewResponse.statusCode == 200) {
        var reviewBody = reviewResponse.body.toString();
        print(reviewBody);
        var reviewJson = jsonDecode(reviewBody);
        print("test");
        if (reviewJson["status"] == "true") {
          var msg = reviewJson["message"].toString();
          var reviewId = reviewJson["review_id"]; // Extract the review ID
          print(msg);

          // Call IMAGEUPLOAD API after successful review submission
          if (uploadImage != null) {
            var imageBytes = uploadImage!.readAsBytesSync();
            String base64Image = base64Encode(imageBytes);
            var imageUri = Uri.parse(UrlResource.IMAGEUPLOAD);
            var imageResponse = await http.post(imageUri, body: {
              "id": reviewId.toString(), // Pass the review ID instead of UID
              "profile": base64Image.toString(),
            });

            if (imageResponse.statusCode == 200) {
              var imageBody = imageResponse.body.toString();
              if (imageBody != "no") {
                prefs.setString("photo", imageBody).toString();
                print("photo add");
              }
            }
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => viewreview()));
        } else {
          print("demo");
          var msg = reviewJson["message"].toString();
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
                      minimumSize: Size(280, 50),
                    ),
                    child: Text("Submit"))
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
