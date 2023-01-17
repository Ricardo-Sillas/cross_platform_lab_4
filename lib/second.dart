import 'dart:convert';
import 'package:finale/widgets/movies_widget.dart';
import 'package:flutter/material.dart';
import 'model/movies.dart';
import 'package:http/http.dart' as http;

class Second extends StatefulWidget {

  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _Second();
}

class _Second extends State<Second> {

  int _counter = 0;

  List<Movies> _movies = <Movies>[];

  /// Uses counter to increment through movies
  void _incrementCounter(int num) {
    if (_counter == 0 && num == -1) {
      setState(() {
        _counter = _movies.length - 1;
      });
    } else if (_counter == _movies.length - 1 && num == 1) {
      setState(() {
        _counter = 0;
      });
    } else {
      setState(() {
        _counter = _counter + num;
      });
    }
  }

  @override
  void initState() {

    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {

    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
    });
  }

  /// Gets all the movies and used information and is put into list
  Future<List<Movies>> _fetchAllMovies() async {

    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=6d08073b66c9a1bec890b6d8e08f8684'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['results'];
      return list.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies.');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Movie App',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MoviesWidget(
                movies: _movies,
                counter: _counter,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Prev',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _incrementCounter(-1);
                      MoviesWidget(
                        movies: _movies,
                        counter: _counter,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    child: const SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _incrementCounter(1);
                      MoviesWidget(
                        movies: _movies,
                        counter: _counter,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
