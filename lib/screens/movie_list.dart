// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../helper/mdb_helper.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result = "";

  MdbHelper helper = MdbHelper();
  int? moviesCount;

  List movies = [];
  final String imageBase = 'https://image.tmdb.org/t/p/w500/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('MOVIO');

  @override
  void initState() {
    helper = MdbHelper();
    initialize();
    super.initState();
  }

  Future search(text) async {
    movies = (await helper.findMovies(text));
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    movies = [];
    movies = (await helper.getUpcoming());
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0x44000000),
          elevation: 10.0,
          title: searchBar,
          actions: <Widget>[
            IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (visibleIcon.icon == Icons.search) {
                    visibleIcon = const Icon(Icons.cancel);
                    searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (String text) {
                        search(text);
                      },
                    );
                  } else {
                    setState(() {
                      visibleIcon = const Icon(Icons.search);
                      searchBar = const Text('MOVIO');
                    });
                  }
                });
              },
            ),
          ]),
      body: CustomScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverGrid.builder(
                itemCount: (moviesCount == null) ? 0 : moviesCount,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 1000),
                itemBuilder: (BuildContext context, int position) {
                  if (movies[position].posterPath != "") {
                    image =
                        NetworkImage(imageBase + movies[position].posterPath);
                  } else {
                    image = NetworkImage(defaultImage);
                  }
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: image,
                              fit: BoxFit.fitWidth,
                              opacity: 400)),
                      child: GestureDetector(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (_) => MovieDetail(movies[position]));
                          Navigator.push(context, route);
                        },
                        child: Image(image: image, fit: BoxFit.scaleDown),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
