import 'dart:convert';
import 'package:finale/model/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MoviesWidget extends StatelessWidget {

  List<Movies> movies;
  int counter;
  String url = '';

  MoviesWidget({required this.movies, required this.counter});

  @override
  Widget build(BuildContext context) {

    final movie = movies[counter];
    return SafeArea(
      child: SingleChildScrollView(
        child: ListTile(
          title: Column(
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LibreBaskerville',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 300,
                child: Image.network(
                    'http://image.tmdb.org/t/p/w780/${movie.poster_path}'),
              ),
              const SizedBox(height: 25),
              Text(
                movie.overview,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Rating:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBar.builder(
                initialRating: double.parse(movie.vote_average) / 2.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                ignoreGestures: true,
                itemBuilder: (context, _) =>
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                child: const SizedBox(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Launch Website',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onPressed: () async {
                  url = await _getLink(
                      'https://api.themoviedb.org/3/movie/${movie
                          .id}?api_key=6d08073b66c9a1bec890b6d8e08f8684&language=en-US');
                  _launchURL();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Used to get link of movies homepage
  Future<String> _getLink(String link) async {

    var a = Uri.parse(link);
    var response = await http.get(a);
    var info = jsonDecode(response.body);
    var home = info['homepage'];
    return home;
  }

  /// Used to redirect to movies homepage
  _launchURL() async {

    if (url == '') {
      url =
      'https://www.google.com/search?client=firefox-b-1-d&q=movies+showing+in+el+paso';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
