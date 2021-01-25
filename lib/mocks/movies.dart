class Movie {
  final String id;
  final String title;
  final String image;
  final List<String> tags;
  final String director;
  final List<String> writers;
  final List<String> stars;
  final String release;
  final double rating;

  Movie(this.id, this.title, this.image, this.tags, this.director, this.writers,
      this.stars, this.release, this.rating);

  static Future<List<Movie>> fetchMovies() async {
    var ids = [
      "i8-iSWGWo0M",
      "5kCZHPJTABw",
      "hqSyIY_orAc",
    ];
    var titles = [
      "Joker",
      "Maleficent: Mistress of Evil",
      "The Addams Family",
    ];
    var images = [
      "https://cdn.shopify.com/s/files/1/0969/9128/products/Joker_-_Put_On_A_Happy_Face_-_Joaquin_Phoenix_-_Hollywood_English_Movie_Poster_3_de5e4cfc-cfd4-4732-aad1-271d6bdb1587.jpg?v=1579504979",
      "https://images-na.ssl-images-amazon.com/images/I/71p4aRJxctL._AC_SL1333_.jpg",
      "https://m.media-amazon.com/images/M/MV5BODBjOTAzZmMtNGJkOC00M2M3LWI1MTctZjZlMzdiODBkMzc0XkEyXkFqcGdeQXVyMjM4NTM5NDY@._V1_.jpg",
    ];
    var tags = ["tag 1", "tag 2", "tag 3"];
    var writers = ["John Doe", "John Doe", "John Doe"];
    var stars = ["John Doe", "John Doe", "John Doe"];
    var release = "4 October 2019 (UK)";
    var rating = 4.8;
    var director = "Joen Doe";
    return Future.delayed(
        Duration(seconds: 2),
        () => List<Movie>.generate(
              ids.length,
              (i) => Movie(ids[i], titles[i], images[i], tags, director,
                  writers, stars, release, rating),
            ));
  }
}
