import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:euclid/mocks/movies.dart';
import 'package:euclid/widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoviesExplorer extends StatefulWidget {
  @override
  _MoviesExplorerState createState() => _MoviesExplorerState();
}

class _MoviesExplorerState extends State<MoviesExplorer> {
  String bGImage;

  @override
  void initState() {
    super.initState();
    bGImage =
        "https://cdn.shopify.com/s/files/1/0969/9128/products/Joker_-_Put_On_A_Happy_Face_-_Joaquin_Phoenix_-_Hollywood_English_Movie_Poster_3_de5e4cfc-cfd4-4732-aad1-271d6bdb1587.jpg?v=1579504979";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Image.network(
                bGImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text("Movies"),
                leading: Icon(Icons.arrow_back),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
              ),
              FutureBuilder(
                  future: Movie.fetchMovies(),
                  builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height - 100,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              onPageChanged: (i, _) {
                                setState(() {
                                  bGImage = snapshot.data[i].image;
                                });
                              }),
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => MovieCard(
                            movie: snapshot.data[index],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
