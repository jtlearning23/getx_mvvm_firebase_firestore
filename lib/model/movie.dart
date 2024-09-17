class Movie
{
  String id;
  String title;
  String genre;
  String director;
  String releaseDate;

  Movie({required this.id,required this.title,required this.genre,required this.director, required this.releaseDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'director': director,
      'releaseDate': releaseDate,
    };
  }

  static Movie fromMap(Map<String, dynamic> map, String id) {
    return Movie(
      id: id,
      title: map['title'],
      genre: map['genre'],
      director: map['director'],
      releaseDate: map['releaseDate'],
    );
  }
}