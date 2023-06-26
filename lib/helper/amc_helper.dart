// ignore_for_file: avoid_print

import "package:universal_html/html.dart";
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AmcHelper {
  final String urlKey = 'api_key=2D291F93-026B-4EB5-B66C-050D54A77593';
  final String urlBase = 'https://api.sandbox.amctheatres.com/';
  final String urlMovie = '/v2/theatres/610/showtimes';

  ///2-24-17/?movie=';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=e3fd37e8dd3eca6eecb8808906be73bc&query=';

  List<String> timeList = List.empty();
  AmcHelper();

  Future<List> getShowtimesHelper(String title) async {
    String formated = title.replaceAll(' ', '-');
    final String call = urlBase + urlMovie; // + formated;
    http.Response result = await http.get(Uri.parse(call));

    if (result.statusCode == HttpStatus.ok) {
      var jsonResponce = json.decode(result.body);
      List times = jsonResponce["showDateTimeLocal"];
      return times;
    } else {
      return List.empty();
    }
  }

  List<String> getShowtimes(String title) {
    getShowtimesHelper(title);
    List<String> times = timeList;
    return times;
  }
}
