import 'package:euclid/mocks/movies.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 2.2 / 2,
            bottom: 50.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.2 / 2 + 20,
              ),
              Text(
                movie.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getTags(),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            "Director",
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            "Writers",
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 100.0,
                        child: Center(
                          child: Text(
                            "Stars",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            movie.director,
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            movie.writers.join(", "),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            movie.stars.join(", "),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Release Date : ${movie.release}",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              movie.image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2.2,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getTags() {
    return movie.tags
        .map((tag) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
                child: Text(
                  "Tag 1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ))
        .toList();
  }
}
