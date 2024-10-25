import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/datamodel.dart';

class Firstpage extends StatefulWidget {
  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  PostApi? dataFromAPI;
  _getData() async {
    try {
      String url = "https://dummyjson.com/posts";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = PostApi.fromJson(json.decode(res.body));
        _isloading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 223, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 148, 211),
        title: Text("POST API"),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataFromAPI == null
              ? const Center(
                  child: Text('Failed to load data'),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                      itemCount: dataFromAPI?.posts.length,
                      itemBuilder: (context, index) {
                        final post = dataFromAPI!.posts[index];

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: 500,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.blue, width: 4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Id:${post.id}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Title:${post.title}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Body:${post.body}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Tags:${post.tags}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text("Reactions:${post.reactions}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
    );
  }
}
