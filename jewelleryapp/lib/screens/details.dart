import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/LoginScreen.dart';
import 'package:jewelleryapp/screens/review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
class details extends StatefulWidget {
  var title;
  var desc;
  var price;
  var spec;
  var user;
  var jid;
  var img1;
  var img2;
  var img3;
  var video;

  details(
      {super.key,
      this.title,
      this.desc,
      this.price,
      this.spec,
      this.user,
      this.jid,
      this.img1,
      this.img2,
      this.img3,
      this.video});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {

  bool isDescriptionExpanded = false;
  bool isSpecificationExpanded = false;

  // late VideoPlayerController controller;
  String videoUrl = UrlResource.jwlvideo;
  var imgurl = UrlResource.jwlimg;
  var qty = "1";
  var uid;

  checkaddcart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });
  }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   _chewieController.dispose();
  //   super.dispose();
  // }
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = VideoPlayerController.network(
  //     UrlResource.jwlvideo.replaceFirst(
  //       RegExp.escape(UrlResource.jwlvideo),
  //       UrlResource.jwlvideo + widget.video,
  //     ),
  //   );
  //   _chewieController = ChewieController(
  //     videoPlayerController: controller,
  //     aspectRatio: 16 / 9,
  //     autoPlay: true,
  //     looping: true,
  //   );
  // }
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      videoUrl + widget.video,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    print("Video URL: ${videoUrl + widget.video}");
    print("Video Player Controller Initialized");

    super.initState();
    checkaddcart();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            title:
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text(
                "DETAILS PAGE", style: TextStyle(color: Colors.white),),
            ),

          ),
        ),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // ... Your other widgets ...

                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Container(
                        height: 800,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            // image: AssetImage("img/j2.png"),
                            // image: NetworkImage('https://picsum.photos/250?image=9'),
                            image: NetworkImage(imgurl + widget.img1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //2nd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            // image: AssetImage("img/j1.png"),
                            // image: NetworkImage('https://picsum.photos/250?image=9'),
                            image: NetworkImage(imgurl + widget.img2),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //3rd Image of Slider
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            // image: NetworkImage('https://picsum.photos/250?image=9'),
                            // image: AssetImage("img/j3.png"),
                            image: NetworkImage(imgurl + widget.img3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Stack(
                        children: [
                          Container(
                            height: 300,
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                // Adjust this based on your video's aspect ratio
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                _controller.play();
                              },
                              icon: Icon(Icons.play_arrow),
                            ),
                          ),
                        ],
                      ),
                    ],
                    options: CarouselOptions(
                      height: 300,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                  // Row(
                  //   children:[
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 50.0),
                  //       child: Container(
                  //       height: 343,
                  //
                  //           margin: EdgeInsets.all(5),
                  //
                  //           child: Image.asset("img/j1.png",fit: BoxFit.cover,)),
                  //     ),
                  //       ],
                  //     ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Container(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                // Text(widget.desc,
                                //     style: TextStyle(color: Colors.grey)),
                                // Text(widget.spec,
                                //     style: TextStyle(color: Colors.grey)),
                                _buildDescriptionWidget(),
                                _buildSpecificationWidget(),
                                Text(widget.user,
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                                Text("₹" +
                                    widget.price,
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    DropdownButton(
                                      onChanged: (val) {
                                        setState(() {
                                          qty = val!;
                                        });
                                      },
                                      value: qty,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Qty : 1"),
                                          value: "1",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 2"),
                                          value: "2",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 3"),
                                          value: "3",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 4"),
                                          value: "4",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 5"),
                                          value: "5",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 6"),
                                          value: "6",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 7"),
                                          value: "7",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 8"),
                                          value: "8",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 9"),
                                          value: "9",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Qty : 10"),
                                          value: "10",
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 160,),
                                    IconButton(onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Review(jid: widget.jid,)));
                                    },
                                        icon: (Icon(
                                          Icons.reviews_outlined, size: 35,)))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      if(prefs.containsKey("islogin"))
                                        {
                                          Uri uri =
                                          Uri.parse(UrlResource.ADDTOCART);
                                          print("uid = ${uid}");
                                          var responce =
                                          await http.post(uri, body: {
                                            "user_id": uid,
                                            "jewellery_id": widget.jid,
                                            "price": widget.price,
                                            "qty": qty,
                                            // "conform":conpas,
                                          });
                                          if (responce.statusCode == 200) {
                                            var body = responce.body.toString();
                                            print(body);

                                            var json = jsonDecode(body);
                                            if (json["status"] == true) {
                                              print("test0");
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
                                            } else {
                                              print("object");
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
                                            }
                                          } else {
                                            print("error");
                                          }
                                        }
                                      else
                                        {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>LoginScreen())
                                          );
                                        }



                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff546e7a),
                                      onPrimary: Colors.white,
                                      minimumSize: Size(280, 50),
                                    ),
                                    child: Text("ADD TO CART")),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          )),
                    ],
                  )

                  // ... Your other widgets ...
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }


  Widget buildDescriptionWidget() {
    final descriptionText = widget.desc;
    final limitedTextLength = 100;
    final isLongDescription = descriptionText.length > limitedTextLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          isDescriptionExpanded
              ? descriptionText
              : (isLongDescription
              ? descriptionText.substring(0, limitedTextLength) + '...'
              : descriptionText),
          textAlign: TextAlign.justify,
        ),
        if (isLongDescription)
          GestureDetector(
            onTap: () {
              setState(() {
                isDescriptionExpanded = !isDescriptionExpanded;
              });
            },
            child: Text(
              isDescriptionExpanded ? 'Read Less' : 'Read More',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }
  Widget _buildDescriptionWidget() {
    final descriptionText = widget.desc;
    final limitedTextLength = 85;
    final isLongDescription = descriptionText.length > limitedTextLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          isDescriptionExpanded
              ? descriptionText
              : (isLongDescription
              ? descriptionText.substring(0, limitedTextLength) + '...'
              : descriptionText),
          textAlign: TextAlign.justify,
        ),
        if (isLongDescription)
          GestureDetector(
            onTap: () {
              setState(() {
                isDescriptionExpanded = !isDescriptionExpanded;
              });
            },
            child: Text(
              isDescriptionExpanded ? 'Read Less' : 'Read More',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSpecificationWidget() {
    final specificationText = widget.spec;
    final limitedTextLength = 85;
    final isLongSpecification = specificationText.length > limitedTextLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specification',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          isSpecificationExpanded
              ? specificationText
              : (isLongSpecification
              ? specificationText.substring(0, limitedTextLength) + '...'
              : specificationText),
          textAlign: TextAlign.justify,
        ),
        if (isLongSpecification)
          GestureDetector(
            onTap: () {
              setState(() {
                isSpecificationExpanded = !isSpecificationExpanded;
              });
            },
            child: Text(
              isSpecificationExpanded ? 'Read Less' : 'Read More',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }
}

