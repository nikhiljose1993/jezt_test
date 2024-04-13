import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/model/movie_data_modal.dart';

class MovieDataNotifier extends StateNotifier<List<Movie>> {
  MovieDataNotifier() : super([]);

  Future<String> fetchMovies(String searchString) async {
    final apiKey = dotenv.env['MOVIE_API_KEY'];

    late var response;

    try {
      response = await http.get(
          Uri.parse('https://www.omdbapi.com/?s=$searchString&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['Response'] == 'False') {
          state = [];
          return 'false';
        } else {
          final movies = (jsonData['Search'] as List)
              .map((e) => Movie.fromJson(e))
              .toList();
          state = movies;
          return 'Success';
        }
      } else {
        return 'false';
      }
    } catch (err) {
      return 'false';
    }
  }
}

final movieProvider = StateNotifierProvider<MovieDataNotifier, List<Movie>>(
    (ref) => MovieDataNotifier());
