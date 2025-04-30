import 'package:dio/dio.dart';

class RickAndMortyApi {
  final Dio _dio = Dio();

  Future<List<String>> fetchCharacterEpisodes(int characterId) async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character/$characterId',
      );
      List<dynamic> episodes = response.data['episode'];
      return List<String>.from(episodes);
    } catch (e) {
      print('Ошибка при получении эпизодов: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchEpisodeDetails(
    List<String> episodeUrls,
  ) async {
    try {
      List<Map<String, dynamic>> episodeDetails = [];
      for (var url in episodeUrls) {
        final response = await _dio.get(url);
        episodeDetails.add(response.data);
      }
      return episodeDetails;
    } catch (e) {
      print('Ошибка при получении данных эпизодов: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllEpisodes() async {
    List<Map<String, dynamic>> allEpisodes = [];
    int page = 1;
    bool hasNextPage = true;

    while (hasNextPage) {
      try {
        final response = await _dio.get(
          'https://rickandmortyapi.com/api/episode?page=$page',
        );
        final results = response.data['results'] as List<dynamic>;
        allEpisodes.addAll(results.cast<Map<String, dynamic>>());
        hasNextPage = response.data['info']['next'] != null;
        page++;
      } catch (e) {
        print('Ошибка при получении эпизодов: $e');
        break;
      }
    }

    return allEpisodes;
  }

  Future<List<Map<String, dynamic>>> fetchAllLocations() async {
    List<Map<String, dynamic>> allLocations = [];
    int page = 1;
    bool hasNextPage = true;

    while (hasNextPage) {
      try {
        final response = await _dio.get(
          'https://rickandmortyapi.com/api/location?page=$page',
        );
        final results = response.data['results'] as List<dynamic>;
        allLocations.addAll(results.cast<Map<String, dynamic>>());
        hasNextPage = response.data['info']['next'] != null;
        page++;
      } catch (e) {
        print('Ошибка при получении локаций: $e');
        break;
      }
    }

    return allLocations;
  }
}
