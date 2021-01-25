import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:euclid/amplifyconfiguration.dart';
import 'package:euclid/models/movies.dart';

class AmplifyService {
  static final _amplify = Amplify();
  static final AmplifyAPI _api = AmplifyAPI();

  static void configureAmplify() async {
    try {
      await _amplify.addPlugin(apiPlugins: [_api]);
      await _amplify.configure(amplifyconfig);
    } catch (e) {
      print('Could not configure Amplify ☠️' + e);
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    String graphQLDocument = '''query ListMovies {
      listMovies {
        items {
          id
          title
          release
          tags
          writers
          stars
          director
          image
        }
        nextToken
      }
    }''';

    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
      document: graphQLDocument,
    ));

    var response = await operation.response;
    Map data = jsonDecode(response.data);
    List<Movie> movies = data['listMovies']['items'].map<Movie>((movie) => Movie.fromJson(movie)).toList();
    return movies;
  }
}
