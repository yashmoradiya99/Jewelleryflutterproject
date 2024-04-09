import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jewelleryapp/resource/UrlResource.dart';

class viewgallery extends StatefulWidget {
  const viewgallery({super.key});

  @override
  State<viewgallery> createState() => _viewgalleryState();
}

class _viewgalleryState extends State<viewgallery> {
  var imgurl = UrlResource.galleryimg;
  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    Uri uri = Uri.parse(UrlResource.VIEWGALLERY);
    print(uri);
    var responce = await http.post(uri, body: {});
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var body = responce.body.toString();
      print(body);
      var json = jsonDecode(body);
      return json["data"];
      // print("json =${json["data"]}");
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    alldata = getdata();
  }

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
              padding: const EdgeInsets.only(left: 80),
              child: Text("GALLERY",style: TextStyle(color:Colors.white),),
            ),

          ),
        ),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, shnapshot) {
          if (shnapshot.hasData) {
            if (shnapshot.data!.length <= 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(

                itemCount: shnapshot.data!.length,
                itemBuilder: (context, index) {
                  // return Text(shnapshot.data![index]["cat_name"].toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                                  height: 300,
                                  child: Image.network(
                                    imgurl +
                                        shnapshot.data![index]["img_url"]
                                            .toString(),

                                    // height: 200,
                                    // width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  shnapshot.data![index]["title"]
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
