
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelleryapp/resource/UrlResource.dart';
import 'package:jewelleryapp/screens/subcategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  var imgurl = UrlResource.catimg;
  var uid;
  TextEditingController searchController = TextEditingController();
  Future<List<dynamic>?>? alldata;

  Future<List<dynamic>?>? getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("userid");
    });

    print("uid = ${uid}");
    print("object");
    Uri uri = Uri.parse(UrlResource.VIEWCAT);
    print(uri);
    var responce = await http.post(uri);
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

  // Add a function to filter data based on search query
  List<dynamic>? _searchList;

  void _filterSearchResults(String query) {
    List<dynamic> _searchResult = [];
    if (query.isNotEmpty) {
      alldata!.then((data) {
        data!.forEach((item) {
          if (item['cat_name'].toString().toLowerCase().contains(
              query.toLowerCase())) {
            _searchResult.add(item);
          }
        });
        setState(() {
          _searchList = _searchResult;
        });
      });
    } else {
      setState(() {
        _searchList = null;
      });
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
        preferredSize: const Size.fromHeight(60.0),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                "SHOP PAGE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 50,
              width: 400,
              child: TextFormField(
                controller: searchController,
                // Attach TextEditingController to TextFormField
                onChanged: _filterSearchResults,
                // Call search function on text change
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
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
                  hintText: "Enter a search term",
                  labelText: "Search",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: alldata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (_searchList != null) {
                  return _buildGridView(_searchList!);
                } else if (snapshot.hasData && snapshot.data!.length > 0) {
                  return _buildGridView(snapshot.data!);
                }
                return Center(
                  child: Text("No Data"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<dynamic> data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        var value = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  subcategory(
                    id: value["cat_id"].toString(),
                  ),
            ));
          },
          child: Card(
            elevation: 20,
            color: Color(0xff546e7a),
            child: Column(
              children: [
                SizedBox(height: 5),
                Text(
                  value["cat_name"].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5),
                Image.network(
                  imgurl + value["cat_img"],
                  height: 140,
                  width: 220,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

