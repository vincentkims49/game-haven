// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../model/game_details_model.dart';
import '../model/game_model.dart';

class GameApiService {
  final Dio dio = Dio();
  // get your own api key from https://rapidapi.com/accujazz/api/rawg-video-games-database
  String rapidApiAppKey = 'RAPID_API_APP_KEY';

  Future<List<Game>> fetchGameData() async {
    try {
      final response = await dio.get(
        'https://api.rawg.io/api/games?key=$rapidApiAppKey&page=1',
      );
      if (response.statusCode == 200) {
        final List<Game> games = (response.data['results'] as List<dynamic>)
            .map((json) => Game.fromJson(json))
            .toList();

        return games; // Return the list of games
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to fetch games');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to fetch games');
    }
  }

  Future<GameSpecificDetails?> fetchGameDetails(
      {required String gameName}) async {
    try {
      final response = await dio.get(
        'https://api.rawg.io/api/games/$gameName?key=$rapidApiAppKey',
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> gameDetailsMap = response.data;
        final GameSpecificDetails gameDetails =
            GameSpecificDetails.fromJson(gameDetailsMap);
        print('Game Details: $gameDetails');
        return gameDetails;
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to fetch game details');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to fetch game details');
    }
  }
}
