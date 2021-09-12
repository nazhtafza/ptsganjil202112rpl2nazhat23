import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pts_flutter/movie_model.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    loadFromJson();
  }

  bool isloading = true;
  late MovieModel movieModel;

  void loadFromJson() async {
    final res = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=4cc9954b6c2466d06920074bdb58f0dc"));
    if (res.statusCode == 200) {
      // ignore: avoid_print
      print("hasil" + res.body.toString());
      movieModel = MovieModel.fromJson(json.decode(res.body.toString()));
      setState(() {
        isloading = false;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        "Selamat Datang, Nazhat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Jelajahi film baru sekarang!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 6),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    Container(
                      height: 690.2,
                      width: 400,
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: movieModel.results.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://image.tmdb.org/t/p/w500" +
                                                          movieModel
                                                              .results[index]
                                                              .posterPath,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          "assets/felm.png",
                                                          height: 100),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    movieModel
                                                        .results[index].title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(height: 3),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(Icons.people),
                                                      Text(
                                                        '${movieModel.results[index].popularity}',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ),
                  ],
                ),
              ));
  }
}
