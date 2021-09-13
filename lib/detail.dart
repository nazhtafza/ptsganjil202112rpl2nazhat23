import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pts_flutter/movie_model.dart';

class Detail extends StatelessWidget {
  final Result movie;

  const Detail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(movie.releaseDate);

    return Scaffold(
      body: Stack(children: [
        Image.network(
          'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 670,
              padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(formatted,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(height: 10),
                    Text(movie.overview, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
