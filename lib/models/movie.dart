class Movie {
  int? id;
  String title = "";
  String releaseDate = "";
  String overview = "";
  String posterPath = "";

  Movie(this.id, this.title, this.releaseDate, this.overview, this.posterPath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    releaseDate = parsedJson['release_date'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
  }
}
