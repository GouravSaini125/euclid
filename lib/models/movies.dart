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

  Movie.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        tags = new List<String>.from(json['tags']),
        director = json['director'],
        writers = new List<String>.from(json['writers']),
        stars = new List<String>.from(json['stars']),
        release = json['release'],
        rating = json['rating'],
        image = json['image'];
}
