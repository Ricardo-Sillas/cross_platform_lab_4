class Movies{

  final dynamic id;
  final dynamic title;
  final dynamic overview;
  final dynamic poster_path;
  final dynamic vote_average;

  Movies({required this.id, required this.title, required this.overview, required this.poster_path, required this.vote_average});

  factory Movies.fromJson(Map<String, dynamic> json) {

    return Movies(
      id: json['id'].toString(),
      title: json['title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      vote_average: json['vote_average'].toString()
    );
  }

}