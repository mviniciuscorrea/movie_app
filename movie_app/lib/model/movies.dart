import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

class Movies {
  Movies({
    required this.moviesByYear,
    required this.total,
  });

  final List<MoviesByYear> moviesByYear;
  final int total;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        moviesByYear: List<MoviesByYear>.from(
            json["moviesByYear"].map((x) => MoviesByYear.fromJson(x))),
        total: json["total"],
      );
}

class MoviesByYear {
  MoviesByYear({
    required this.year,
    required this.movies,
  });

  final int year;
  final int movies;

  factory MoviesByYear.fromJson(Map<String, dynamic> json) => MoviesByYear(
        year: json["year"],
        movies: json["movies"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "movies": movies,
      };
}
