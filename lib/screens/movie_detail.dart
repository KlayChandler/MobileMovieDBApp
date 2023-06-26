// ignore_for_file: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/movie.dart';
import '../helper/amc_helper.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;

  const MovieDetail(this.movie, {super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetail> {
  final Movie movie;
  List<String> showtimes = [];
  int? timeCount;

  _MovieDetailState(this.movie);
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  Future initialize() async {
    showtimes = [];
    AmcHelper helper = AmcHelper();
    showtimes = helper.getShowtimes(movie.title);
    setState(() {
      timeCount = showtimes.length;
      showtimes = showtimes;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;
    if (movie.posterPath != "") {
      path = imgPath + movie.posterPath;
    } else {
      path = 'MovieApp.png';
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0x44000000),
          elevation: 10.0,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(movie.title)),
        ),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(path),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.srgbToLinearGamma(),
              opacity: 400,
            )),
          ),
          SingleChildScrollView(
              child: Center(
                  child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  child: Card(
                      elevation: 10,
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        path,
                        height: height / 1.4,
                      ))),
              Container(
                padding: const EdgeInsets.all(10),
                child: Stack(children: <Widget>[
                  Text(
                    movie.overview,
                    textScaleFactor: 1.3,
                    style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Text(
                    movie.overview,
                    textScaleFactor: 1.3,
                    style: const TextStyle(
                        color: Color.fromARGB(218, 255, 255, 255)),
                  ),
                ]),
              ),
              /* ListView.builder(
                  itemCount: (timeCount == null) ? 0 : timeCount,
                  itemBuilder: (BuildContext context, index) {
                    return Card(child: Text(showtimes[index]));
                  }), */
              ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: _launchUrl,
                  child: Text("Check Amazon On Demand for ${movie.title}")),
            ],
          )))
        ]));
  }

  //Method to link out to Amazon onDemand results.
  Future<void> _launchUrl() async {
    Uri url = Uri.parse(
        "https://www.amazon.com/gp/search?ie=UTF8&tag=kaleichandler-20&linkCode=ur2&linkId=d9ff4c8a7be0fbb7b17360fab8aa91ac&camp=1789&creative=9325&index=instant-video&keywords=${movie.title}");
    if (!await launchUrl(url)) {
      throw Exception("Will not work");
    }
  }
}
